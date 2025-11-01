import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/function/appFunction.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/pages/user/user_edit_profile.dart';
import 'package:riceking/pages/user/user_notification_page.dart';
import 'package:riceking/pages/user/user_reg_vendor.dart';
import 'package:riceking/widget/button.dart';
import 'package:riceking/widget/staff.dart';
import 'package:riceking/widget/text.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../widget/inputField.dart';
import '../../widget/online_image.dart';
import '../../widget/report.dart';
import '../admin/admin_home_page.dart';
import '../message_page.dart';
import '../vendor/vendor_home_page.dart';
import 'ai_assist.dart';

class UserSettingPage extends StatefulWidget {
  const UserSettingPage({super.key});

  @override
  State<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  int pos = 0;
  bool showBook = false, onLoad = false, delete = false,showReview = false;
  Map<String, dynamic> booked = {};
  bool showPending = false;
  String vendorId= '';
  TextEditingController reviewController = TextEditingController();
  int rating = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      onLoad = true;
    });
    await getProfile()
        ? setState(() {
          onLoad = false;
        })
        : {
          setState(() {
            onLoad = false;
          }),
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unable to load profile'),
              duration: const Duration(seconds: 2),
            ),
          ),
        };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          alignment: Alignment(0, 0),
          children: [
            SizedBox(
              height: height(context),
              width: width(context),
              child:
                  onLoad
                      ? Container(
                        height: height(context),
                        width: width(context),
                        child: SpinKitFadingCircle(
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 50.0,
                        ),
                      )
                      : SizedBox(
                        height: height(context),
                        width: width(context),
                        child: StreamBuilder(
                          stream:
                              FirebaseFirestore.instance
                                  .collection('riceKing')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('booked')
                                  .orderBy('bookId', descending: true)
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
                            final bookedList = snapshot.data?.docs ?? [];
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: bookedList.length + 2,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 200,
                                        width: width(context),
                                        child: Image.asset(
                                          'assets/banner.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 18),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RobotoText(
                                                  title: 'Profile',
                                                  size: 24,
                                                ),
                                                Row(
                                                  children: [
                                                    // Icon(
                                                    //   Icons.language,
                                                    //   color:
                                                    //       Theme.of(context)
                                                    //           .colorScheme
                                                    //           .tertiary,
                                                    //   size: 14,
                                                    // ),
                                                    // SizedBox(width: 2),
                                                    // Text(
                                                    //   language,
                                                    //   style: TextStyle(
                                                    //     fontSize: 12,
                                                    //   ),
                                                    // ),
                                                    SizedBox(width: 12),
                                                    TextAsButton(
                                                      title:profile['vendorId']
                                                                  .toString()
                                                                  .isEmpty
                                                              ? 'Register as a vendor'
                                                              : profile['vendorId']
                                                                      .toString() ==
                                                                  'Pending'
                                                              ? 'Pending'
                                                              : 'Vendor Page',
                                                      onPressed: () async {
                                                        if (profile['vendorId']
                                                                .toString()
                                                                .isNotEmpty &&
                                                            profile['vendorId']
                                                                    .toString() !=
                                                                'Pending') {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (
                                                                    context,
                                                                  ) => VendorHomePage(
                                                                    id:
                                                                        profile['vendorId'],
                                                                  ),
                                                            ),
                                                          );
                                                        } else if (profile['vendorId']
                                                                .toString() !=
                                                            'Pending') {
                                                          bool
                                                          status = await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      const UserRegVendor(),
                                                            ),
                                                          );
                                                          if (status) {
                                                            setState(() {
                                                              profile['vendorId'] = 'Pending';
                                                            });
                                                            Navigator.pop(
                                                              context,
                                                            );}
                                                        }
                                                      },
                                                      color:
                                                          Theme.of(
                                                            context,
                                                          ).colorScheme.primary,
                                                      size: 14,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 18),
                                            LatoText(
                                              title: 'Name',
                                              size: 12,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: profile['name'],
                                              size: 16,
                                              lineHeight: 1,
                                            ),
                                            const SizedBox(height: 12),
                                            LatoText(
                                              title: 'Phone No',
                                              size: 12,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: '${profile['phone_no']}',
                                              size: 16,
                                              lineHeight: 1,
                                            ),
                                            const SizedBox(height: 12),
                                            LatoText(
                                              title: 'Address',
                                              size: 12,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: profile['address'],
                                              size: 16,
                                              lineHeight: 3,
                                            ),
                                            SizedBox(height: 8),
                                            ButtonWithText(
                                              title: 'Edit',
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            UserEditProfile(),
                                                  ),
                                                );
                                              },
                                              width: width(context),
                                            ),
                                            const SizedBox(height: 8),
                                            Divider(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.tertiary,
                                            ),
                                            if(showPending)
                                              Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment
                                                            .centerLeft,
                                                    child: RobotoText(
                                                      title: 'Pending',
                                                      size: 16,
                                                    ),
                                                  ),
                                                  SizedBox(height: 18),
                                                  SizedBox(
                                                    height: 80,
                                                    width: width(context),
                                                    child: StreamBuilder(
                                                      stream:
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                'riceKing',
                                                              )
                                                              .doc(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    ?.uid,
                                                              )
                                                              .collection(
                                                                'waiting',
                                                              )
                                                              .snapshots(),
                                                      builder: (
                                                        context,
                                                        snapshot,
                                                      ) {
                                                        if (snapshot
                                                            .hasError) {
                                                          return SizedBox();
                                                        }
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Center(
                                                            child: SpinKitFadingCircle(
                                                              color:
                                                                  Theme.of(
                                                                    context,
                                                                  ).colorScheme.surface,
                                                            ),
                                                          );
                                                        }
                                                        final bookedList =
                                                            snapshot
                                                                .data
                                                                ?.docs ??
                                                            [];

                                                        if (bookedList
                                                            .isEmpty) {
                                                          return Center(
                                                            child: LatoText(
                                                              title:
                                                                  'No Slot Pending',
                                                              size: 16,
                                                              lineHeight: 1,
                                                            ),
                                                          );
                                                        }
                                                        print(bookedList);
                                                        return ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              bookedList
                                                                  .length,
                                                          itemBuilder: (
                                                            context,
                                                            index,
                                                          ) {
                                                            return _pendingCard(
                                                              bookedList[index]
                                                                  .data(),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            const SizedBox(height: 18),
                                            RobotoText(
                                              title: 'Book History',
                                              size: 20,
                                            ),
                                            const SizedBox(height: 18),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                if (index == bookedList.length + 1) {
                                  return TextAsButton(
                                    title: 'Sign Out',
                                    onPressed: () async {
                                      setState(() {
                                        onLoad = true;
                                      });
                                      await Auth().signOut();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/mainPage',
                                        (route) => false,
                                      );
                                      setState(() {
                                        onLoad = false;
                                      });
                                    },
                                    color: Colors.redAccent,
                                    size: 14,
                                  );
                                }

                                return _bookingCard(
                                  bookedList[index - 1].data(),
                                );
                              },
                            );
                          },
                        ),
                      ),
            ),
            Visibility(
              visible: showBook,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showBook = false;
                  });
                },
                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.35),
                  height: height(context),
                  width: width(context),
                ),
              ),
            ),
            Visibility(visible: showBook, child: _showBooked(booked)),

            Positioned(
              bottom: 0,
              child: Visibility(
                visible: showReview,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      showReview = false;
                    });
                  },
                  child: Container(
                    height: height(context),
                    width: width(context),
                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 250,
                          width: width(context) - 48,
                          padding: EdgeInsets.all(14),
                          margin: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RobotoText(title: 'Review', size: 24),
                              SizedBox(height: 24),
                              Container(
                                height: 30,
                                width: width(context),
                                alignment: Alignment(0, 0),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (builder, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          rating = index + 1;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Icon(
                                          Icons.star,
                                          color:
                                          rating > index
                                              ? Colors.amberAccent
                                              : Colors.black26,
                                          size: 18,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 4),
                              TextFieldWithIcon(
                                controller: reviewController,
                                hintText: 'Review',
                                icons: Icons.bar_chart_rounded,
                                keyboardType: TextInputType.multiline,
                              ),
                              SizedBox(height: 18),
                              ButtonWithText(
                                title: 'Submit',
                                onPressed: () async {
                                  if (rating > 0 &&
                                      reviewController.text.isNotEmpty) {
                                    setState(() {
                                      FocusScope.of(context).unfocus();
                                      delete = true;
                                    });
                                    print('pressed');
                                    final vendor = await Database().getThisVendor(vendorId);
                                    await Database().updateReview(
                                      vendorId,
                                      vendor['companyRating'],
                                      vendor['ratingCount'],
                                      {
                                        'rating': rating,
                                        'review': reviewController.text,
                                        'by': profile['name'],
                                      },
                                    );
                                    setState(() {
                                      delete = false;
                                      showReview = false;
                                    });
                                  }
                                },
                                width: width(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(visible: delete, child: MyLoader()),
          ],
        ),
      ),
      bottomNavigationBar: StylishBottomBar(
        option: DotBarOptions(
          dotStyle: DotStyle.tile,
          gradient: const LinearGradient(
            colors: [Color(0xff2E402A), Color(0xff2E402A)],
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
          if (FirebaseAuth.instance.currentUser?.uid ==
                  'n1BeFWiCKrc3WkOISEHhe1OJcip2' ||
              FirebaseAuth.instance.currentUser?.uid == adminId)
            BottomBarItem(
              icon: const Icon(Icons.admin_panel_settings),
              title: RobotoText(title: 'Admin', size: 14),
              backgroundColor: Colors.black,
            ),
          if (!(FirebaseAuth.instance.currentUser?.uid ==
                  'n1BeFWiCKrc3WkOISEHhe1OJcip2' ||
              FirebaseAuth.instance.currentUser?.uid == adminId))
            BottomBarItem(
              icon: const Icon(Icons.help),
              title: RobotoText(title: 'Help', size: 14),
              backgroundColor: Colors.black,
            ),
        ],
        fabLocation: StylishBarFabLocation.end,
        hasNotch: true,
        currentIndex: 2,
        onTap: (index) {
          setState(() {
            if (index == 0) Navigator.pop(context);
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => UserNotificationPage(
                        id: FirebaseAuth.instance.currentUser?.uid ?? '',
                      ),
                ),
              );
            }
            if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          (FirebaseAuth.instance.currentUser?.uid ==
                                      'n1BeFWiCKrc3WkOISEHhe1OJcip2' ||
                                  FirebaseAuth.instance.currentUser?.uid ==
                                      adminId)
                              ? const AdminHomePage()
                              : const RiceKingReportPage(),
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

  Widget _showBooked(Map<String, dynamic> booker) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: width(context) - 36,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: OnlineImage(url: booker['companyUrl'] ?? '', border: 16),
        ),
        Container(
          width: width(context) - 36,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RobotoText(title: booker['vendorName'] ?? '', size: 20),
              SizedBox(height: 8),
              LatoText(
                title: booker['description'] ?? '',
                size: 14,
                lineHeight: 6,
              ),
              SizedBox(height: 8),
              RobotoText(
                title: booker['service'].toString().trim() ?? '',
                size: 18,
              ),
              RobotoText(
                title: '${booker['day'] ?? ''} - ${booker['time'] ?? ''}',
                size: 14,
              ),
              RobotoText(title: booker['status'] ?? '', size: 14),
              if('${booker['status'] ?? ''}'.contains('Cancel'))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RobotoText(
                      title: 'Reason',
                      size: 12,
                    ),

                    LatoText(
                      title: booker['reason'] ?? '',
                      size: 14,
                      lineHeight: 6,
                    ),
                  ],
                ),

              if (!'${booker['status'] ?? ''}'.contains('Cancel') &&
                  !'${booker['status'] ?? ''}'.contains('Completed'))
                RobotoText(title: 'OTP: ${booker['otp'] ?? ''}', size: 14),
              if ('${booker['status'] ?? ''}'.contains('Completed'))
                TextAsButton(
                  title: 'Review Me',
                  onPressed: () {
                    setState(() {
                      showReview = true;
                      vendorId = booker['vendorId'];
                    });
                  },
                  color: Colors.green,
                  size: 14,
                ),

              SizedBox(height: 18),
              if (!'${booker['status'] ?? ''}'.contains('Cancel') &&
                  !'${booker['status'] ?? ''}'.contains('Completed'))
                Row(
                  children: [
                    TextAsButton(
                      title: 'Message',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => MessagePage(
                                  vendorId: booker['vendorId'],
                                  userId: booker['userId'],
                                  isUser: true,
                                ),
                          ),
                        );
                      },
                      color: Theme.of(context).colorScheme.primary,
                      size: 14,
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onDoubleTap: () async {
                        setState(() {
                          delete = true;
                        });
                        await Database().cancelOrder(
                          booker,
                          'User Cancel This Order',
                        );
                        setState(() {
                          delete = false;
                          showBook = false;
                        });
                      },
                      child: TextAsButton(
                        title: 'Cancel',
                        onPressed: () {
                          showToast('Double tap To cancel!', context);
                        },
                        color: Colors.redAccent,
                        size: 14,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bookingCard(Map<String, dynamic> booker) {
    return GestureDetector(
      onTap: () {
        setState(() {
          booked = booker;
          showBook = true;
        });
      },
      child: Container(
        height: 100,
        width: width(context) * 0.9,
        margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: OnlineImage(
                url: booker['companyUrl'],
                border: 16,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LatoText(
                    title: booker['vendorName'],
                    size: 16,
                    lineHeight: 1,
                  ),
                  LatoText(
                    title: booker['service'].toString().trim() ?? '',
                    size: 12,
                    lineHeight: 1,
                  ),
                  LatoText(
                    title: '${booker['day']} - ${booker['time']}',
                    size: 14,
                    lineHeight: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pendingCard(Map<String,dynamic> booker) {
    return Container(
      margin: const EdgeInsets.only(right: 18),
                height: 80,
                width: width(context) * 0.75,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: OnlineImage(
                        url: booker['companyUrl'],
                        fit: BoxFit.fill,
                        border: 8,
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LatoText(
                          title: booker['companyName'],
                          size: 14,
                          lineHeight: 1,
                        ),
                        SizedBox(
                          width: width(context) - 200,
                          height: 20,
                          child: LatoText(
                            title: booker['service'].toString().trim() ?? '',
                            size: 12,
                            lineHeight: 1,
                          ),
                        ),
                        LatoText(
                          title: '${booker['day']} - ${booker['status']}',
                          size: 10,
                          lineHeight: 1,
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }

  Future<bool> getProfile() async {
    try {
      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('riceKing');
      final docSnapshot =
          await collectionReference.doc(userId).get()
              as DocumentSnapshot<Map<String, dynamic>>;

      if (!docSnapshot.exists) {
        return false;
      }
      final data = docSnapshot.data();
      final count = await collectionReference.doc(
        FirebaseAuth
            .instance
            .currentUser
            ?.uid,
      )
          .collection(
        'waiting',
      ).get();
          showPending = count.docs.isNotEmpty;
      if (data != null) {
        setState(() {
          profile = data;
        });
        return true;
      }
    } on Exception catch (e) {
      return false;
    }
    return false;
  }
}
