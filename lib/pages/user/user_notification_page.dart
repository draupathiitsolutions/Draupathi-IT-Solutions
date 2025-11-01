import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/pages/user/user_setting_page.dart';
import 'package:riceking/widget/button.dart';
import 'package:riceking/widget/inputField.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../function/appFunction.dart';
import '../../widget/report.dart';
import '../../widget/staff.dart';
import '../../widget/text.dart';
import '../admin/admin_home_page.dart';
import 'ai_assist.dart';

class UserNotificationPage extends StatefulWidget {
  final String id;
  const UserNotificationPage({super.key, required this.id});

  @override
  State<UserNotificationPage> createState() => _UserNotificationPageState();
}

class _UserNotificationPageState extends State<UserNotificationPage> {
  bool showPrize = false, onLoad = false;
  XFile? image;
  TextEditingController paymentId = TextEditingController();
  Map<String, dynamic> book = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: width(context),
              height: height(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height:200,
                    width: width(context),
                    child: Image.asset(
                      'assets/banner.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: Center(
                            child: RobotoText(title: 'Notification', size: 22),
                          ),
                        ),
                      ),
                      IconAsButton(
                        icon: Icons.close,
                        onPressed: () {
                          Database().clearNotification(widget.id);
                          Navigator.pop(context);
                        },
                        size: 18,
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SizedBox(
                        width: width(context),
                        child: StreamBuilder(
                          stream:
                              FirebaseFirestore.instance
                                  .collection('riceKing')
                                  .doc(widget.id)
                                  .collection('notification')
                                  .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return SizedBox();
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SpinKitFadingCircle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              );
                            }
                            final userData = snapshot.data?.docs ?? [];
                            if (userData.isEmpty) {
                              return Center(
                                child: LatoText(
                                  title: 'Notification Empty',
                                  size: 16,
                                  lineHeight: 1,
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: userData.length,
                              itemBuilder: (context, index) {
                                final user = userData[index];
                                final data = user.data();
                                return notificationCard(data);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showPrize,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showPrize = false;
                  });
                },

                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.35),
                  height: height(context),
                  width: width(context),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 380,
                    padding: EdgeInsets.all(16),
                    width: width(context) * 0.9,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RobotoText(title: 'Pay Now', size: 24),
                        SizedBox(height: 14),
                        LatoText(
                          title: 'Do You want to Payment',
                          size: 14,
                          lineHeight: 3,
                        ),
                        LatoText(
                          title:
                              'Note: After Your payment share your payment Id and screenshot',
                          size: 10,
                          lineHeight: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20,
                          children: [
                            TextAsButton(
                              title: 'Gpay',
                              onPressed: () {
                                final String transactionId =
                                    getUniqueTransactionId();
                                final Uri gpayUri = Uri(
                                  scheme: 'upi',
                                  host: 'pay',
                                  queryParameters: {
                                    'pa': yourGPayUpiId,
                                    'pn': yourName,
                                    'mc':
                                        '0000', // Merchant Category Code (example: 0000 for generic)
                                    'tr':
                                        transactionId, // Unique transaction reference ID
                                    'tn':
                                        note, // Transaction Note
                                    'am': amount.toStringAsFixed(
                                      2,
                                    ), // Amount with 2 decimal places
                                    'cu': currency,
                                  },
                                );
                                payNow(gpayUri, context);
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              size: 14,
                            ),
                            TextAsButton(
                              title: 'PayTM',
                              onPressed: () {
                                final String transactionId =
                                    getUniqueTransactionId();
                                final Uri phonePeUri = Uri(
                                  scheme: 'upi',
                                  host: 'pay',
                                  queryParameters: {
                                    'pa': yourPhonePeUpiId,
                                    'pn': yourName,
                                    'mc':
                                        '0000', // Merchant Category Code (example: 0000 for generic)
                                    'tr':
                                        transactionId, // Unique transaction reference ID
                                    'tn':
                                        note, // Transaction Note
                                    'am': amount.toStringAsFixed(
                                      2,
                                    ), // Amount with 2 decimal places
                                    'cu': currency,
                                  },
                                );
                                payNow(phonePeUri, context);
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              size: 14,
                            ),
                          ],
                        ),
                        SizedBox(height: 14),
                        Row(
                          children: [
                            IconAsButton(
                              icon: Icons.upload,
                              onPressed: () {
                                getImage();
                              },
                              size: 20,
                            ),
                            LatoText(
                              title: image != null ? image!.name : '',
                              size: 10,
                              lineHeight: 1,
                            ),
                          ],
                        ),
                        TextFieldWithIcon(
                          controller: paymentId,
                          hintText: 'Translation ID',
                          icons: Icons.account_balance_sharp,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10),
                        ButtonWithText(
                          title: 'Summit',
                          onPressed: () async {
                            if (paymentId.text.isEmpty || image == null) {
                              showToast('Please fill all fields', context);
                              return;
                            }
                            setState(() {
                              onLoad = true;
                            });
                            FocusScope.of(context).unfocus();
                            bool success = await Database().slotBookingAdmin(
                              book,
                              image!,
                              paymentId.text,
                              context,
                            );
                            if (success) {
                              showToast(
                                'After conformed by Admin Slot Conform!',
                                context,
                              );
                              AppNotification().send(
                                adminId,
                                'Slot Request',
                                'New booking request from a farmer.',
                                'adminPage',
                              );
                            } else {
                              showToast('Something went wrong', context);
                            }
                            setState(() {
                              showPrize = false;
                              onLoad = false;
                            });
                          },
                          width: width(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(visible: onLoad, child: MyLoader()),
          ],
        ),
      ),

      bottomNavigationBar: StylishBottomBar(
        option: DotBarOptions(
          dotStyle: DotStyle.tile,
          gradient: const LinearGradient(colors: [Color(0xff2E402A), Color(0xff2E402A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: RobotoText(title: 'Home', size: 14),
            backgroundColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.notifications),
            title: RobotoText(title: 'Info', size: 14),
            backgroundColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person),
            title: RobotoText(title: 'Me', size: 14),
            backgroundColor: Colors.black,
          ),
          if(FirebaseAuth.instance.currentUser?.uid == 'n1BeFWiCKrc3WkOISEHhe1OJcip2'
              || FirebaseAuth.instance.currentUser?.uid == adminId)
            BottomBarItem(
              icon: const Icon(Icons.admin_panel_settings),
              title: RobotoText(title: 'Admin', size: 14),
              backgroundColor: Colors.black,
            ),
          if(!(FirebaseAuth.instance.currentUser?.uid == 'n1BeFWiCKrc3WkOISEHhe1OJcip2'
              || FirebaseAuth.instance.currentUser?.uid == adminId))
            BottomBarItem(
            icon: const Icon(Icons.help),
            title: RobotoText(title: 'Help', size: 14),
            backgroundColor: Colors.black,
          ),
        ],
        fabLocation: StylishBarFabLocation.end,
        hasNotch: true,
        currentIndex: 1,
        onTap: (index) {
          setState(() {
            if(index == 0) Navigator.pop(context);
            if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserSettingPage(),
                ),
              );
            }
            if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => (FirebaseAuth.instance.currentUser?.uid == 'n1BeFWiCKrc3WkOISEHhe1OJcip2'
                      || FirebaseAuth.instance.currentUser?.uid == adminId)? const AdminHomePage(): const RiceKingReportPage(),

                ),
              );
            }
          });
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AiAssist()),
          );
        },
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Image(
          image: AssetImage('assets/robotIcon.png'),
          width: 50,
          height: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget notificationCard(Map<String, dynamic> data) {
    print(data);
    return Container(
      width: width(context),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 5,
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 0),
          ),
        ],
      ),
      child:
          // data['for'] == 'accept'
          //     ? Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         RobotoText(title: data['service'], size: 16),
          //         SizedBox(height: 5),
          //         LatoText(title: data['reason'], size: 14, lineHeight: 2),
          //         SizedBox(height: 5),
          //         LatoText(
          //           title: '${data['day']} at ${data['time']}',
          //           size: 12,
          //           lineHeight: 1,
          //         ),
          //         SizedBox(height: 8),
          //         Divider(
          //           height: 1,
          //           thickness: 1,
          //           color: Theme.of(context).colorScheme.tertiary,
          //         ),
          //         SizedBox(height: 5),
          //         LatoText(
          //           title:
          //               'Note: \nIf you ok for this price and time you will make a pre-pay ₹500. \nIf in case you cancel your slot this amount will not refund.',
          //           size: 12,
          //           lineHeight: 5,
          //         ),
          //         if(data['payment']!='done')
          //         TextAsButton(
          //           title: 'Pay Now',
          //           onPressed: () {
          //             setState(() {
          //               book = data;
          //               showPrize = true;
          //             });
          //           },
          //           color: Theme.of(context).colorScheme.secondary,
          //           size: 14,
          //         ),
          //       ],
          //     ) :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RobotoText(title: data['service'], size: 16),
                      SizedBox(height: 3,),
                      LatoText(title: data['vendorName'] ?? '', size: 14, lineHeight: 1),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          if((data['for'] ?? '' )!= 'decline') LatoText(title: '${data['date']} - ', size: 12, lineHeight: 1),
                          LatoText(title: data['reason'].toString().length > 25 ? '${data['reason'].toString().substring(0,25)}...':data['reason'].toString(), size: 14, lineHeight: 1),
                        ],
                      ),
                    ],
                  ),ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Image.asset(
                            'assets/services/${data['service']}.png',
                            width: 75, // 75
                            height: 75,
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
    );
  }

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
      print(image!.name);
      showToast('Image Selected!', context);
    });
  }
}
