import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/widget/staff.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/button.dart';
import '../../widget/inputField.dart';
import '../../widget/online_image.dart';
import '../../widget/text.dart';
import '../message_page.dart';

class VendorBooked extends StatefulWidget {
  final String id;
  const VendorBooked({super.key, required this.id});

  @override
  State<VendorBooked> createState() => _VendorBookedState();
}

class _VendorBookedState extends State<VendorBooked> {
  bool onLoad = false;
  bool onOTP = false;
  bool onGraph = false;
  bool showReason = false;
  String bookedOtp = '';
  String userId = '', vendorId = '', bookId = '';
  int onGoing = 0, complete = 0, cancel = 0;
  Map<String,dynamic> data = {};
  TextEditingController otp = TextEditingController(), reasonController = TextEditingController(), amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: width(context),
          height: height(context),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: width(context),
                    child: Image.asset('assets/banner.png', fit: BoxFit.fill),
                  ),
                  SizedBox(height: 14),
                  Stack(
                    alignment: Alignment(0, 0),
                    children: [
                      RobotoText(title: 'Booking\'s', size: 22),
                      // Align(alignment: Alignment.centerRight,child: IconAsButton(icon: Icons.auto_graph, onPressed: (){
                      //   setState(() {
                      //     onGraph = true;
                      //   });
                      // }, size: 20)),41
                    ],
                  ),
                  SizedBox(height: 14),
                  Expanded(
                    child: SizedBox(
                      width: width(context),
                      child: StreamBuilder(
                        stream:
                            FirebaseFirestore.instance
                                .collection('vendors')
                                .doc(widget.id)
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
                          final userData = snapshot.data?.docs ?? [];
                          if (userData.isEmpty) {
                            return Center(
                              child: LatoText(
                                title: 'No Booking slots',
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
                              return _bookingCard(data);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Visibility(
                visible: showReason,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showReason = false;
                    });
                  },

                  child: Container(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.2),
                    height: height(context),
                    width: width(context),
                    alignment: Alignment(0, 0),
                    child: Container(
                      height: 260,
                      padding: EdgeInsets.all(16),
                      width: width(context) * 0.8,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RobotoText(title: 'Cancel Slot', size: 24),
                          SizedBox(height: 20,),
                          LatoText(
                            title:
                            'Do You want to Cancel this slot',
                            size: 14,
                            lineHeight: 3,
                          ),
                          TextFieldWithIcon(controller: reasonController, hintText: 'Reason', icons: Icons.edit, keyboardType: TextInputType.text),
                          SizedBox(height: 12,),
                          ButtonWithText(title: 'Cancel', onPressed: () async {
                            if (reasonController.text.isNotEmpty) {
                                setState(() {
                                  onLoad = true;
                                });
                                await Database().cancelOrder(
                                  {...data,'reason' : reasonController.text},
                                  'Vendor Cancel This Order',
                                );

                                setState(() {
                                  onLoad = false;
                                  showReason = false;
                                });

                            } else {
                              showToast('Reason Compulsory', context);
                            }
                          }, width: width(context)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: onOTP,
                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.2),
                  height: height(context),
                  width: width(context),
                  alignment: Alignment(0, 0),
                  child: Container(
                    height: 314,
                    padding: EdgeInsets.all(16),
                    width: width(context) * 0.8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            RobotoText(title: 'OTP', size: 24),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconAsButton(
                                icon: Icons.close,
                                onPressed: () {
                                  setState(() {
                                    onOTP = false;
                                  });
                                },
                                size: 18,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        LatoText(title: 'Enter Otp', size: 14, lineHeight: 3),
                        LatoText(
                          title: 'Get the OTP by former',
                          size: 14,
                          lineHeight: 3,
                        ),
                        TextFieldWithIcon(
                          controller: otp,
                          hintText: 'OTP',
                          icons: Icons.timelapse,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 8),
                        TextFieldWithIcon(
                          controller: amount,
                          hintText: 'Amount Settled',
                          icons: Icons.currency_rupee,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 8),
                        ButtonWithText(
                          title: 'Finish',
                          onPressed: () async {
                            print(bookedOtp);
                            if (otp.text.trim().isEmpty || amount.text.trim().isEmpty) {
                              showToast('All field required!', context);
                              return;
                            } else {
                              if (otp.text == bookedOtp) {
                                setState(() {
                                  onLoad = true;
                                });
                                FocusScope.of(context).unfocus();
                                await Database().completeOrder(
                                  userId,
                                  vendorId,
                                  bookId,
                                  amount.text.trim(),
                                );
                                showToast('Completed Successfully', context);
                                setState(() {
                                  onOTP = false;
                                  onLoad = false;
                                });
                              } else {
                                showToast('Wrong OTP', context);
                              }
                            }
                          },
                          width: width(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: onGraph,
                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.2),
                  height: height(context),
                  width: width(context),
                  alignment: Alignment(0, 0),
                  child: Container(
                    height: 305,
                    padding: EdgeInsets.all(16),
                    width: width(context) * 0.8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            RobotoText(title: 'Status', size: 24),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconAsButton(
                                icon: Icons.close,
                                onPressed: () {
                                  setState(() {
                                    onGraph = false;
                                  });
                                },
                                size: 18,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        RobotoText(title: 'On Going', size: 14, ),
                        LatoText(
                          title: '$onGoing',
                          size: 14,
                          lineHeight: 1,
                        ),
                        SizedBox(height: 8,),
                        RobotoText(title: 'Complete', size: 14,),
                        LatoText(
                          title: '$complete',
                          size: 14,
                          lineHeight: 1,
                        ),
                        SizedBox(height: 8,),
                        RobotoText(title: 'Cancel', size: 14,),
                        LatoText(
                          title: '$cancel',
                          size: 14,
                          lineHeight: 1,
                        ),
                        SizedBox(height: 8,),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(visible: onLoad, child: MyLoader()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookingCard(Map<String, dynamic> booker) {
    if (!'${booker['status'] ?? ''}'.contains('Cancel')) {
        cancel++;
    } else if (!'${booker['status'] ?? ''}'.contains('Complete')) {
        complete++;
    } else {
        onGoing++;
    }
    return Container(
      width: width(context) * 0.8,
      margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
      padding: EdgeInsets.all(12),
      // decoration: BoxDecoration(
      //   color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
      //   borderRadius: BorderRadius.circular(8),
      //   border: Border.all(
      //     color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      //     width: 1,
      //   ),
      // ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LatoText(title: booker['userName'], size: 18, lineHeight: 1),
          LatoText(title: booker['address'], size: 14, lineHeight: 1),
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
          LatoText(title: booker['status'], size: 12, lineHeight: 1),
          SizedBox(height: 8),
          if (!'${booker['status'] ?? ''}'.contains('Cancel') &&
              !'${booker['status'] ?? ''}'.contains('Completed'))
            Column(
              children: [
                Divider(
                  height: 1,
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.5),
                ),
                SizedBox(height: 8),

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
                                  isUser: false,
                                ),
                          ),
                        );
                      },
                      color: Theme.of(context).colorScheme.primary,
                      size: 14,
                    ),
                    SizedBox(width: 12), TextAsButton(
                        title: 'Cancel',
                        onPressed: () {
                         setState(() {
                           showReason = true;
                           data = booker;
                         });
                        },
                        color: Colors.redAccent,
                        size: 14,
                      ),

                    Expanded(child: SizedBox(height: 10)),

                    TextAsButton(
                      title: 'OTP',
                      onPressed: () {
                        print(booker['otp']);
                        setState(() {
                          otp.clear();
                          bookedOtp = (booker['otp'] ?? '').toString();
                          onOTP = true;
                          userId = booker['userId'];
                          vendorId = booker['vendorId'];
                          bookId = booker['bookId'];
                        });
                      },
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 14,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
