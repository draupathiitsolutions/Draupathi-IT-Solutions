import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:riceking/function/appFunction.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/pages/user/my_auth_page.dart';
import 'package:riceking/pages/user/user_home_page.dart';
import 'package:riceking/widget/text.dart';

import 'admin/admin_home_page.dart';


class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  bool onLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('msg arrival');
      AppNotification().showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AppBadgePlus.updateBadge(0);
      selectPage(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppNotification().requestNotificationPermission();
    // return MyAuthPage();
    // if(allow()) {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        if(FirebaseAuth.instance.currentUser?.uid == 'n1BeFWiCKrc3WkOISEHhe1OJcip2'
            || FirebaseAuth.instance.currentUser?.uid == adminId){
          return const AdminHomePage();
        } else {
          return const UserHomePage();
        }
      }
      // return const UserHomePage();
      return const MyAuthPage();
    // } return Scaffold();
  }
}
