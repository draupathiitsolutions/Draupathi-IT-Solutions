import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/pages/admin/view/user_page.dart';
import 'package:riceking/widget/button.dart';

import '../../function/appFunction.dart';
import '../../widget/text.dart';

class AdminUserView extends StatefulWidget {
  final data;
  const AdminUserView({super.key, required this.data});

  @override
  State<AdminUserView> createState() => _AdminUserViewState();
}

class _AdminUserViewState extends State<AdminUserView> {
  @override
  Widget build(BuildContext context) {
    final userData = widget.data;
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
              //   child: Image.asset(
              //     'assets/banner.png',
              //     fit: BoxFit.fitWidth,
              //   ),
              // ),
              // SizedBox(height: 14),
              // RobotoText(title: appName, size: 22),
              // SizedBox(height: 4),
              // LatoText(title: 'Users', size: 16, lineHeight: 1),
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
                  LatoText(title: 'Users', size: 16, lineHeight: 1),
                  SizedBox(
                    width: 24,
                  )
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: width(context),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 12),
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      final user = userData[index];
                      return ShowUser(data: user.data());
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
}

class ShowUser extends StatefulWidget {
  final Map<String, dynamic> data;
  const ShowUser({super.key, required this.data});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserPage(data: widget.data)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 18,right: 18, bottom: 12),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(12),bottomLeft: Radius.circular(50),bottomRight: Radius.circular(12)),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(

              children: [
                Container(
                  height: 100,
                  width: 100,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                        // borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.25),width: 1,
                          )
                      ),
                      alignment: Alignment.center,
                    child: Icon(Icons.person,color: Theme.of(context).colorScheme.tertiary,size: 42,)
                    ),
                SizedBox(width: 12),
                SizedBox(
                    width:width(context)*0.475,
                  child: Column(
                    spacing: 6,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LatoText(title: widget.data['name'], size: 16, lineHeight: 1),
                      LatoText(
                        title: widget.data['phone_no'] ?? '',
                        size: 12,
                        lineHeight: 1,
                      ),
                      LatoText(title: widget.data['address'], size: 10, lineHeight: 1),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextAsButton(title: '', onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage(data: widget.data)),
                );
              }, color: Theme.of(context).colorScheme.primary, size: 14),
            ),
          ],
        ),
      ),
    );
  }
}
