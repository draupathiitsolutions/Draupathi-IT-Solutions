import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riceking/widget/staff.dart';
import 'package:riceking/widget/text.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../function/appFunction.dart';
import '../function/dataBaseFunction.dart';
import '../pages/user/ai_assist.dart';
import '../pages/user/user_notification_page.dart';
import '../pages/user/user_setting_page.dart';
import 'button.dart';
import 'inputField.dart';

class RiceKingReportPage extends StatefulWidget {
  final bool isUser;
  const RiceKingReportPage({super.key, this.isUser = true,});

  @override
  State<RiceKingReportPage> createState() => _RiceKingReportPageState();
}

class _RiceKingReportPageState extends State<RiceKingReportPage> {
  bool onLoad = false;
  TextEditingController nameController = TextEditingController(text: profile['name']);
  TextEditingController phoneController = TextEditingController(text: profile['phone_no']);
  TextEditingController subjectController = TextEditingController();
  TextEditingController reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
                alignment:Alignment(0,0.5),child: Opacity(opacity:0.2,child: Image.asset('assets/appLogo.png',width: width(context)*0.85,))),
            SizedBox(
              width: width(context),
              height: height(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height:18,
                  ),
                  RobotoText(title: 'Report', size: 22),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SizedBox(
                        width: width(context),
                        child: Column(children: [
                          TextFieldWithIcon(
                            controller: nameController,
                            hintText: 'Name',
                            icons: Icons.person,
                            keyboardType: TextInputType.text,),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldWithIcon(
                            controller: phoneController,
                            hintText: 'Phone',
                            icons: Icons.phone,
                            keyboardType: TextInputType.text,),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldWithIcon(
                            controller: subjectController,
                            hintText: 'Subject',
                            icons: Icons.info,
                            keyboardType: TextInputType.text,),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 8,top: 4),
                            width: width(context) * 0.8,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 0.75,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            child: TextField(
                              controller: reportController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              style: GoogleFonts.lato(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              cursorColor: Theme.of(context).colorScheme.tertiary,
                              decoration: InputDecoration(
                                hintText: 'Report',
                                hintStyle: GoogleFonts.openSans(
                                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                                ),
                                prefixIcon: Icon(
                                  Icons.messenger_outline,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),SizedBox(height: 12,),
                        ]),
                      ),
                    ),
                  ),
                  ButtonWithText(title: 'Submit', onPressed: () async {
                    if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty && subjectController.text.isNotEmpty && reportController.text.isNotEmpty) {
                      setState(() {
                        onLoad = true;
                      });
                      bool res = await Database().sendReport(nameController.text,phoneController.text ,subjectController.text, reportController.text);
                      Navigator.of(context).pop();
                      if(res) {
                        showToast('Report Submitted.', context);
                      } else {
                        showToast('Something wend wrong', context);
                      }
                      setState(() {
                        onLoad = false;
                      });
                    } else {
                      showToast('All fields Required!', context);
                    }
                  }, width: width(context)-48),
                  SizedBox(height: 24,)
                ],
              ),
            ),
            if(!widget.isUser)
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8),
              child: IconAsButton(icon: Icons.arrow_back_outlined, onPressed: (){
                Navigator.pop(context);
              }, size: 28),
            ),
            Visibility(visible: onLoad, child: MyLoader()),
          ],
        ),
      ),
      bottomNavigationBar: widget.isUser ? StylishBottomBar(
        option: DotBarOptions(
          dotStyle: DotStyle.tile,
          gradient: const LinearGradient(colors: [Color(0xff2E402A), Color(0xff2E402A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: RobotoText(title: 'Home', size: 14),
            backgroundColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.notifications),
            title: RobotoText(title: 'Info', size: 14),
            backgroundColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person),
            title: RobotoText(title: 'Me', size: 14),
            backgroundColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.help),
            title: RobotoText(title: 'Help', size: 14),
            backgroundColor: Colors.black,
          ),
        ],
        fabLocation: StylishBarFabLocation.end,
        hasNotch: true,
        currentIndex: 3,
        onTap: (index) {
          setState(() {
            if(index == 0) Navigator.pop(context);
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => UserNotificationPage(
                    id: FirebaseAuth.instance.currentUser?.uid ?? '',
                  ),
                ),
              );
            }
            if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserSettingPage(),
                ),
              );
            }
          });
        },
      ) : null,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AiAssist()),
          );
        },
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Image(
          image: AssetImage('assets/robotIcon.png'),
          width: 50,
          height: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
