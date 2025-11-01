import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../function/appFunction.dart';
import '../../widget/button.dart';
import '../../widget/staff.dart';
import '../../widget/text.dart';

class VendorReviewPage extends StatefulWidget {
  final String id;
  const VendorReviewPage({super.key, required this.id});

  @override
  State<VendorReviewPage> createState() => _VendorReviewPageState();
}

class _VendorReviewPageState extends State<VendorReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance
                  .collection('vendors')
                  .doc(widget.id)
                  .collection('review')
                  .orderBy('rating', descending: true)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return SizedBox();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                      Container(
                        height: 200,
                        width: width(context),
                        child: Image.asset(
                          'assets/banner.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 18),
                            Row(
                              children: [
                                IconAsButton(icon: Icons.arrow_back_outlined, onPressed: (){
                                  Navigator.pop(context);
                                }, size: 28),
                                SizedBox(width: 12),
                                RobotoText(title: 'Review', size: 24),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return MyReviews(data: bookedList[index - 1].data());
              },
            );
          },
        ),
      ),
    );
  }
}

class MyReviews extends StatefulWidget {
  final Map<String, dynamic> data;
  const MyReviews({super.key, required this.data});

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18,left: 24,right: 24),
      padding: EdgeInsets.all(18),
      width: width(context),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RobotoText(title: widget.data['by'], size: 16),
          SizedBox(
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.star,
                    size: 14,
                    color:
                    ((widget.data['rating'] ?? 0) > index)
                        ? Colors.amberAccent
                        : Theme.of(context).colorScheme.tertiary,
                  ),
                );
              },
            ),
          ),
          LatoText(title: widget.data['review'], size: 14, lineHeight: 5),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color:
              Theme.of(
                context,
              ).colorScheme.tertiary.withOpacity(0.25),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
