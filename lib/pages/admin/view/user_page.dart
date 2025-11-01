import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/pages/vendor/vendor_home_page.dart';
import 'package:riceking/widget/staff.dart';

import '../../../function/appFunction.dart';
import '../../../function/dataBaseFunction.dart';
import '../../../widget/button.dart';
import '../../../widget/online_image.dart';
import '../../../widget/text.dart';
import '../../message_page.dart';
import '../../user/user_view_vendor.dart';

class UserPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const UserPage({super.key, required this.data});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int pos = 0;
  bool showBook = false, onLoad = false,delete = false;
  Map<String, dynamic> booked = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional(0, 0),
          children: [
            SizedBox(
              height: height(context),
              width: width(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width(context),
                    height: 200,
                    child: Image.asset(
                      'assets/banner.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 14),
                  Expanded(
                    child: Container(
                      width: width(context),
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: StreamBuilder(
                        stream:
                            FirebaseFirestore.instance
                                .collection('riceKing')
                                .doc(widget.data['uid'])
                                .collection('booked')
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
                            itemCount: bookedList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 18),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RobotoText(title: 'Profile', size: 24),
                                        TextAsButton(
                                          title:
                                              widget.data['vendorId']
                                                      .toString()
                                                      .isEmpty
                                                  ? 'Only Former'
                                                  : widget.data['vendorId']
                                                          .toString() ==
                                                      'Pending'
                                                  ? 'Applied'
                                                  : 'Go to vendor',
                                          onPressed: () {
                                            if (widget.data['vendorId']
                                                    .toString()
                                                    .isNotEmpty &&
                                                widget.data['vendorId']
                                                        .toString() !=
                                                    'Pending') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => VendorHomePage(
                                                          id:
                                                              widget
                                                                  .data['vendorId'],
                                                      ),
                                                ),
                                              );
                                            }
                                          },
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                          size: 14,
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
                                      title: widget.data['name'],
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    const SizedBox(height: 12),
                                    LatoText(
                                      title: 'Phone No',
                                      size: 12,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title: '${widget.data['phone_no']}',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    const SizedBox(height: 12),
                                    LatoText(
                                      title: 'Address',
                                      size: 12,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title: widget.data['address'],
                                      size: 14,
                                      lineHeight: 3,
                                    ),
                                    const SizedBox(height: 8),
                                    GestureDetector(
                                      onDoubleTap: () async {
                                        setState(() {
                                          onLoad = true;
                                        });
                                        bool success = await Database()
                                            .deleteUser(
                                              widget.data['uid'],
                                              widget.data['vendorId'],
                                            );
                                        setState(() {
                                          onLoad = false;
                                        });
                                        if (success) {
                                          showToast('User Deleted!', context);
                                        } else {
                                          showToast(
                                            'Something went Wrong!',
                                            context,
                                          );
                                        }
                                      },
                                      child: Align(
                                        alignment: Alignment(0, 0),
                                        child: ButtonWithText(
                                          title: 'Delete',
                                          width: width(context),
                                          onPressed: () {
                                            showToast(
                                              'Double tap to delete!',
                                              context,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    Divider(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.tertiary,
                                    ),
                                    const SizedBox(height: 18),
                                    RobotoText(title: 'Book History', size: 24),
                                    const SizedBox(height: 18),
                                  ],
                                );
                              }
                              return _bookingCard(
                                bookedList[index - 1].data()
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
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
            Visibility(visible: onLoad, child: MyLoader()),
          ],
        ),
      ),
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
          child: OnlineImage(url: booker['companyUrl']??'',border: 16,),
        ),
        Container(
          width: width(context) - 36,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LatoText(title: booker['vendorName']??'', size: 24, lineHeight: 1),
              SizedBox(height: 8),
              LatoText(title: booker['description']??'', size: 12, lineHeight: 6),
              SizedBox(height: 8),
              LatoText(
                title: booker['service'].toString().trim() ?? '',
                size: 18,
                lineHeight: 1,
              ),
              LatoText(
                title: '${booker['day']??''} - ${booker['time']??''}',
                size: 14,
                lineHeight: 1,
              ),
              LatoText(
                title: booker['status']??'',
                size: 14,
                lineHeight: 1,
              ),
              LatoText(
                title: 'OTP: ${booker['otp']??''}',
                size: 14,
                lineHeight: 1,
              ),
              SizedBox(height: 18),
              if(!'${booker['status']??''}'.contains('Cancel'))
                GestureDetector(
                  onDoubleTap: () async {
                    setState(() {
                      delete = true;
                    });
                    await Database().cancelOrder(booker,'Admin Cancel This Order');
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
        margin: EdgeInsets.only(bottom: 8,left: 16,right: 16),
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
              child: OnlineImage(url: booker['companyUrl'],border: 16,fit: BoxFit.fitHeight,),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LatoText(
                    title: booker['vendorName'],
                    size: 18,
                    lineHeight: 1,
                  ),
                  LatoText(
                    title: booker['service'].toString().trim() ?? '',
                    size: 14,
                    lineHeight: 1,
                  ),
                  LatoText(
                    title: '${booker['day']} - ${booker['time']}',
                    size: 12,
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
}
