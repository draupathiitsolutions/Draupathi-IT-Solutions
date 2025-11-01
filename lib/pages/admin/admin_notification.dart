import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/pages/admin/view/vendor_accept.dart';
import 'package:riceking/pages/admin/view/vendor_extend.dart';
import 'package:riceking/widget/button.dart';
import 'package:riceking/widget/text.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/staff.dart';

class AdminNotification extends StatefulWidget {
  const AdminNotification({super.key});

  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  bool onLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: width(context),
              height: height(context),
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Spacer(),
                      RobotoText(title: 'Vendor Request', size: 16),
                      SizedBox(width: 24),
                    ],
                  ),
                  SizedBox(height: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        width: width(context),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('vendorRequest')
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
                            return ListView.builder(
                              itemCount: userData.length + 1,
                              itemBuilder: (context, index) {
                                if (index == userData.length) {
                                  return StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('update')
                                        .snapshots(),
                                    builder: (context, asyncSnapshot) {
                                      final req =
                                          asyncSnapshot.data?.docs ?? [];
                                      print(req);
                                      return SizedBox(
                                        height:  120,
                                        width: width(context),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: req.length,
                                          itemBuilder: (context, i) {
                                            return updateRequest(
                                              req[i].data(),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                }
                                final user = userData[index];
                                final data = user.data();
                                return adminVendorCard(data);
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
            Visibility(visible: onLoad, child: MyLoader()),
          ],
        ),
      ),
    );
  }

  Widget adminVendorCard(Map<String, dynamic> data) {
    Map<String, dynamic> details = data['userDetails'];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VendorAccept(data: data)),
        );
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(12),
          ),
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
          children: [
            Container(
              height: 100,
              width: 100,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                // borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.tertiary.withOpacity(0.25),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.business_sharp,
                color: Theme.of(context).colorScheme.tertiary,
                size: 42,
              ),
            ),
            SizedBox(width: 12),

            SizedBox(
              width: width(context) * 0.475,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LatoText(
                    title: details['businessName'],
                    size: 18,
                    lineHeight: 1,
                  ),
                  LatoText(
                    title: details['contactName'],
                    size: 12,
                    lineHeight: 1,
                  ),
                  LatoText(title: details['email'], size: 10, lineHeight: 1),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  TextAsButton(
                    title: 'view',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VendorAccept(data: data),
                        ),
                      );
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget updateRequest(Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VendorExtend(data: data)),
        );
      },
      child: Container(
        width: width(context)*0.9,
        margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(12),
          ),
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
          children: [
            Container(
              height: 100,
              width: 100,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                // borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.tertiary.withOpacity(0.25),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.business_sharp,
                color: Theme.of(context).colorScheme.tertiary,
                size: 42,
              ),
            ),
            SizedBox(width: 12),

            SizedBox(
              width: width(context) * 0.475,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LatoText(title: data['vendorName'], size: 18, lineHeight: 1),
                  LatoText(
                    title:
                        'Request to ${data['currentService'].length} new service',
                    size: 12,
                    lineHeight: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  TextAsButton(
                    title: 'view',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VendorExtend(data: data),
                        ),
                      );
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
