import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_storage;
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riceking/function/appFunction.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

import '../main.dart';

class Auth {
  // I did a phone number authentication but some more reasons i write the in auth page so check it in my_auth_page.dart :- for future reference
  Future<bool> anonymousUser() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return true;
    } on FirebaseException catch (e) {
      print(e.code);
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

class Database {
  Future<bool> setProfile(String uid, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('riceKing')
          .doc(uid)
          .set(data);
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> requestForVendor(Map<String, dynamic> data) async {
    try {
      final regCollection = FirebaseFirestore.instance.collection(
        'vendorRequest',
      );
      await regCollection.doc(data['id']).set(data);
      final userCollection = FirebaseFirestore.instance.collection('riceKing');
      await userCollection.doc(userId).update({'vendorId': 'Pending'});

      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> userSlotRequest(
    String vendorId,
    String bookId,
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      final regCollection = FirebaseFirestore.instance
          .collection('vendors')
          .doc(vendorId)
          .collection('request');
      await regCollection.doc(bookId).delete();
      final userCollection = FirebaseFirestore.instance
          .collection('riceKing')
          .doc(userId);
      await userCollection.collection('waiting').doc(bookId).delete();

      await userCollection.
        collection('notification').doc(bookId).set(data);
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> slotDecline(
    String bookId,
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      final userCollection = FirebaseFirestore.instance
          .collection('riceKing')
          .doc(userId)
          .collection('notification');
      await userCollection.doc(bookId).update(data);

      final slotCollection = FirebaseFirestore.instance.collection(
        'slotRequest',
      );

      await slotCollection.doc(bookId).delete();
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> acceptSlot(Map<String, dynamic> data) async {
    try {
      final vendorCollection = FirebaseFirestore.instance.collection('vendors');
      final res = await vendorCollection.doc(data['vendorId']).get();
      final value = res.data() as Map<String, dynamic>;
      var details = value['userDetails'];

      data = {
        ...data,
        'vendorName': details['businessName'],
        'description': value['description'],
        'VendorUserId': value['userId'],
        'status': 'Pending',
        'otp': Random().nextInt(9000) + 1000,
      };

      final userCollection = FirebaseFirestore.instance
          .collection('riceKing')
          .doc(data['userId']);
      await userCollection.collection('booked').doc(data['bookId']).set(data);


      await userCollection
          .collection('notification')
          .doc(data['bookId'])
          .set({
        'vendorName' : data['vendorName'],
        'time' : data['time'],
        'date' : data['day'],
        'service' : data['service'],
        'reason' : data['reason'],
      });

      await userCollection.collection('waiting').doc(data['bookId']).delete();

      await vendorCollection
          .doc(data['vendorId'])
          .collection('booked')
          .doc(data['bookId'])
          .set(data);

      await vendorCollection
          .doc(data['vendorId'])
          .collection('request')
          .doc(data['bookId'])
          .delete();

      // final slotCollection = FirebaseFirestore.instance.collection(
      //   'slotRequest',
      // );

      // final balanceCollection = FirebaseFirestore.instance.collection('official');
      //
      // final getAmount = await balanceCollection.doc('totalCommission').get();
      //
      // final preAmount = getAmount.data()?['amount'] ?? 0;
      //
      // await balanceCollection.doc('totalCommission').update({
      //   'amount': preAmount + amount
      //   ,
      // });

      // await slotCollection.doc(data['bookId']).delete();
      // AppNotification().send(
      //   data['userId'],
      //   'Slot Conformed!',
      //   'Slot will be Conformed!',
      //   'userHomePage',
      // );
      // AppNotification().send(
      //   value['userId'],
      //   'Slot Conformed!',
      //   'Slot will be Conformed!',
      //   'vendorHomePage',
      // );
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelOrder(Map<String, dynamic> data, String status) async {
    try {
      data = {...data, 'status': status};
      final vendorCollection = FirebaseFirestore.instance.collection('vendors');
      final userCollection = FirebaseFirestore.instance
          .collection('riceKing')
          .doc(data['userId']);
      await userCollection.collection('booked').doc(data['bookId']).set(data);



      await vendorCollection
          .doc(data['vendorId'])
          .collection('booked')
          .doc(data['bookId'])
          .set(data);
      if (status.contains('Vendor')) {
        await userCollection.collection('notification').doc(data['bookId']).set({
          'service':  data['service'],
          'day': data['day'],
          'reason':data['reason'],
          'for': 'decline',
          'vendorName' : data['vendorName'],
        });
        AppNotification().send(
          data['userId'],
          'Slot Cancel!',
          'The slot has been cancelled!',
          'userHomePage',
        );

      }
      if (status.contains('User')) {
        AppNotification().send(
          data['vendorId'],
          'Slot Cancel!',
          'The slot has been cancelled!',
          'vendorHomePage',
        );
      }
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> completeOrder(
    String userId,
    String vendorId,
    String bookId,
      String amount,
  ) async {
    try {
      final vendorCollection = FirebaseFirestore.instance.collection('vendors');
      final userCollection = FirebaseFirestore.instance
          .collection('riceKing')
          .doc(userId);
      await userCollection.collection('booked').doc(bookId).update({
        'status': 'Completed',
      });
      await vendorCollection
          .doc(vendorId)
          .collection('booked')
          .doc(bookId)
          .update({'status': 'Completed'});
      final balanceCollection = vendorCollection
          .doc(vendorId).collection('official').doc('balance');
      final getAmount = await balanceCollection.get();
      final preAmount = getAmount.data()?['amount'] ?? 0;
      await balanceCollection.set({
        'amount': preAmount + int.parse(amount)
      });
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<int> getAmountForVendor(String vendorId) async {
    try {
      final vendorCollection = FirebaseFirestore.instance.collection('vendors');
      final balanceCollection = vendorCollection
          .doc(vendorId).collection('official').doc('balance');
      final getAmount = await balanceCollection.get();
      if(!getAmount.exists){
        return 0;
      }
      return getAmount.data()?['amount'] ?? 0;
    } on FirebaseException catch (e) {
      return 0;
    } catch (e) {
      return 0;
    }
  }

  Future<bool> updateVendorService(String vendorId, List<String> service) async {
    try {
      final vendorCollection = FirebaseFirestore.instance.collection('vendors');
      await vendorCollection.doc(vendorId).update({'companyServices' : service});
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> conformSlot(
    String id,
    String day,
    String service,
    String url,String acre, String vendor
  ) async {
    try {
      final bookId = '${DateTime.now().microsecondsSinceEpoch}';
      Map<String, dynamic> data = {
        'bookId': bookId,
        'userId': userId,
        'userName': profile['name'],
        'address': profile['address'],
        'vendorId': id,
        'day': day,
        'service': service,
        'companyUrl': url,
        'acre': acre,
      };
      final regCollection = FirebaseFirestore.instance
          .collection('vendors')
          .doc(id)
          .collection('request');
      await regCollection.doc(bookId).set(data);
      final waitingCollection = FirebaseFirestore.instance.collection('riceKing');
      await waitingCollection.doc(userId).collection('waiting').doc(bookId).set(
          {
            'companyName':vendor,
            'service': service,
            'day' : day,
            'status': 'Pending',
            'companyUrl': url,
          });
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<int> getRequestCount() async {
    final collection = FirebaseFirestore.instance.collection('vendorRequest');
    final snapshot = await collection.get();
    return snapshot.docs.length;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  getVendorCount() async {
    final collection = FirebaseFirestore.instance.collection('vendors');
    final snapshot = await collection.get();
    return snapshot.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  getUserCount() async {
    final collection = FirebaseFirestore.instance.collection('riceKing');
    final snapshot = await collection.get();
    return snapshot.docs;
  }

  Future<int> getReportCount() async {
    final collection = FirebaseFirestore.instance.collection('report');
    final snapshot = await collection.get();
    return snapshot.docs.length;
  }

  Future<int> getSlotCount() async {
    final collection = FirebaseFirestore.instance.collection('slotRequest');
    final snapshot = await collection.get();
    return snapshot.docs.length;
  }

  Future<int> getVendorRequestCount(String id) async {
    final collection = FirebaseFirestore.instance
        .collection('vendors')
        .doc(id)
        .collection('request');
    final snapshot = await collection.get();
    return snapshot.docs.length;
  }

  Future<int> getVendorReportCount(String id) async {
    final collection = FirebaseFirestore.instance
        .collection('vendors')
        .doc(id)
        .collection('report');
    final snapshot = await collection.get();
    return snapshot.docs.length;
  }

  Future<int> countUserNotification(String id) async {
    final collection = FirebaseFirestore.instance
        .collection('riceKing')
        .doc(id)
        .collection('notification');
    final snapshot = await collection.get();
    return snapshot.docs.length;
  }

  Future<List<Map<String, dynamic>>> getVendor() async {
    try {
      CollectionReference vendorRef = FirebaseFirestore.instance.collection(
        'vendors',
      );
      QuerySnapshot querySnapshot = await vendorRef.get();
      final vendorList =
          querySnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return {...data};
          }).toList();
      return vendorList;
    } on FirebaseException catch (e) {
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getBooking() async {
    try {
      CollectionReference bookedRef = FirebaseFirestore.instance.collection(
        'riceKing',
      );
      final docSnapshot = bookedRef.doc(userId).collection('booked');
      QuerySnapshot querySnapshot = await docSnapshot.get();
      final booking =
          querySnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return {...data};
          }).toList();

      return booking;
    } on FirebaseException catch (e) {
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      DocumentReference profileRef = FirebaseFirestore.instance
          .collection('riceKing')
          .doc(userId);
      DocumentSnapshot docSnapshot = await profileRef.get();
      if (!docSnapshot.exists) {
        return {};
      }
      var data = docSnapshot.data() as Map<String, dynamic>;
      return data;
    } on FirebaseException catch (e) {
      return {};
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> getVendorData(String id) async {
    try {
      DocumentReference profileRef = FirebaseFirestore.instance
          .collection('vendors')
          .doc(id);
      DocumentSnapshot docSnapshot = await profileRef.get();
      if (!docSnapshot.exists) {
        return {};
      }
      var data = docSnapshot.data() as Map<String, dynamic>;
      return data;
    } on FirebaseException catch (e) {
      return {};
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> getThisVendor(String id) async {
    try {
      DocumentReference profileRef = FirebaseFirestore.instance
          .collection('vendors')
          .doc(id);
      DocumentSnapshot docSnapshot = await profileRef.get();
      if (!docSnapshot.exists) {
        return {};
      }
      var data = docSnapshot.data() as Map<String, dynamic>;
      return data;
    } on FirebaseException catch (e) {
      return {};
    } catch (e) {
      return {};
    }
  }

  Future<bool> deleteUser(String uid, String vendorId) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('riceKing');
      await userCollection.doc(uid).delete();
      if (vendorId.isNotEmpty) {
        final vendorCollection = FirebaseFirestore.instance.collection(
          'vendors',
        );
        await vendorCollection.doc(vendorId).delete();
      }
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteVendor(String uid, String vendorId) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('riceKing');
      await userCollection.doc(uid).update({'vendorId': ''});
      final vendorCollection = FirebaseFirestore.instance.collection('vendors');
      await vendorCollection.doc(vendorId).delete();
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> declineVendor(
    String vendorId,
    String uid,
    List<String> urls,
  ) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('riceKing');
      await userCollection.doc(uid).update({'vendorId': ''});
      final vendorCollection = FirebaseFirestore.instance.collection(
        'vendorRequest',
      );
      await vendorCollection.doc(vendorId).delete();
      for (String url in urls) {
        await deleteImage(url);
      }
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> acceptVendor(Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> service = data['service'];
      Map<String, dynamic> set = {
        'userId': data['userId'],
        'companyUrl': companyUrl,
        'companyRating': '0',
        'ratingCount': 0,
        'description':
            'We offer comprehensive agricultural solutions designed to boost your farm\'s productivity from planting to harvest. Our services optimize crop establishment, provide essential insights for better management, and efficiently process resources. Partner with us for a more prosperous and sustainable farming future.',
        'id': data['id'],
        'booking': [],
        'companyServices': [
          if (service['Transplanter Operator']) 'Transplanter Operator',
          if (service['Transplanter Owner']) 'Transplanter Owner',
          if (service['Nursery Mat Supplier']) 'Nursery Mat Supplier',
          if (service['Sand Nursery Maker']) 'Sand Nursery Maker',
          if (service['Drone Services Provider']) 'Drone Services Provider',
          if (service['Straw Baler Owner']) 'Straw Baler Owner',
          if (service['Paddy Grain Merchant']) 'Paddy Grain Merchant',
          if(service['Labour Provider']) 'Labour Provider',
          if (service['Aana Sakthi']) 'Aana Sakthi',
        ],
        'companyName': data['userDetails']['businessName'],
        'userDetails': data['userDetails'],
        'businessDetails': data['businessDetails'],
        'document': data['document'],
        'searchKeyword': [],
      };
      final vendorCollection = FirebaseFirestore.instance.collection('vendors');
      await vendorCollection.doc(data['id']).set(set);
      final userCollection = FirebaseFirestore.instance.collection('riceKing');
      await userCollection.doc(data['userId']).update({'vendorId': data['id']});
      final requestCollection = FirebaseFirestore.instance.collection(
        'vendorRequest',
      );
      await requestCollection.doc(data['id']).delete();

      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, String>> uploadDocument(
    Map<String, XFile?> data,
    String vendorId,
    BuildContext context,
  ) async {
    Map<String, String> newUploadedUrls = {};
    bool allUploadsSuccessful = true;

    for (var entry in data.entries) {
      final String imageType = entry.key;
      final XFile? imageFile = entry.value;

      if (imageFile != null) {
        try {
          final String storagePath = 'vendor/$vendorId/images/$imageType';
          final firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage
              .instance
              .ref(storagePath);

          final firebase_storage.UploadTask uploadTask = ref.putFile(
            File(imageFile.path),
          );

          final firebase_storage.TaskSnapshot snapshot = await uploadTask;

          final String downloadUrl = await snapshot.ref.getDownloadURL();
          newUploadedUrls[imageType] = downloadUrl;
        } on firebase_storage.FirebaseException catch (e) {
          allUploadsSuccessful = false;
          showToast('Error uploading $imageType', context);
        } catch (e) {
          allUploadsSuccessful = false;
          showToast(
            'An unexpected error occurred during $imageType upload',
            context,
          );
        }
      } else {}
    }

    if (allUploadsSuccessful) {
      return newUploadedUrls;
    } else {
      showToast('Some images failed to upload.', context);
      return {};
    }
  }

  Future<bool> deleteImage(String imageUrlToDelete) async {
    if (imageUrlToDelete.isEmpty) {
      return false;
    }
    try {
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(imageUrlToDelete)
          .delete();
      return true;
    } on firebase_storage.FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearNotification(String uid) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('riceKing');
      final snapshot =
          await userCollection.doc(uid).collection('notification').get();

      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
      return true;
    } on firebase_storage.FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> slotBookingAdmin(
    Map<String, dynamic> book,
    XFile image,
    String tId,
    BuildContext context,
  ) async {
    try {
      String downloadUrl = '';
      try {
        final String storagePath =
            'user/${book['userId']}/images/payment${book['bookId']}';
        final firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage
            .instance
            .ref(storagePath);

        final firebase_storage.UploadTask uploadTask = ref.putFile(
          File(image.path),
        );

        final firebase_storage.TaskSnapshot snapshot = await uploadTask;

        downloadUrl = await snapshot.ref.getDownloadURL();
      } on firebase_storage.FirebaseException catch (e) {
        showToast('Error uploading ${image.name}', context);
      } catch (e) {
        showToast(
          'An unexpected error occurred during ${image.name} upload',
          context,
        );
      }

      final collection = FirebaseFirestore.instance
          .collection('riceKing')
          .doc(book['userId'])
          .collection('notification');
      await collection.doc(book['bookId']).update({'payment': 'done'});

      final userCollection = FirebaseFirestore.instance.collection(
        'slotRequest',
      );
      await userCollection.doc(book['bookId']).set({
        ...book,
        'paymentUrl': downloadUrl,
        'paymentId': tId,
      });
      return true;
    } on firebase_storage.FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendMessage(
    String vendorId,
    String userId,
    String msg,
    String who,
  ) async {
    try {
      final String msgId = '${DateTime.now().microsecondsSinceEpoch}';
      final messageCollection = FirebaseFirestore.instance
          .collection('communication')
          .doc('${vendorId}_$userId')
          .collection('message');
      await messageCollection.doc(msgId).set({
        'message': msg,
        'time':
            DateTime.now().toString().substring(0, 11) +
            ' / ' +
            DateTime.now().toString().substring(11, 16),
        'messageBy': who,
        'msgId': msgId,
        'vendorId': vendorId,
        'userId': userId,
      });
    } catch (e) {}
  }

  Future<bool> sendReport(
    String name,
    String phone,
    String subject,
    String report,
  ) async {
    try {
      final String reportId = '${DateTime.now().microsecondsSinceEpoch}';
      final messageCollection = FirebaseFirestore.instance.collection('report');
      await messageCollection.doc(reportId).set({
        'name': name,
        'phone': phone,
        'subject': subject,
        'report': report,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearReport() async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('report');
      final snapshot = await userCollection.get();

      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
      return true;
    } on firebase_storage.FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteMsg(String msgId, String vendorId) async {
    try {
      final messageCollection = FirebaseFirestore.instance
          .collection('communication')
          .doc('${vendorId}_$userId')
          .collection('message');
      await messageCollection.doc(msgId).delete();
    } catch (e) {}
  }

  Future<void> updateReview(
    String vendorId,
    String rating,
    int count,
    Map<String, dynamic> data,
  ) async {
    print('Update Review');

    int r = int.parse(rating);
    r = ((r + data['rating']) / (count + 1)).round();
    String id = '${DateTime.now().microsecondsSinceEpoch}';
    final reviewCollection = FirebaseFirestore.instance
        .collection('vendors')
        .doc(vendorId)
        .collection('review');
    await reviewCollection.doc(id).set(data);
    final vendorCollection = FirebaseFirestore.instance
        .collection('vendors')
        .doc(vendorId);
    await vendorCollection.update({
      'companyRating': '$r',
      'ratingCount': count + 1,
    });
  }

  Future<bool> updateProfile(Map<String, String> map) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('riceKing');
      userCollection.doc(FirebaseAuth.instance.currentUser?.uid).update(map);
      return true;
    } on FirebaseException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editVendor(
    Map<String, dynamic> data,
    id,
    BuildContext context,
  ) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('vendors');
      await userCollection.doc(id).update(data);
      return true;
    } on FirebaseException {
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map<String, int>> getVendorBookedCount(String id) async {
    int pending = 0, cancel = 0, total = 0;
    try {
      CollectionReference profileRef = FirebaseFirestore.instance
          .collection('vendors')
          .doc(id)
          .collection('booked');
      QuerySnapshot docSnapshot = await profileRef.get();
      List<DocumentSnapshot> data = docSnapshot.docs;
      print(data.length);
      for (var value in data) {
        final data = value.data() as Map<String, dynamic>;
        final status = data['status'].toString().toLowerCase();
        if (status.contains('pending')) {
          pending++;
        } else if (status.contains('cancel')) {
          cancel++;
        }
        total++;
      }
      print('Count : $total , $pending , $cancel');
      return {'total': total, 'pending': pending, 'cancel': cancel};
    } on FirebaseException catch (e) {
      return {'total': total, 'pending': pending, 'cancel': cancel};
    } catch (e) {
      return {'total': total, 'pending': pending, 'cancel': cancel};
    }
  }

  Future<Map<String, dynamic>> getUrl() async {
    final collection = FirebaseFirestore.instance.collection('official');
    final snapshot = await collection.doc('banner').get();
    final data = snapshot.data();
    return data ??
        {
          'banner1':
              "https://firebasestorage.googleapis.com/v0/b/aanacrops-riceking.firebasestorage.app/o/app_reference%2Fbanner.png?alt=media&token=9132c88e-dae4-4fd5-a26a-0a3d040413ab",

          'banner2':
              "https://firebasestorage.googleapis.com/v0/b/aanacrops-riceking.firebasestorage.app/o/app_reference%2Fbanner.png?alt=media&token=9132c88e-dae4-4fd5-a26a-0a3d040413ab",

          'banner3':
              "https://firebasestorage.googleapis.com/v0/b/aanacrops-riceking.firebasestorage.app/o/app_reference%2Fbanner.png?alt=media&token=9132c88e-dae4-4fd5-a26a-0a3d040413ab",
        };
  }

  Future<String> uploadImage(XFile image, int index) async {
    try {
      final String storagePath = 'app_reference/official/banner$index';
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage
          .instance
          .ref(storagePath);

      final firebase_storage.UploadTask uploadTask = ref.putFile(
        File(image.path),
      );

      final firebase_storage.TaskSnapshot snapshot = await uploadTask;

      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on firebase_storage.FirebaseException catch (e) {
      return 'https://firebasestorage.googleapis.com/v0/b/aana-crop-solution.firebasestorage.app/o/app_reference%2Fbanner.png?alt=media&token=10c309ac-fb60-483a-95d1-6c937c815ef0';
    } catch (e) {
      return 'https://firebasestorage.googleapis.com/v0/b/aana-crop-solution.firebasestorage.app/o/app_reference%2Fbanner.png?alt=media&token=10c309ac-fb60-483a-95d1-6c937c815ef0';
    }
  }

  Future<bool> updateUrl(String url1, String url2, String url3) async {
    try {
      print("Update Url");
      final collection = FirebaseFirestore.instance.collection('official');
      await collection.doc('banner').update({
        'banner1': url1,
        'banner2': url2,
        'banner3': url3,
      });
      return true;
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> bookingCount() async {
    final collection = FirebaseFirestore.instance
        .collection('riceKing')
        .doc(userId)
        .collection('booked');
    final snapshot = await collection.get();
    return snapshot.docs.length;
  }

  Future<String> getAiResponse(String message) async {
    if (message == null || message.trim().isEmpty) {
      print("Error: Message parameter is empty or null.");
      return "Please provide a message for the AI.";
    }

    final model = FirebaseAI.vertexAI().generativeModel(
      model: 'gemini-2.5-flash',
    );
    final prompt = [Content.text(message)];
    final response = await model.generateContent(prompt);
    return response.text ?? '';
  }

  Future<String> getAiUpdatesResponse() async {
    const String apiKey = 'AIzaSyAz0ov7AMgJIHAXl0hSxbky-0OTR0VWkss';
    const String model = 'gemini-2.5-flash-preview-05-20';
    final Uri uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
    );

    // Define the prompt you want to send to the model.
    const String prompt =
        "'What are the most recent agriculture news headlines? Only provide the headlines in a list format.'";

    // Create the request body as a JSON object.
    final Map<String, dynamic> requestBody = {
      'contents': [
        {
          'parts': [
            {'text': prompt},
          ],
        },
      ],
    };

    try {
      final http.Response response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        String generatedText =
            responseData['candidates'][0]['content']['parts'][0]['text'];

        // RegExp regExp = RegExp('*   ');
        // int regexOccurrences = regExp.allMatches(generatedText).length;
        //
        // print("Count using RegExp: $regexOccurrences");

        generatedText = generatedText.replaceAll('\n', ' ');
        print('Generated Text: $generatedText');

        return generatedText;
      } else {
        print('API call failed with status code: ${response.body}');
        return 'Response body: ${response.body}';
      }
    } catch (e) {
      return 'An error occurred: $e';
    }
  }

  Future<bool> addServiceRequest(String id, List<String> ser, Set<Map<String, Map<String, Object?>>> currentDetails, List<dynamic> oldService, List<dynamic> oldDetails)  async {
    try {
      final data = await getThisVendor(id);
      final collection = FirebaseFirestore.instance.collection('update');
      // List<String> ser = [];
      String cId = '${DateTime.now().microsecondsSinceEpoch}';
      // for(var i in currentService.keys) ser.add(i);
      collection.doc(cId).set({
        'vendorName' : data['companyName'],
        'vendorId' : data['id'],
        'userId' : data['userId'],
        'oldService' : oldService,
        'currentService' : ser,
        'oldDetails' : oldDetails,
        'currentDetails' : currentDetails,
        'id':cId
      });
      return true;
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Map<String,dynamic>>> getUpdateService() async {
    try {
      final collection = FirebaseFirestore.instance.collection('update');
      final data = await collection.get();
      final List<Map<String, dynamic>> docList = data.docs.map((doc) {
        return doc.data();
      }).toList();

      return docList;
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> decliedUpdate(String data) async {
    try {

      final collection = FirebaseFirestore.instance.collection('update');
      await collection.doc(data).delete();
      return true;
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> acceptUpdate(Map<String, dynamic> data) async {
    try {
      List<String> service = [];
      List<Map<String,dynamic>> details = [];
      for(var s in data['currentService']) service.add(s);
      for(var s in data['oldService']) service.add(s);
      for(var d in data['oldDetails']) details.add(d);
      for(var d in data['currentDetails']) details.add(d);
print(service);
print(details);
      final vendor = FirebaseFirestore.instance.collection('vendors');
      await vendor.doc(data['vendorId']).update({
'businessDetails':details,
        'companyServices':service,
      });
      final collection = FirebaseFirestore.instance.collection('update');
      await collection.doc(data['id']).delete();
      return true;
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

class AppNotification {
  void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<String> getServerKey() async {
    final severAccountJson = dotenv.env['SERVER_ACCOUNT_JSON'];

    final scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/userinfo.email',
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(severAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials = await auth
        .obtainAccessCredentialsViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(severAccountJson),
          scopes,
          client,
        );

    client.close();

    return credentials.accessToken.data;
  }

  Future<void> send (
    String targetUid,
    String title,
    String body,
    String page,
  ) async {
    final String serverKey = await getServerKey();
    String projectId = 'aanacrops-riceking';
    String endPoint =
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

    String token = '';

    final userCollection = FirebaseFirestore.instance.collection('riceKing');
    final res = await userCollection.doc(targetUid).get();
    final data = res.data() as Map<String, dynamic>;
    if (data['fcmToken'] != null) {
      token = data['fcmToken'];
    } else {
      return;
    }
    final Map<String, dynamic> message = {
      'message': {
        'token': token,
        'notification': {'title': title, 'body': body},
        'data': {
          'screen': page,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
        },
      },
    };

    print('FCM Message: $message');

    final http.Response response = await http.post(
      Uri.parse(endPoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': ' Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
    } else {
      print('Error sending FCM message: ${response.body}');
    }
  }

  void showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'high_importance_channel', // channel id
            'High Importance Notifications', // channel name
            importance: Importance.high,
            priority: Priority.high,
          );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
      );
    }
  }
}

// class AppNotification {
//   Future<void> send(String targetUid, String title, String body,BuildContext context) async {
//     if(targetUid.isEmpty) {
//       return;
//     }
//     final callable = FirebaseFunctions.instance.httpsCallable('sendNotificationToUid');
//     try {
//       print('Sending notification to $targetUid with title: $title and body: $body');
//       final data = {
//         'uid': targetUid,
//         'title': title,
//         'body': body,
//       };
//       print(data);
//       final response = await callable.call(data);
//       print('Notification sent: ${response.data}');
//     } catch (e) {
//       print('Error sending notification: $e');
//     }
//   }
// }