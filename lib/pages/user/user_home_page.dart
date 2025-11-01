import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riceking/function/appFunction.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/pages/admin/admin_home_page.dart';
import 'package:riceking/pages/user/user_book_vendor.dart';
import 'package:riceking/pages/user/user_notification_page.dart';
import 'package:riceking/pages/user/user_setting_page.dart';
import 'package:riceking/pages/user/user_view_vendor.dart';
import 'package:riceking/widget/button.dart';
import 'package:riceking/widget/inputField.dart';
import 'package:riceking/widget/online_image.dart';
import 'package:riceking/widget/staff.dart';
import 'package:riceking/widget/text.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../widget/report.dart';
import 'ai_assist.dart';
import 'filter_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  TextEditingController otherController = TextEditingController();

  int pos = 0, countNotification = 0;
  bool showBook = false, showFilter = false, onLoad = false, loadScreen = false;
  Map<String, dynamic> booked = {};
  List<String> url = [];
  bool haveBooking = false;
  String todayUpdates = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      onLoad = true;
    });
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          onLoad = false;
        });
      }
    });
    getData();
  }

  Future<void> getData() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null && newToken.isNotEmpty) {
        await FirebaseFirestore.instance.collection('riceKing').doc(uid).update(
          {'fcmToken': newToken},
        );
        print(" Token refreshed and updated: $newToken");
      } else {
        print(" Failed to update token: User ID is null or token is empty.");
      }
    });
    setState(() {
      loadScreen = true;
    });
    await Future.wait([
      Database().getProfile().then((data) {
        setState(() {
          profile = data;
          print(profile);
          language = profile['language'];
        });
      }),
      Database()
          .countUserNotification(FirebaseAuth.instance.currentUser?.uid ?? "")
          .then((count) {
            setState(() {
              countNotification = count;
            });
          }),
      Database().bookingCount().then((have) {
        setState(() {
          haveBooking = have != 0;
        });
      }),
      Database().getUrl().then((urls) {
        setState(() {
          url = urls.values.map((link) => link.toString()).toList();
        });
      }),
      // Database().getAiUpdatesResponse().then((res) {
      //   setState(() {
      //     todayUpdates = res;
      //   });
      // }),
    ]);
    setState(() {
      loadScreen = false;
    });
    String loc = await getCurrentLocation(context);

    setState(() {
      print(loc);
      location = loc;
      print(location);
    });
  }
  var vendorList = [];

  @override
  Widget build(BuildContext context) {
    return onLoad
        ? Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Column(
            children: [
              SizedBox(height: 50),
              Expanded(
                child: SizedBox(
                  width: width(context),
                  child: Center(
                    child: Image.asset(
                      'assets/appLogo.png',
                      width: width(context) * 0.5,
                    ),
                  ),
                ),
              ),
              SpinKitFadingCircle(
                color: Theme.of(context).colorScheme.tertiary,
                size: 40,
              ),
              SizedBox(height: 40),
            ],
          ),
        )
        : Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          extendBody: true,
          body: SafeArea(
            child: Stack(
              alignment: Alignment(0, 0),
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Image.asset(
                                'assets/appLogo.png',
                                width: 50,
                              ),
                            ),
                          Row(
                            spacing: 4,
                            children: [
                              Container(
                                height: 50,
                                alignment: Alignment(0, 0),
                                child: Text(
                                  location,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.location_on,
                                color: Theme.of(context).colorScheme.tertiary,
                                size: 20,
                              ),
                              SizedBox(width: 24),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child:
                          loadScreen
                              ? MyLoadScreen()
                              : SizedBox(
                                width: width(context),
                                child: StreamBuilder(
                                  stream:
                                      FirebaseFirestore.instance
                                          .collection('vendors')
                                          .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return SizedBox();
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: SpinKitFadingCircle(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.surface,
                                        ),
                                      );
                                    }
                                    vendorList =
                                        snapshot.data?.docs ?? [];
                                    return ListView.builder(
                                      itemCount: vendorList.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                _findField(),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: 8),
                                                      SizedBox(
                                                        height: 115,
                                                        width: width(context),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(builder: (context) => FilterPage(vendorList: vendorList,title: 'Transplanter Operator  Transplanter Owner  Nursery Mat Supplier  Sand Nursery Maker',price: false,)
                                                                    ),
                                                                );
                                                              },
                                                              child: Image.asset(
                                                                'assets/services/1.png',
                                                                width: 115,
                                                                height: 120,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => FilterPage(vendorList: vendorList,title: 'Labour Provider  Drone Services  Aana Sakthi',price: false,)
                                                                  ),
                                                                );
                                                              },
                                                              child: Image.asset(
                                                                'assets/services/2.png',
                                                                width: 115,
                                                                height: 120,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => FilterPage(vendorList: vendorList,title: 'Straw Baler Owner  Paddy Grain Merchant',price: false,)
                                                                  ),
                                                                );
                                                              },
                                                              child: Image.asset(
                                                                'assets/services/3.png',
                                                                width: 115,
                                                                height: 120,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Align(
                                                        alignment:
                                                            Alignment
                                                                .centerLeft,
                                                        child: RobotoText(
                                                          title: 'Our Services',
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 8,
                                                        ),
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 8),
                                                      // height: 336, //108, //326,
                                                      width: width(context),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          // _filterService(
                                                          //   'Transplanter Operator',
                                                          // ),
                                                          // _filterService(
                                                          //   'Transplanter Owner',
                                                          // ),
                                                          // _filterService(
                                                          //   'Nursery Mat Supplier',
                                                          // ),
                                                          // _filterService(
                                                          //   'Paddy Grain Merchant',
                                                          // ),
                                                          // _filterService(
                                                          //   'Labour Provider',
                                                          // ),
                                                          // _filterService(
                                                          //   'Sand Nursery Maker',
                                                          // ),
                                                          // _filterService(
                                                          //   'Drone Services Provider',
                                                          // ),
                                                          // _filterService(
                                                          //   'Straw Baler Owner',
                                                          // ),
                                                          // _filterService(
                                                          //   'Aana Sakthi',
                                                          // ),
                                                          Column(
                                                            children: [
                                                              _filterService(
                                                                'Transplanter \nOperator',
                                                              ),
                                                              _filterService(
                                                                'Transplanter \nOwner',
                                                              ),
                                                              _filterService(
                                                                'Nursery Mat \nSupplier',
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              _filterService(
                                                                'Paddy Grain \nMerchant',
                                                              ),
                                                              _filterService(
                                                                'Labour \nProvider',
                                                              ),
                                                              _filterService(
                                                                'Sand Nursery \nMaker',
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              _filterService(
                                                                'Drone Services \nProvider',
                                                              ),
                                                              _filterService(
                                                                'Straw Baler \nOwner',
                                                              ),
                                                              _filterService(
                                                                'Aana Sakthi',
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          bottom: 8,
                                                        ),
                                                    child: SizedBox(
                                                      width: width(context),
                                                      height: 200,
                                                      child:
                                                          AutoScrollingImageSlider(
                                                            imageUrls: url,
                                                          ),
                                                    ),
                                                  ),

                                                // if (haveBooking &&
                                                //     findController.text ==
                                                //         'Search')
                                                //   Column(
                                                //     children: [
                                                //       Padding(
                                                //         padding:
                                                //             const EdgeInsets.only(
                                                //               left: 18.0,
                                                //               top: 18,
                                                //             ),
                                                //         child: Align(
                                                //           alignment:
                                                //               Alignment
                                                //                   .centerLeft,
                                                //           child: RobotoText(
                                                //             title: 'Booked',
                                                //             size: 16,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       SizedBox(height: 18),
                                                //       Padding(
                                                //         padding:
                                                //             const EdgeInsets.symmetric(
                                                //               horizontal: 18.0,
                                                //             ),
                                                //         child: SizedBox(
                                                //           height: 80,
                                                //           width: width(context),
                                                //           child: StreamBuilder(
                                                //             stream:
                                                //                 FirebaseFirestore
                                                //                     .instance
                                                //                     .collection(
                                                //                       'riceKing',
                                                //                     )
                                                //                     .doc(
                                                //                       FirebaseAuth
                                                //                           .instance
                                                //                           .currentUser
                                                //                           ?.uid,
                                                //                     )
                                                //                     .collection(
                                                //                       'booked',
                                                //                     )
                                                //                     .orderBy(
                                                //                       'bookId',
                                                //                       descending:
                                                //                           true,
                                                //                     )
                                                //                     .snapshots(),
                                                //             builder: (
                                                //               context,
                                                //               snapshot,
                                                //             ) {
                                                //               if (snapshot
                                                //                   .hasError) {
                                                //                 return SizedBox();
                                                //               }
                                                //               if (snapshot
                                                //                       .connectionState ==
                                                //                   ConnectionState
                                                //                       .waiting) {
                                                //                 return Center(
                                                //                   child: SpinKitFadingCircle(
                                                //                     color:
                                                //                         Theme.of(
                                                //                           context,
                                                //                         ).colorScheme.surface,
                                                //                   ),
                                                //                 );
                                                //               }
                                                //               final bookedList =
                                                //                   snapshot
                                                //                       .data
                                                //                       ?.docs ??
                                                //                   [];
                                                //
                                                //               if (bookedList
                                                //                   .isEmpty) {
                                                //                 return Center(
                                                //                   child: LatoText(
                                                //                     title:
                                                //                         'No Booking Slot',
                                                //                     size: 16,
                                                //                     lineHeight: 1,
                                                //                   ),
                                                //                 );
                                                //               }
                                                //               print(bookedList);
                                                //               return ListView.builder(
                                                //                 scrollDirection:
                                                //                     Axis.horizontal,
                                                //                 itemCount:
                                                //                     bookedList
                                                //                         .length,
                                                //                 itemBuilder: (
                                                //                   context,
                                                //                   index,
                                                //                 ) {
                                                //                   return _bookingCard(
                                                //                     bookedList[index]
                                                //                         .data(),
                                                //                   );
                                                //                 },
                                                //               );
                                                //             },
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: RobotoText(
                                                    title: 'Vendor',
                                                    size: 16,
                                                  ),
                                                ),
                                                SizedBox(height: 16,),
                                              ],
                                            ),
                                          );
                                        }

                                        return _vendorCard(
                                          vendorList[index - 1].data(),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Theme.of(context).colorScheme.primary,
                    //   ),
                    //   padding: EdgeInsets.symmetric(horizontal: 8),
                    //   alignment: Alignment.centerLeft,
                    //   height: 30,
                    //   width: width(context),
                    //   child: TextScroll(
                    //     todayUpdates,
                    //     style: GoogleFonts.lato(
                    //       fontSize: 12,
                    //       color: Colors.white,
                    //     ),
                    //     velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                    //   ),
                    // ),
                  ],
                ),

                Visibility(
                  visible: showBook || showFilter,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showBook = showFilter = false;
                      });
                    },
                    child: Container(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.15),
                      height: height(context),
                      width: width(context),
                    ),
                  ),
                ),
                // Visibility(visible: showBook, child: _showBooked(booked)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Visibility(
                    visible: showFilter,
                    child: _userFilter(context),
                  ),
                ),
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
                icon: Badge(
                  isLabelVisible: (countNotification > 0) ? true : false,
                  child: Icon(Icons.notifications),
                ),
                title: RobotoText(title: 'Info', size: 14),
                backgroundColor: Colors.black,
              ),
              BottomBarItem(
                icon: const Icon(Icons.person),
                title: RobotoText(title: 'Me', size: 14),
                backgroundColor: Colors.black,
              ),
              if ( FirebaseAuth.instance.currentUser?.uid ==
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
            currentIndex: 0,
            onTap: (index) {
              setState(() {
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => UserNotificationPage(
                            id: FirebaseAuth.instance.currentUser?.uid ?? '',
                          ),
                    ),
                  );
                }
                if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserSettingPage(),
                    ),
                  );
                }
                if (index == 3) {
                  Navigator.push(
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
              Navigator.push(
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

  // Widget _bookingCard(Map<String, dynamic> booker) {
  //   return '${booker['status']}'.contains('Cancel')
  //       ? GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             booked = booker;
  //             showBook = true;
  //           });
  //         },
  //         child: Container(
  //           margin: const EdgeInsets.only(right: 18),
  //           height: 80,
  //           width: width(context) * 0.75,
  //           decoration: BoxDecoration(
  //             color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
  //             borderRadius: BorderRadius.all(Radius.circular(8)),
  //             border: Border.all(
  //               color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
  //               width: 1,
  //             ),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                 height: 80,
  //                 width: 80,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: OnlineImage(
  //                   url: booker['companyUrl'],
  //                   fit: BoxFit.fill,
  //                   border: 8,
  //                 ),
  //               ),
  //               SizedBox(width: 12),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   LatoText(
  //                     title: booker['vendorName'],
  //                     size: 14,
  //                     lineHeight: 1,
  //                   ),
  //                   SizedBox(
  //                     width: width(context) - 200,
  //                     height: 20,
  //                     child: LatoText(
  //                       title: booker['service'].toString().trim() ?? '',
  //                       size: 12,
  //                       lineHeight: 1,
  //                     ),
  //                   ),
  //                   LatoText(
  //                     title: '${booker['day']} - ${booker['time']}',
  //                     size: 10,
  //                     lineHeight: 1,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //       : SizedBox();
  // }

  // Widget _gridVendorCard(Map<String, dynamic> vendor) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => UserViewVendor(vendor: vendor),
  //         ),
  //       );
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(width: 1, color: Colors.white),
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             spreadRadius: 1,
  //             blurRadius: 5,
  //             color: Colors.black.withOpacity(0.05),
  //             offset: Offset(0, 0),
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //             height: 130,
  //             width: width(context),
  //             child: OnlineImage(
  //               url: vendor['companyUrl'],
  //               border: 10,
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 6.0, right: 6, top: 4),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 RobotoText(title: vendor['companyName'], size: 18),
  //                 LatoText(
  //                   title: vendor['description'],
  //                   size: 10,
  //                   lineHeight: 1,
  //                 ),
  //                 SizedBox(
  //                   height: 20,
  //                   child: ListView.builder(
  //                     scrollDirection: Axis.horizontal,
  //                     itemCount: 5,
  //                     itemBuilder: (context, index) {
  //                       return Padding(
  //                         padding: const EdgeInsets.only(right: 8.0),
  //                         child: Icon(
  //                           (int.parse(vendor['companyRating'] ?? 0) >
  //                               index)
  //                               ? Icons.star : Icons.star_border,
  //                           size: 14,
  //                           color:
  //                               (int.parse(vendor['companyRating'] ?? 0) >
  //                                       index)
  //                                   ? Colors.amberAccent
  //                                   : Theme.of(context).colorScheme.tertiary,
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 SizedBox(height: 4),
  //               ],
  //             ),
  //           ),
  //           TextAsButton(
  //             title: 'View',
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => UserViewVendor(vendor: vendor),
  //                 ),
  //               );
  //             },
  //             color: Theme.of(context).colorScheme.primary,
  //             size: 12,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _vendorCard(Map<String, dynamic> vendor) {
    List<dynamic> serviceList = vendor['companyServices'];
    print(vendor['userDetails']);
    return Container(
      height: 165,
      width: width(context),
      margin: EdgeInsets.only(bottom: 18, left: 16, right: 16),
      padding: const EdgeInsets.only(top: 18, bottom: 8, left: 8),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(shape: BoxShape.circle),
                margin: EdgeInsets.only(right: 8),
                child: OnlineImage(
                  url: vendor['companyUrl'],
                  border: 100,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: TextAsButton(
                  title: 'View',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserViewVendor(vendor: vendor),
                      ),
                    );
                  },
                  color: Theme.of(context).colorScheme.primary,
                  size: 12,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              height: 165,
              child: Column(
                spacing: 6,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RobotoText(
                    title: vendor['companyName'] ?? 'Company Name',
                    size: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                (int.parse(vendor['companyRating'] ?? 0) >
                                    index)
                                    ? Icons.star : Icons.star_border,
                                size: 16,
                                color:
                                    (int.parse(vendor['companyRating'] ?? 0) >
                                            index)
                                        ? Colors.amberAccent
                                        : Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      LatoText(title: vendor['userDetails']['town'], size: 10, lineHeight: 1),
                    ],
                  ),
                  Expanded(
                    child: LatoText(
                      title: serviceList.join(', '),
                      size: 10,
                      lineHeight: 2,
                    ),
                  ),
                  SizedBox(height: 0.1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonWithText(title: 'Book Now', onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => UserBookVendor(vendor: vendor),
                          ),
                        );
                      }, width: 140,height: 30,),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }

  // Widget _showBooked(Map<String, dynamic> booker) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         height: 200,
  //         width: width(context) - 36,
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
  //         child: OnlineImage(url: booker['companyUrl'] ?? '', border: 16),
  //       ),
  //       Container(
  //         width: width(context) - 36,
  //         padding: EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           color: Theme.of(context).colorScheme.surface,
  //           borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             LatoText(
  //               title: booker['vendorName'] ?? '',
  //               size: 24,
  //               lineHeight: 1,
  //             ),
  //             SizedBox(height: 8),
  //             LatoText(
  //               title: booker['description'] ?? '',
  //               size: 12,
  //               lineHeight: 3,
  //             ),
  //             SizedBox(height: 8),
  //             LatoText(
  //               title: booker['service'].toString().trim() ?? '',
  //               size: 18,
  //               lineHeight: 1,
  //             ),
  //             LatoText(
  //               title: '${booker['day'] ?? ''} - ${booker['time'] ?? ''}',
  //               size: 14,
  //               lineHeight: 1,
  //             ),
  //             LatoText(title: booker['status'] ?? '', size: 14, lineHeight: 1),
  //             LatoText(
  //               title: 'OTP: ${booker['otp'] ?? ''}',
  //               size: 14,
  //               lineHeight: 1,
  //             ),
  //             SizedBox(height: 18),
  //             TextAsButton(
  //               title: 'Message',
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder:
  //                         (context) => MessagePage(
  //                           vendorId: booker['vendorId'],
  //                           userId: booker['userId'],
  //                           isUser: true,
  //                         ),
  //                   ),
  //                 );
  //               },
  //               color: Theme.of(context).colorScheme.primary,
  //               size: 14,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  Widget _findField() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showFilter = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 6, bottom: 6),
        width: width(context),
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(45),
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                SizedBox(width: 24),
                SizedBox(
                  width: width(context) - 150,
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Search',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.tertiary.withOpacity(0.75),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.filter_list,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _userFilter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      height: height(context) * 0.5,
      width: width(context),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ListView(
        children: [
          SizedBox(height: 18),
          RobotoText(title: 'Filter!', size: 24),
          SizedBox(height: 18),
          RobotoText(title: 'By Price', size: 14),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _filterFields('below 1k'),
                _filterFields('1k-2k'),
                _filterFields('2k-3k'),
              ],
            ),
          ),
          SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _filterFields('3k-4k'),
                _filterFields('4k-5k'),
                _filterFields('above 5k'),
              ],
            ),
          ),
          SizedBox(height: 12),
          RobotoText(title: 'Location', size: 14),
          SizedBox(height: 10),
          TextFieldWithIcon(
            controller: otherController,
            hintText: 'Other',
            icons: Icons.search_rounded,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 12),
          ButtonWithText(
            title: 'Search',
            width: width(context) - 36,
            onPressed: () {
              if(otherController.text.isNotEmpty) {
                setState(() {
                showFilter = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilterPage(vendorList: vendorList,title: otherController.text,price: false,)
                  ),
                );
              });
              }
            },
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _filterFields(String key) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showFilter = false;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FilterPage(vendorList: vendorList,title: key,price: false,)
            ),
          );
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(45),
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: LatoText(title: key, size: 12, lineHeight: 1),
      ),
    );
  }

  Widget _filterService(String key) {
    String word = key;
    key = key.replaceAll('\n', '');
    return GestureDetector(
      onTap: () {
        setState(() {
          if (key == 'More') {
            setState(() {
              showFilter = true;
            });
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FilterPage(vendorList: vendorList,title: key,price: true,)
              ),
            );
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(4),
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/services/$key.png',
                width: 72, // 75
                height: 72,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 4),
            LatoText(title: word, size: 8, lineHeight: 3),
          ],
        ),
      ),
    );
  }
}
