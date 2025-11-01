import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/widget/button.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/text.dart';
import 'admin_user_view.dart';

class AdminReport extends StatefulWidget {
  const AdminReport({super.key});

  @override
  State<AdminReport> createState() => _AdminReportState();
}

class _AdminReportState extends State<AdminReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SizedBox(
          height: height(context),
          width: width(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   width: width(context),
              //   height: 200,
              //   child: Image.asset('assets/banner.png', fit: BoxFit.fitWidth),
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
                    Image.asset(
                      'assets/appLogo.png',
                      width: 80,
                    ),
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
                  RobotoText(title: 'Report Management', size: 16),
                  IconButton(
                    onPressed: ()  async {
                      await Database().clearReport();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  )
                ],
              ),

              SizedBox(height: 14,),
              Expanded(
                child: SizedBox(
                  width: width(context),
                  child: StreamBuilder(
                    stream:
                        FirebaseFirestore.instance
                            .collection('report')
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return SizedBox();
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitWave(
                            color: Theme.of(context).colorScheme.surface,
                            itemCount: 7,
                          ),
                        );
                      }
                      final userData = snapshot.data?.docs ?? [];
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 12),
                        itemCount: userData.length,
                        itemBuilder: (context, index) {
                          final user = userData[index];
                          return showReport(user.data());
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showReport(Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
      padding: EdgeInsets.all(12),
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
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LatoText(title: 'Reporter name:', size: 11, lineHeight: 1),
          LatoText(title: data['name'], size: 14, lineHeight: 1),
          SizedBox(height: 8),
          LatoText(title: 'Reporter number:', size: 11, lineHeight: 1),
          LatoText(title: data['phone'], size: 14, lineHeight: 1),
          SizedBox(height: 8),
          Divider(color: Theme.of(context).colorScheme.secondary,thickness: 1,),
          LatoText(title: 'Reporter subject:', size: 11, lineHeight: 1),
          LatoText(title: data['subject'], size: 14, lineHeight: 3),
          SizedBox(height: 8),
          LatoText(title: 'Report:', size: 11, lineHeight: 1),
          LatoText(title: data['report'], size: 14, lineHeight: 20),
          SizedBox(height: 8),
          Align(
            alignment: Alignment(1, 0),
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(
                  color:Colors.black12,
                  offset: Offset(1, 1)
                )]
              ),
              child: IconAsButton(icon: Icons.phone_in_talk_sharp, onPressed: (){
                makePhoneCall(data['phone'],context);
              }, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
