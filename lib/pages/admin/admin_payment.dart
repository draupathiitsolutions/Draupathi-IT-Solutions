import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/pages/admin/view/vendor_accept.dart';
import 'package:riceking/widget/online_image.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/button.dart';
import '../../widget/inputField.dart';
import '../../widget/staff.dart';
import '../../widget/text.dart';

class AdminPayment extends StatefulWidget {
  const AdminPayment({super.key});

  @override
  State<AdminPayment> createState() => _AdminPaymentState();
}

class _AdminPaymentState extends State<AdminPayment> {
  bool onLoad = false, showProof = false, showDecline = false;
  Map<String, dynamic> book = {};
  String proofUrl = '';
  TextEditingController reasonController = TextEditingController();
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
                                  .collection('slotRequest')
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
                                  title: 'No Booking Request',
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
                                return adminBookedCard(data);
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
              visible: showDecline,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showDecline = false;
                  });
                },

                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.35),
                  height: height(context),
                  width: width(context),
                  alignment: Alignment(0, 0),
                  child: Container(
                    height: 230,
                    padding: EdgeInsets.all(16),
                    width: width(context) * 0.8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RobotoText(title: 'Decline Slot', size: 24),
                        SizedBox(height: 20),
                        LatoText(
                          title: 'Do You want to decline this slot',
                          size: 14,
                          lineHeight: 3,
                        ),
                        TextFieldWithIcon(
                          controller: reasonController,
                          hintText: 'Reason',
                          icons: Icons.edit,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 12),
                        ButtonWithText(
                          title: 'Decline',
                          onPressed: () async {
                            if (reasonController.text.isNotEmpty) {
                              setState(() {
                                onLoad = true;
                              });
                              FocusScope.of(context).unfocus();
                              bool success = await Database()
                                  .slotDecline(book['bookId'], book['userId'], {
                                    'reason': reasonController.text,
                                    'payment': 'pending',
                                  });
                              if (success) {
                                showToast('Declined Slot!', context);
                                AppNotification().send(
                                  book['userId'],
                                  'Booking Decline!',
                                  'Your request has been rejected.',
                                  'userNotification',
                                );
                              } else {
                                showToast('Something Went Wrong', context);
                              }

                              setState(() {
                                showDecline = false;
                                onLoad = false;
                              });
                            } else {
                              showToast('Reason Compulsory', context);
                            }
                          },
                          width: width(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showProof,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showProof = false;
                  });
                },
                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.35),
                  height: height(context),
                  width: width(context),
                  alignment: Alignment(0, 0),

                  child: showImage(),
                ),
              ),
            ),
            Visibility(visible: onLoad, child: MyLoader()),
          ],
        ),
      ),
    );
  }

  Widget adminBookedCard(Map<String, dynamic> data) {
    Map<String, dynamic> details = data;
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LatoText(title: details['service'], size: 14, lineHeight: 1),
          LatoText(title: details['userName'], size: 12, lineHeight: 1),
          LatoText(
            title: '${details['day']} ${details['time']}',
            size: 12,
            lineHeight: 1,
          ),
          LatoText(title: details['reason'], size: 12, lineHeight: 1),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          LatoText(title: details['paymentId'], size: 14, lineHeight: 1),
          IconAsButton(
            icon: Icons.photo,
            onPressed: () {
              setState(() {
                showProof = true;
                proofUrl = details['paymentUrl'];
              });
            },
            size: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextAsButton(
                title: 'Accept',
                onPressed: () async {
                  setState(() {
                    onLoad = true;
                  });
                  bool success = await Database().acceptSlot(data);
                  if(success) {
                    showToast('Slot Conformed!', context);
                  } else {
                    showToast('Something went wrong', context);
                  }
                  setState(() {
                    onLoad = false;
                  });
                },
                color: Theme.of(context).colorScheme.secondary,
                size: 16,
              ),
              TextAsButton(
                title: 'Decline',
                onPressed: () {
                  setState(() {
                    showDecline = true;
                    book = data;
                  });
                },
                color: Theme.of(context).colorScheme.secondary,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showImage() {
    return Container(
      width: width(context) * 0.8,
      height: height(context) * 0.7,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        constrained: true,
        boundaryMargin: const EdgeInsets.all(double.infinity),
        child: OnlineImage(url: proofUrl, fit: BoxFit.fill, border: 18),
      ),
    );
  }
}
