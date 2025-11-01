import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/pages/admin/admin_home_page.dart';
import 'package:riceking/pages/admin/admin_notification.dart';
import 'package:riceking/pages/my_main_page.dart';
import 'package:riceking/pages/user/user_home_page.dart';
import 'package:riceking/pages/user/user_notification_page.dart';
import 'package:riceking/pages/user/user_setting_page.dart';

import 'firebase_options.dart';
import 'function/appFunction.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AppNotification().showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  await dotenv.load(fileName: ".env");

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  selectPage(initialMessage ?? RemoteMessage());
  AppBadgePlus.updateBadge(0);
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    customStatusBar(
      const Color(0xffFCFBFB),
      const Color(0xffFCFBFB),
      Brightness.dark,
      Brightness.dark,
    );
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Rice King',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: const Color(0xff2E402A), // 0xff5D8736 0xff693000 0xff4CAF50
          secondary: const Color(0xff2E402A), // 0xffA0D683 0xffffb312 0xffFFC107 0xffF7C12B
          tertiary: const Color(0xff212121),
          surface: const Color(0xffFCFBFB), // 0xffF8F8F8
        ),
        useMaterial3: true,
      ),
      routes: {
        '/mainPage': (context) => const MyMainPage(),
        '/userHomePage': (context) => UserHomePage(),
        '/vendorHomePage': (context) => UserSettingPage(),
        '/vendorRequest': (context) => AdminNotification(),
        '/adminPage': (context) => AdminHomePage(),
        '/userRequest': (context) => UserSettingPage(),
        '/userNotification':
            (context) => UserNotificationPage(
          id: FirebaseAuth.instance.currentUser!.uid,
        ),
      },
      home: const MyMainPage(),
    );
  }
}
