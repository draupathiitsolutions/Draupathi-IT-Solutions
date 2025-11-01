import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/pages/user/user_home_page.dart';
import 'package:riceking/widget/staff.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/button.dart';
import '../../widget/inputField.dart';
import '../../widget/text.dart';
import '../admin/admin_home_page.dart';

class MyInfoPage extends StatefulWidget {
  final String phone;
  const MyInfoPage({super.key, required this.phone});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  String vendorId = '';
  TextEditingController locationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool showLoader = false;
  String token = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    phoneController = TextEditingController(text: widget.phone);
    FirebaseMessaging.instance.getToken().then((t) async {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null && '$t'.isNotEmpty) {
        setState(() {
          token = t!;
        });
        print(" Token refreshed and updated: $t");
      } else {
        print(" Failed to update token: User ID is null or token is empty.");
      }
    });
  }

  Future<void> getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await Database().getProfile();
      if (userData.isNotEmpty) {
        setState(() {
          nameController.text = userData['name'] ?? '';
          locationController.text = userData['address'] ?? '';
          vendorId = userData['vendorId'] ?? '';
        });
      }
    }
    // String loc = await getCurrentLocation(context);
    // setState(() {
    //   locationController = TextEditingController(text: loc);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: height(context),
              width: width(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height(context)*0.35,
                    width: width(context),
                    child: Image.asset('assets/bg_image.png',fit: BoxFit.fitWidth,),
                  ),
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RobotoText(title: 'Info', size: 48),
                          RobotoText(
                            title: 'Make your profile in $appName',
                            size: 12,
                          ),
                        ],
                      ),
                      SizedBox(height: 36),
                      TextFieldWithIcon(
                        controller: nameController,
                        hintText: 'Name',
                        icons: Icons.person_2_rounded,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 12),
                      TextFieldWithIcon(
                        controller: phoneController,
                        hintText: 'Phone Number',
                        icons: Icons.phone,
                        keyboardType: TextInputType.none,
                      ),
                      SizedBox(height: 12),
                      TextFieldWithIcon(
                        controller: locationController,
                        hintText: 'Address',
                        icons: Icons.location_on_rounded,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: 36),
                      ButtonWithText(
                        title: 'Save',                      width: width(context)*0.8,

                        onPressed: () async {
                          if (nameController.text.isEmpty ||
                              phoneController.text.isEmpty ||
                              locationController.text.isEmpty) {
                            showToast('Please fill all the fields', context);
                          }
                          else if(phoneController.text.length < 10) {
                            showToast('Please enter a valid phone number', context);
                          }
                          else {
                            FocusScope.of(context).unfocus();
                            await setData();
                          }
                        },
                      ),
                      SizedBox(height: 32),
                      LatoText(title: 'Terms of policy', size: 10, lineHeight: 1,),
                      SizedBox(height: 62),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showLoader,
              child: MyLoader(),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> setData() async {
    Map<String, dynamic> data = {
      'name': nameController.text,
      'phone_no': phoneController.text,
      'address': locationController.text,
      'uid':userId,
      'vendorId': vendorId,
      'language':'English',
      'fcmToken':token,
    };
    setState(() {
      showLoader = true;
    });
    await Database().setProfile(userId, data)? {
      setState(() {
        showLoader = false;
      }),
      if(FirebaseAuth.instance.currentUser?.uid == 'n1BeFWiCKrc3WkOISEHhe1OJcip2'
          || FirebaseAuth.instance.currentUser?.uid == adminId){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHomePage(),
          ),
        ),
  } else
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserHomePage(),
        ),
      ),
    } :ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Unable to save data',
        ),
      ),
    );
  }
}
