import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/widget/button.dart';
import 'package:riceking/widget/inputField.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/online_image.dart';
import '../../widget/staff.dart';
import '../../widget/text.dart';

class VendorBookingRequest extends StatefulWidget {
  final String id;
  const VendorBookingRequest({super.key, required this.id});

  @override
  State<VendorBookingRequest> createState() => _VendorBookingRequestState();
}

class _VendorBookingRequestState extends State<VendorBookingRequest> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  bool showDelete = false,onLoad = false,showAccept = false;
  Map<String,dynamic> book = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                    width: width(context),
                    height: 200,
                    child: Image.asset('assets/banner.png', fit: BoxFit.fill),
                  ),
                  SizedBox(height: 14),
                  RobotoText(title: 'Booking Request', size: 22),
                  SizedBox(height: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        width: width(context),
                        child: StreamBuilder(
                          stream:
                              FirebaseFirestore.instance
                                  .collection('vendors')
                                  .doc(widget.id)
                                  .collection('request')
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
                                  title: 'No Booked Request',
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
                                return vendorBookedCard(data);
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
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8),
              child: IconAsButton(icon: Icons.arrow_back_outlined, onPressed: (){
                Navigator.pop(context);
              }, size: 28),
            ),
            Visibility(
              visible: showDelete,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showDelete = false;
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
                        RobotoText(title: 'Decline Slot', size: 24),
                        SizedBox(height: 20,),
                        LatoText(
                          title:
                          'Do You want to decline this slot',
                          size: 14,
                          lineHeight: 3,
                        ),
                        TextFieldWithIcon(controller: reasonController, hintText: 'Reason', icons: Icons.edit, keyboardType: TextInputType.text),
                        SizedBox(height: 12,),
                        ButtonWithText(title: 'Decline', onPressed: () async {
                          if (reasonController.text.isNotEmpty) {
                            setState(() {
                              onLoad = true;
                            });
                            FocusScope.of(context).unfocus();
                              bool success = await Database().userSlotRequest(book['vendorId'], book['bookId'],book['userId'],{
                                'service':  book['service'],
                                'day': book['day'],
                                'reason':reasonController.text,
                                'for': 'decline',
                                'vendorName' : book['businessName'],
                              });
                            if(success) {
                              showToast('Declined Slot!', context);
                              AppNotification().send(book['userId'], 'Booking Decline!', 'Your request has been rejected.', 'userNotification');
                            } else {
                              showToast('Something Went Wrong', context);
                            }

                            setState(() {
                              showDelete = false;
                              onLoad = false;
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
              visible: showAccept,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showAccept = false;
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
                    height: 335,
                    padding: EdgeInsets.all(16),
                    width: width(context) * 0.8,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RobotoText(title: 'Accept Slot', size: 24),
                        SizedBox(height: 20,),
                        LatoText(
                          title:
                          'Do You want to Accept this slot',
                          size: 14,
                          lineHeight: 3,
                        ),LatoText(
                          title:
                          book['day']??'',
                          size: 12,
                          lineHeight: 3,
                        ),
                        TextFieldWithIcon(controller: reasonController, hintText: 'Time', icons: Icons.timelapse, keyboardType: TextInputType.text),
                        SizedBox(height: 6,),TextFieldWithIcon(controller: rateController, hintText: 'Share Price details', icons: Icons.currency_rupee, keyboardType: TextInputType.text),
                        SizedBox(height: 12,),
                        ButtonWithText(title: 'Accept', onPressed: () async {
                          if (reasonController.text.isNotEmpty && rateController.text.isNotEmpty) {

                              setState(() {
                                onLoad = true;
                              });
                              FocusScope.of(context).unfocus();
                              // bool success = await Database().userSlotRequest(book['vendorId'], book['bookId'],book['userId'],{
                              //   'for': 'accept',...book,'time':reasonController.text, 'reason': rateController.text,'payment': 'pending',
                              // });

                              bool success = await Database().acceptSlot({
                                'for': 'accept',...book,'time':reasonController.text, 'reason': rateController.text,'payment': 'pending',
                              });

                              if(success) {
                                showToast('Slot Conform!', context);
                                AppNotification().send(book['userId'], 'Booking Accepted!', 'Your request has been accepted.', 'userNotification');
                              } else {
                                showToast('Something Went Wrong', context);
                              }
                              setState(() {
                                showAccept = false;
                                onLoad = false;
                              });

                          } else {
                            showToast('Field Compulsory', context);
                          }
                        }, width: width(context)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(visible: onLoad,child: MyLoader())
          ],
        ),
      ),
    );
  }

  Widget vendorBookedCard(Map<String, dynamic> booked) {
    print(booked);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          height: 180,
          width: width(context),
          // decoration: BoxDecoration(
          //   color: Theme.of(context).colorScheme.p.withOpacity(0.15),
          //   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    margin: EdgeInsets.only(right: 8,left: 12,top: 12),
                    child: OnlineImage(
                      url: booked['companyUrl'],
                      border: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        left: 12,
                        right: 12
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RobotoText(title: booked['userName'], size: 14),
                          const SizedBox(height: 2),
                          LatoText(
                            title: booked['address'],
                            size: 12,
                            lineHeight: 2,
                          ),
                          SizedBox(height: 2),
                          LatoText(
                            title: booked['service'],
                            size: 12,
                            lineHeight: 1,
                          ),
                          LatoText(title: booked['day'], size: 12, lineHeight: 1),
                          LatoText(title: booked['acre'], size: 10, lineHeight: 1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextAsButton(
                      title: 'Accept',
                      onPressed: (){
                        setState(() {
                          reasonController.text;
                          showAccept = true;
                          book = booked;
                        });
                      },
                      color: Colors.green,
                      size: 14,
                    ),
                    TextAsButton(
                      title: 'Decline',
                      onPressed: () {
                        setState(() {
                          reasonController.text;
                          showDelete = true;
                          book = booked;
                        });
                      },
                      color: Colors.redAccent,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
