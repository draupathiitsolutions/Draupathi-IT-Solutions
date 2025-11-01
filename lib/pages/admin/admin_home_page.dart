import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riceking/function/appFunction.dart';
import 'package:riceking/pages/admin/admin_user_view.dart';
import 'package:riceking/pages/admin/admin_vendor_view.dart';
import 'package:riceking/widget/button.dart';
import 'package:riceking/widget/staff.dart';
import 'package:riceking/widget/text.dart';

import '../../function/dataBaseFunction.dart';
import '../user/user_home_page.dart';
import 'admin_notification.dart';
import 'admin_payment.dart';
import 'admin_report.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool onAdd = false;

  int requestCount = 0, reportCount = 0, slotCount = 0;
  bool onLoad = false;
  String url1 = '';
  String url2 = '';
  String url3 = '';
  XFile? imageFile1;
  XFile? imageFile2;
  XFile? imageFile3;
  bool showLoader = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> users = [];
  List<Map<String,dynamic>> updateServices = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> vendors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      onLoad = true;
    });
    getData();
  }

  Future<void> getData() async {
    await Future.wait([
      Database().getUrl().then((value) {
        setState(() {
          url1 = value['banner1'] ?? '';
          url2 = value['banner2'] ?? '';
          url3 = value['banner3'] ?? '';
        });
      }), Database().getUpdateService().then((value) {
    setState(() {
    updateServices = value;
    print(updateServices);
    });}),
    Database().getRequestCount().then((value) {
        setState(() {
          requestCount = value;
          print(requestCount);
        });
      }),
      Database().getUserCount().then((value) {
        setState(() {
          users = value;
        });
      }),
      Database().getVendorCount().then((value) {
        setState(() {
          vendors = value;
        });
      }),
      Database().getReportCount().then((value) {
        setState(() {
          reportCount = value;
        });
      }),
      Database().getSlotCount().then((value) {
        setState(() {
          slotCount = value;
        });
      }),
    ]);
    setState(() {
      onLoad = false;
    });
  }

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
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    height: height(context),
                    width: width(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: width(context),
                        //   height: 200,
                        //   child: Image.asset(
                        //     'assets/banner.png',
                        //     fit: BoxFit.fitWidth,
                        //   ),
                        // ),
                        SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RobotoText(title: 'Welcome to ', size: 14),
                                  RobotoText(title: 'Rice King', size: 26),
                                ],
                              ),
                              Spacer(),

                              Image.asset('assets/appLogo.png', width: 80),
                            ],
                          ),
                        ),
                        SizedBox(height: 36),
                        LatoText(
                          title: 'Admin Dashboard',
                          size: 16,
                          lineHeight: 1,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 24.0,
                              right: 24,
                              left: 24,
                            ),
                            child: SizedBox(
                              width: width(context),
                              child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminUserView(data: users),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width(context) * 0.5 - 36,
                                          height: width(context) * 0.5 - 36,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 12,
                                          ),
                                          margin: EdgeInsets.only(top: 24),
                                          // decoration: BoxDecoration(
                                          //   color: Theme.of(
                                          //     context,
                                          //   ).colorScheme.secondary.withOpacity(0.15),
                                          //   borderRadius: BorderRadius.all(
                                          //     Radius.circular(8),
                                          //   ),
                                          //   border: Border.all(
                                          //     width: 1,
                                          //     color: Theme.of(
                                          //       context,
                                          //     ).colorScheme.secondary.withOpacity(0.5),
                                          //   ),
                                          // ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                color: Colors.black.withOpacity(
                                                  0.05,
                                                ),
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                            border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              RobotoText(
                                                title: 'Total Users',
                                                size: 14,
                                              ),
                                              LatoText(
                                                title: '${users.length}',
                                                size: 20,
                                                lineHeight: 1,
                                              ),
                                              TextAsButton(
                                                title: 'View',
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminUserView(data: users,),
                                                    ),
                                                  );
                                                },
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminVendorView(
                                                    data: vendors,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width(context) * 0.5 - 36,
                                          height: width(context) * 0.5 - 36,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 12,
                                          ),
                                          margin: EdgeInsets.only(top: 24),
                                          // decoration: BoxDecoration(
                                          //   color: Theme.of(
                                          //     context,
                                          //   ).colorScheme.secondary.withOpacity(0.15),
                                          //   borderRadius: BorderRadius.all(
                                          //     Radius.circular(8),
                                          //   ),
                                          //   border: Border.all(
                                          //     width: 1,
                                          //     color: Theme.of(
                                          //       context,
                                          //     ).colorScheme.secondary.withOpacity(0.5),
                                          //   ),
                                          // ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                color: Colors.black.withOpacity(
                                                  0.05,
                                                ),
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                            border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              RobotoText(
                                                title: 'Total Vendors',
                                                size: 14,
                                              ),
                                              LatoText(
                                                title: '${vendors.length}',
                                                size: 20,
                                                lineHeight: 1,
                                              ),
                                              TextAsButton(
                                                title: 'View',
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminVendorView(
                                                            data: vendors,
                                                          ),
                                                    ),
                                                  );
                                                },
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  RobotoText(title: 'Requests:', size: 14),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    width: width(context),
                                    height: 100,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Badge.count(
                                              isLabelVisible: requestCount != 0,
                                              count: requestCount,
                                              offset: Offset(5, -5),

                                              child: GestureDetector(
                                                onTap: () {
                                                  if (!onLoad) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AdminNotification(),
                                                      ),
                                                    );
                                                  } else {
                                                    showToast(
                                                      'Loading...',
                                                      context,
                                                    );
                                                  }
                                                  setState(() {
                                                    requestCount = 0;
                                                  });
                                                },
                                                child: Container(
                                                  width: 150,
                                                  height: 100,
                                                  alignment: Alignment.center,
                                                  // decoration: BoxDecoration(
                                                  //   color: Theme.of(context)
                                                  //       .colorScheme
                                                  //       .secondary
                                                  //       .withOpacity(0.15),
                                                  //   borderRadius: BorderRadius.all(
                                                  //     Radius.circular(8),
                                                  //   ),
                                                  //   border: Border.all(
                                                  //     width: 1,
                                                  //     color: Theme.of(context)
                                                  //         .colorScheme
                                                  //         .secondary
                                                  //         .withOpacity(0.5),
                                                  //   ),
                                                  // ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 5,
                                                        color: Colors.black
                                                            .withOpacity(0.05),
                                                        offset: Offset(0, 0),
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      LatoText(
                                                        title: 'Vendors',
                                                        size: 16,
                                                        lineHeight: 1,
                                                      ),
                                                      TextAsButton(
                                                        title: 'View',
                                                        onPressed: () {
                                                          if (!onLoad) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AdminNotification(),
                                                              ),
                                                            );
                                                          } else {
                                                            showToast(
                                                              'Loading...',
                                                              context,
                                                            );
                                                          }
                                                          setState(() {
                                                            requestCount = 0;
                                                          });
                                                        },
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 18),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Badge.count(
                                              isLabelVisible: reportCount != 0,
                                              count: reportCount,
                                              offset: Offset(5, -5),

                                              child: GestureDetector(
                                                onTap: () {
                                                  if (!onLoad) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AdminReport(),
                                                      ),
                                                    );
                                                  } else {
                                                    showToast(
                                                      'Loading...',
                                                      context,
                                                    );
                                                  }
                                                  setState(() {
                                                    reportCount = 0;
                                                  });
                                                },
                                                child: Container(
                                                  width: 150,
                                                  height: 100,
                                                  alignment: Alignment.center,
                                                  // decoration: BoxDecoration(
                                                  //   color: Theme.of(context)
                                                  //       .colorScheme
                                                  //       .secondary
                                                  //       .withOpacity(0.15),
                                                  //   borderRadius: BorderRadius.all(
                                                  //     Radius.circular(8),
                                                  //   ),
                                                  //   border: Border.all(
                                                  //     width: 1,
                                                  //     color: Theme.of(context)
                                                  //         .colorScheme
                                                  //         .secondary
                                                  //         .withOpacity(0.5),
                                                  //   ),
                                                  // ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 5,
                                                        color: Colors.black
                                                            .withOpacity(0.05),
                                                        offset: Offset(0, 0),
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),

                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      LatoText(
                                                        title: 'Reports',
                                                        size: 16,
                                                        lineHeight: 1,
                                                      ),
                                                      TextAsButton(
                                                        title: 'View',
                                                        onPressed: () {
                                                          if (!onLoad) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AdminReport(),
                                                              ),
                                                            );
                                                          } else {
                                                            showToast(
                                                              'Loading...',
                                                              context,
                                                            );
                                                          }
                                                          setState(() {
                                                            reportCount = 0;
                                                          });
                                                        },
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 18),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Badge.count(
                                              isLabelVisible:
                                                  false, // slotCount != 0,
                                              count: slotCount,
                                              offset: Offset(5, -5),
                                              child: GestureDetector(
                                                onTap: () {
                                                  showToast(
                                                    'This will able on upcoming updates',
                                                    context,
                                                  );
                                                  //
                                                  // if (!onLoad) {
                                                  //   Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(builder: (context) => AdminPayment()),
                                                  //   );
                                                  // } else {
                                                  //   showToast('Loading...', context);
                                                  // }
                                                  // setState(() {
                                                  //   slotCount = 0;
                                                  // });
                                                },
                                                child: Container(
                                                  width: 150,
                                                  height: 100,
                                                  alignment: Alignment.center,
                                                  // decoration: BoxDecoration(
                                                  //   color: Theme.of(context)
                                                  //       .colorScheme
                                                  //       .secondary
                                                  //       .withOpacity(0.15),
                                                  //   borderRadius: BorderRadius.all(
                                                  //     Radius.circular(8),
                                                  //   ),
                                                  //   border: Border.all(
                                                  //     width: 1,
                                                  //     color: Theme.of(context)
                                                  //         .colorScheme
                                                  //         .secondary
                                                  //         .withOpacity(0.5),
                                                  //   ),
                                                  // ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 5,
                                                        color: Colors.black
                                                            .withOpacity(0.05),
                                                        offset: Offset(0, 0),
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      LatoText(
                                                        title: 'Slots',
                                                        size: 16,
                                                        lineHeight: 1,
                                                      ),
                                                      TextAsButton(
                                                        title: 'View',
                                                        onPressed: () {
                                                          showToast(
                                                            'This will able on upcoming updates',
                                                            context,
                                                          );
                                                          //
                                                          // if (!onLoad) {
                                                          //   Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(builder: (context) => AdminPayment()),
                                                          //   );
                                                          // } else {
                                                          //   showToast('Loading...', context);
                                                          // }
                                                          // setState(() {
                                                          //   slotCount = 0;
                                                          // });
                                                        },
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Divider(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                    thickness: 1,
                                  ),
                                  SizedBox(height: 20),
                                  // RobotoText(title: 'Commission Earned:', size: 14),
                                  // SizedBox(
                                  //   height: 20,
                                  //   width: width(context),
                                  //   child: StreamBuilder(
                                  //       stream:
                                  //       FirebaseFirestore.instance.collection('official').snapshots(),
                                  //     builder: (context,snapshot) {
                                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                                  //         return Center(
                                  //           child: SpinKitFadingCircle(
                                  //             color: Theme.of(context).colorScheme.surface,
                                  //           ),
                                  //         );
                                  //       }
                                  //       final amount = snapshot.data?.docs ?? [];
                                  //       return LatoText(title: amount[1].data()['amount'].toString(), size: 14, lineHeight: 1);
                                  //     }
                                  //   ),
                                  // ),SizedBox(
                                  //   height: 20,
                                  // ),
                                  RobotoText(title: 'Banners:', size: 14),
                                  SizedBox(height: 8),
                                  Column(
                                    spacing: 20,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          getImage(ImageSource.gallery, 0);
                                        },
                                        child: Row(
                                          spacing: 4,
                                          children: [
                                            LatoText(
                                              title: 'Change Banner 1',
                                              size: 12,
                                              lineHeight: 1,
                                            ),
                                            Icon(
                                              Icons.image,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.tertiary,
                                              size: 12,
                                            ),
                                            if (imageFile1 != null)
                                              LatoText(
                                                title: imageFile1!.name,
                                                size: 12,
                                                lineHeight: 1,
                                              ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          getImage(ImageSource.gallery, 1);
                                        },
                                        child: Row(
                                          spacing: 4,
                                          children: [
                                            LatoText(
                                              title: 'Change Banner 2',
                                              size: 12,
                                              lineHeight: 1,
                                            ),
                                            Icon(
                                              Icons.image,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.tertiary,
                                              size: 12,
                                            ),
                                            if (imageFile2 != null)
                                              LatoText(
                                                title: imageFile2!.name,
                                                size: 12,
                                                lineHeight: 1,
                                              ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          getImage(ImageSource.gallery, 2);
                                        },
                                        child: Row(
                                          spacing: 4,
                                          children: [
                                            LatoText(
                                              title: 'Change Banner 3',
                                              size: 12,
                                              lineHeight: 1,
                                            ),
                                            Icon(
                                              Icons.image,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.tertiary,
                                              size: 12,
                                            ),
                                            if (imageFile3 != null)
                                              LatoText(
                                                title: imageFile3!.name,
                                                size: 12,
                                                lineHeight: 1,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20),
                                  ButtonWithText(
                                    title: 'Update Banner',
                                    onPressed: () async {
                                      setState(() {
                                        showLoader = true;
                                      });
                                      if (imageFile1 != null) {
                                        url1 = await Database().uploadImage(
                                          imageFile1!,
                                          1,
                                        );
                                      }
                                      if (imageFile2 != null) {
                                        url2 = await Database().uploadImage(
                                          imageFile2!,
                                          2,
                                        );
                                      }
                                      if (imageFile3 != null) {
                                        url3 = await Database().uploadImage(
                                          imageFile3!,
                                          3,
                                        );
                                      }
                                      print('$url1\n$url2\n$url3');
                                      if (url1.isNotEmpty ||
                                          url2.isNotEmpty ||
                                          url3.isNotEmpty) {
                                        bool status = await Database()
                                            .updateUrl(url1, url2, url3);
                                        if (status) {
                                          showToast(
                                            'Banner updated successfully',
                                            context,
                                          );
                                          getData();
                                        }
                                        imageFile1 = imageFile2 = imageFile3 =
                                            null;
                                      } else {
                                        showToast(
                                          'No image selected for Banner.',
                                          context,
                                        );
                                      }
                                      setState(() {
                                        showLoader = false;
                                      });
                                    },
                                    width: width(context),
                                  ),
                                  SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Visibility(visible: showLoader, child: MyLoader()),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const UserHomePage()),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          );
  }

  Future<void> getImage(ImageSource source, int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? data = await picker.pickImage(source: source);

    if (data != null) {
      setState(() {
        if (index == 0) {
          imageFile1 = data;
        } else if (index == 1) {
          imageFile2 = data;
        } else if (index == 2) {
          imageFile3 = data;
        }
      });
    } else {
      showToast('No image selected for Banner.', context);
    }
  }
}
