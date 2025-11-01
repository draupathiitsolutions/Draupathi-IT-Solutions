import 'package:another_telephony/telephony.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:riceking/widget/staff.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/button.dart';
import '../../widget/inputField.dart';
import '../../widget/text.dart';
import 'my_info_page.dart';

class MyAuthPage extends StatefulWidget {
  const MyAuthPage({super.key});

  @override
  State<MyAuthPage> createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool displayOTP = false;
  String? _verificationId;
  String? _errorMessage;
  bool onLoad = false;
  final Telephony telephony = Telephony.instance;

  void startListening() {
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          if('${message.body}'.contains('aanacrops-riceking.firebaseapp.com')) {
            print('in');
            String otp = message.body!.substring(0,6);
            setState(() {
              otpController = TextEditingController(text: otp);
              inputOtp = otp;
              print(otp);
            });
          }
        },
        listenInBackground: false
    );
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   startListening();
  // }

  String buttonName = 'Get OTP';

  // void onSmsReceived(String? message) {
  //   print('message -> $message');
  //   if (message!.contains('aanacrops-riceking')) {
  //     String otp = message.substring(0, 6);
  //     setState(() {
  //       otpController = TextEditingController(text: otp);
  //       inputOtp = otp;
  //     });
  //   }
  // }
  //
  // void onTimeout() {
  //   setState(() {
  //     'Timeout!!!';
  //   });
  // }
  //
  // void _startListening() async {
  //   await _smsReceiver.startListening();
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _requestSmsPermission();
  // }

  // Future<void> _requestSmsPermission() async {
  //   final status = await Permission.sms.request();
  //   if (status.isGranted) {
  //     _smsReceiver = SmsReceiver(onSmsReceived, onTimeout: onTimeout);
  //     _startListening();
  //   } else {
  //     // Handle the case where the user denies permission
  //     print('SMS permission denied.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: height(context),
              width: width(context),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: height(context) - kToolbarHeight,
                  width: width(context),
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: width(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 40,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.asset(
                                  'assets/appLogo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              RobotoText(title: 'RiceKing', size: 34),
                              LatoText(
                                title: 'Made in India, Made by Indian',
                                size: 16,
                                lineHeight: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.42,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 8),
                            LatoText(
                              title: 'Welcome Back!',
                              size: 28,
                              lineHeight: 1,
                            ),
                            LatoText(
                              title: 'Enter your details to get started',
                              size: 12,
                              lineHeight: 1,
                            ),
                            Spacer(),
                            SizedBox(height: 18),
                            displayOTP
                                ? Column(
                                    spacing: 14,
                                    children: [
                                      OTPField(controller: otpController),
                                      GestureDetector(
                                        onTap: () async {
                                          if (otpController.text.isNotEmpty) {
                                            if (displayOTP) {
                                              setState(() {
                                                onLoad = true;
                                              });
                                              await _verifyOTP();
                                            }
                                          } else {
                                            showToast(
                                              'Enter your OTP',
                                              context,
                                            );
                                          }
                                        },
                                        child: Container(
                                          width: width(context),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.primary,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(child: Text(
                                            'Verify OTP',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).colorScheme.surface,
                                            ),
                                          )),
                                        ),
                                      ),
                                      // ButtonWithText(
                                      //   title: 'Enter',
                                      //   width: width(context) * 0.8,
                                      //   onPressed: () async {
                                      //     if (otpController.text.isNotEmpty) {
                                      //       if (displayOTP) {
                                      //         setState(() {
                                      //           onLoad = true;
                                      //         });
                                      //         await _verifyOTP();
                                      //       }
                                      //     } else {
                                      //       showToast(
                                      //         'Enter your OTP',
                                      //         context,
                                      //       );
                                      //     }
                                      //   },
                                      // ),
                                    ],
                                  )
                                : Column(
                                    spacing: 14,
                                    children: [
                                      TextFieldWithIcon(
                                        controller: phoneController,
                                        hintText: 'Mobile number',
                                        icons: Icons.phone,
                                        keyboardType: TextInputType.phone,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (phoneController.text.isNotEmpty) {
                                            if (phoneController.text.length >
                                                9) {
                                              setState(() {
                                                onLoad = true;
                                              });
                                              //
                                              // FocusScope.of(context).unfocus();
                                              // bool status  = await Auth().anonymousUser();
                                              // if(status) {
                                              //   Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(builder: (context) =>  MyInfoPage(phone: phoneController.text)),
                                              //   );
                                              // }
                                              // setState(() {
                                              //   onLoad = false;
                                              // });
                                              await _sendOTP();
                                              // setState(() {
                                              //   displayOTP = true;
                                              // });
                                            } else {
                                              showToast(
                                                'Please enter valid number',
                                                context,
                                              );
                                            }
                                          } else {
                                            setState(() {
                                              displayOTP = true;
                                            });
                                            showToast(
                                              'Enter your Number',
                                              context,
                                            );
                                          }
                                        },
                                        child: Container(
                                          width: width(context),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.primary,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(child: Text(
                                            'Get OTP',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).colorScheme.surface,
                                            ),
                                          )),
                                        ),
                                      ),
                                      // ButtonWithText(
                                      //   title: 'Enter',
                                      //   width: width(context) * 0.8,
                                      //   onPressed: () async {
                                      //     if (phoneController.text.isNotEmpty) {
                                      //       if (phoneController.text.length >
                                      //           9) {
                                      //         setState(() {
                                      //           onLoad = true;
                                      //         });
                                      //         //
                                      //         // FocusScope.of(context).unfocus();
                                      //         // bool status  = await Auth().anonymousUser();
                                      //         // if(status) {
                                      //         //   Navigator.pushReplacement(
                                      //         //     context,
                                      //         //     MaterialPageRoute(builder: (context) =>  MyInfoPage(phone: phoneController.text)),
                                      //         //   );
                                      //         // }
                                      //         // setState(() {
                                      //         //   onLoad = false;
                                      //         // });
                                      //         await _sendOTP();
                                      //         // setState(() {
                                      //         //   displayOTP = true;
                                      //         // });
                                      //       } else {
                                      //         showToast(
                                      //           'Please enter valid number',
                                      //           context,
                                      //         );
                                      //       }
                                      //     } else {
                                      //       setState(() {
                                      //         displayOTP = true;
                                      //       });
                                      //       showToast(
                                      //         'Enter your Number',
                                      //         context,
                                      //       );
                                      //     }
                                      //   },
                                      // ),
                                    ],
                                  ),
                            SizedBox(height: 18),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                                children: [
                                  TextSpan(
                                    text: "By continuing, you agree to our ",
                                  ),
                                  TextSpan(
                                    text: "Terms and Conditions",
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle click action here
                                        print('Terms and Conditions clicked');
                                      },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/services/flag.webp',
                                  height: 10,
                                ),
                                LatoText(title: ' | ', size: 12, lineHeight: 1),
                                LatoText(
                                  title: 'Version : 1.0.0',
                                  size: 10,
                                  lineHeight: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(visible: onLoad, child: MyLoader()),
          ],
        ),
      ),
    );
  }

  Future<void> _sendOTP() async {
    setState(() {
      _errorMessage = null;
    });
    try {
      String mobileNumber = phoneController.text.trim().replaceAll('+91', '');
      FocusScope.of(context).unfocus();

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$mobileNumber',
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyInfoPage(phone: phoneController.text),
              ),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          showToast('Failed to send OTP', context);
          setState(() {
            onLoad = false;
          });
          print('Firebase Auth Exception: ${e.code} - ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          setState(() {
            _verificationId = verificationId;
            displayOTP = true;
            buttonName = 'Verify OTP';
            startListening();
            onLoad = false;
          });
          showToast('OTP sent to your phone number.', context);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
          showToast(
            'OTP auto retrieval timed out. Please enter it manually.',
            context,
          );
        },
      );
    } catch (e) {
      showToast('An error occurred', context);
      print('Error sending OTP: $e');
    }
  }

  Future<void> _verifyOTP() async {
    setState(() {
      _errorMessage = null;
    });
    if (_verificationId == null || otpController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter the OTP.';
      });
      return;
    }
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: inputOtp,
      );
      print('Credential: $credential');
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (mounted) {
        setState(() {
          onLoad = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyInfoPage(phone: phoneController.text),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      showToast('Invalid OTP. Please try again.', context);
      print(
        'Firebase Auth Exception (OTP Verification): ${e.code} - ${e.message}',
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred during OTP verification: $e';
      });
      print('Error verifying OTP: $e');
    }
  }
}
