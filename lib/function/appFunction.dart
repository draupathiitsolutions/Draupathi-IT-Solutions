import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/widget/text.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

String appName = 'Rice King';
String inputOtp = '';
String imgNotFound = 'https://firebasestorage.googleapis.com/v0/b/aanacrops-riceking.firebasestorage.app/o/app_reference%2Fimage_not_founded.jpg?alt=media&token=b4d2d459-a7b8-4f1a-8493-2adf989c02f9';
String companyUrl = 'https://firebasestorage.googleapis.com/v0/b/aanacrops-riceking.firebasestorage.app/o/app_reference%2Fbanner.png?alt=media&token=9132c88e-dae4-4fd5-a26a-0a3d040413ab';
String userId = FirebaseAuth.instance.currentUser!.uid;
String adminId =  '1XbhNVPKrORMCgNY68bjj7NR2yd2'; //"sIYIttRORoaTddKZFDYFBdMJcR72";
Map<String, dynamic> profile = {};
List<String> languages = ['English','தமிழ்','తెలుగు'];


String location = '';
final String yourGPayUpiId = '';
final String yourPhonePeUpiId = '';
final String yourName = profile['name'];
String language = 'English';
final double amount = 100.00;
final String currency = 'INR';
final String note = 'Payment from ${profile['name']} for services';
// Generate a unique transaction ID for each payment
String getUniqueTransactionId() {
  return 'TRX${DateTime.now().millisecondsSinceEpoch}';
}
// --------------------------------------------------------

Future<void> payNow(Uri url,BuildContext context) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    showToast('Could not launch ${url.scheme} payment app. Please ensure it is installed.',context);
  }
}

// reg 1
TextEditingController businessNameController =
    TextEditingController();
TextEditingController contactNameController =
    TextEditingController();
TextEditingController contactNumberController =
    TextEditingController();
TextEditingController emailController =
    TextEditingController();
TextEditingController optionalContactNumberController =
    TextEditingController();
TextEditingController addressController =
    TextEditingController();
TextEditingController districtController =
    TextEditingController();
TextEditingController townController =
    TextEditingController();
TextEditingController languageController =
    TextEditingController();
TextEditingController aAndGstController =
    TextEditingController();
TextEditingController holderNameController =
    TextEditingController();
TextEditingController holderNumberController =
    TextEditingController();
TextEditingController ifscController =
    TextEditingController();
TextEditingController bankNameController =
    TextEditingController();

// reg 2
final Map<String, bool> serviceValues = {
    'Transplanter Operator': false,
  'Transplanter Owner': false,
  'Nursery Mat Supplier': false,
  'Sand Nursery Maker': false,
  'Drone Services Provider': false,
  'Straw Baler Owner': false,
  'Paddy Grain Merchant': false,
  'Labour Provider': false,
  'Aana Sakthi': false,
};

// reg 3
String? transPlanterOwnership;
String? provideTractor;
TextEditingController modelController =
    TextEditingController();
TextEditingController yearOfPController =
    TextEditingController();
TextEditingController perDayAreaController =
    TextEditingController();
TextEditingController ratePerAcreController =
    TextEditingController();
TextEditingController areaOfOperationController =
    TextEditingController();
TextEditingController teamSizeController =
    TextEditingController();
TextEditingController sourceOfSoilController =
    TextEditingController();
TextEditingController setUpCostController =
    TextEditingController();
TextEditingController capacityController =
    TextEditingController();
TextEditingController quantityDayController =
    TextEditingController();
TextEditingController nurseryLocationController =
    TextEditingController();
TextEditingController leadTimeController =
    TextEditingController();
TextEditingController ratePerMatController =
    TextEditingController();
final Map<String, bool> servicesOffered = {
  'Spraying': false,
  'Mapping': false,
};
TextEditingController droneMakeModelController =
    TextEditingController();
TextEditingController areaCoveredController =
    TextEditingController();
TextEditingController rateAcreController =
    TextEditingController();
String? permissionLicense;
String? baleType;
TextEditingController baleSizeAndWeightController =
    TextEditingController();
TextEditingController ratePerBaleController =
    TextEditingController();
String? transportAvailable;
TextEditingController purchaseCenterLocationController =
    TextEditingController();
TextEditingController qualityAcceptsController =
    TextEditingController();
TextEditingController paddyVarietiesController =
    TextEditingController();
TextEditingController priceRangeController =
    TextEditingController();
TextEditingController paymentTimelineController =
    TextEditingController();
TextEditingController lpNameController =
    TextEditingController();
TextEditingController lpFatherNameController =
    TextEditingController();
TextEditingController lpContactNumberController =
    TextEditingController();
final Map<String, bool> workOffered = {
  'Sowing': false,
  'Weeding': false,
  'Transplanting': false,
  'Spraying': false,
  'Field labor': false,
  'Harvesting': false,
  'Agri processing': false,
};
TextEditingController lpVillageController =
    TextEditingController();
TextEditingController lpTalukController =
    TextEditingController();
TextEditingController lpDistrictController =
    TextEditingController();
TextEditingController lpMenFareController =
    TextEditingController();
TextEditingController lpFemaleFareController =
    TextEditingController();
TextEditingController lpOtherController =
    TextEditingController();
String? typeAana;
TextEditingController productYouCanSellController =
TextEditingController();
TextEditingController monthlyVolumeController =
TextEditingController();
TextEditingController villageCoverController =
TextEditingController();
String? stockAana;

// reg 4
final Map<String, XFile?> selectedImageFiles = {

};

// reg 5
bool isChecked = false;

// filter variable
final Map<String, bool> filterUser = {
  'Transplanter Operator': false,
  'Transplanter Owner': false,
  'Nursery Mat Supplier': false,
  'Sand Nursery Maker': false,
  'Drone Services Provider': false,
  'Straw Baler Owner': false,
  'Paddy Grain Merchant': false,
  'Labour Provider': false,
  'Aana Sakthi': false,
  'below 1k': false,
    '1k-2k': false,
    '2k-3k': false,
    '3k-4k': false,
    '4k-5k': false,
    'above 5k': false,
};
TextEditingController filterLocationController =
    TextEditingController();

void customStatusBar(
  var statusBarColor,
  systemNavigationBarColor,
  statusBarIconBrightness,
  systemNavigationBarIconBrightness,
) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarColor: systemNavigationBarColor,
      systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
    ),
  );
}

void showToast(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .primary,
      content: LatoText(title: msg, size: 14, lineHeight: 1, showLine: true,color: Colors.white,),
    ),
  );
}

Future<Map<String,dynamic>> makeRegData(BuildContext context) async{
  Map<String,dynamic> data = {};
  String id = '${DateTime.now().microsecondsSinceEpoch}';
  data['id'] = id;
  data['userId'] = userId;
  data['userDetails'] = {
    'businessName' : businessNameController.text,
    'contactName' :contactNameController.text,
    'contactNumber' : contactNumberController.text,
    'email' : emailController.text,
    'optionalContactNumber' : optionalContactNumberController.text,
    'address' : addressController.text,
    'district' : districtController.text,
    'town' : townController.text,
    'language' : languageController.text,
    'aAndGst' : aAndGstController.text,
    'holderName' : holderNameController.text,
    'holderNumberController' : holderNumberController.text,
    'ifsc' : ifscController.text,
    'bankNameController': bankNameController.text,
  };

  data['service'] = serviceValues;

  data['businessDetails'] = {
    if(serviceValues['Transplanter Operator']! || serviceValues['Transplanter Owner']!){
      'transplanter': {
        'transPlanterOwnership' : transPlanterOwnership,
        'provideTractor': provideTractor,
        'model' : modelController.text,
        'yearOfP' : yearOfPController.text,
        'perDayArea' : perDayAreaController.text,
        'ratePerAcre' : ratePerAcreController.text,
      },},
    if(serviceValues['Sand Nursery Maker']!) {
      'Sand Nursery Maker': {
        'areaOfOperation' : areaOfOperationController.text,
        'teamSize' : teamSizeController.text,
        'sourceOfSoil' : sourceOfSoilController.text,
        'setUpCost' : setUpCostController.text,
        'capacity' : capacityController.text,
      },},
    if(serviceValues['Nursery Mat Supplier']!) {
      'Nursery Mat Supplier':{
        'quantityDay': quantityDayController.text,
        'nurseryLocation': nurseryLocationController.text,
        'leadTime': leadTimeController.text,
        'ratePerMat': ratePerMatController.text,
      },
    },
    if(serviceValues['Drone Services Provider']!) {
      'Drone Services Provider': {
        'servicesOffered': servicesOffered,
        'droneMakeModel': droneMakeModelController.text,
        'areaCovered': areaCoveredController.text,
        'rateAcre': rateAcreController.text,
        'permissionLicense': permissionLicense,
      },},
    if(serviceValues['Straw Baler Owner']!) {
      'Straw Baler Owner' : {
        'baleType' : baleType,
        'baleSizeAndWeight' : baleSizeAndWeightController.text,
        'ratePerBale' : ratePerBaleController.text,
        'transportAvailable' : transportAvailable,
      },
    },
    if(serviceValues['Paddy Grain Merchant']!) {
      'Paddy Grain Merchant': {
        'purchaseCenterLocation' : purchaseCenterLocationController.text,
        'qualityAccepts' : qualityAcceptsController.text,
        'paddyVarieties' : paddyVarietiesController.text,
        'priceRange' : priceRangeController.text,
        'paymentTimeline' : paymentTimelineController.text,
      },
    },
    if(serviceValues['Labour Provider']!) {
      'Labour Provider': {
        'lpName' : lpNameController.text,
        'lpFatherName' : lpFatherNameController.text,
        'lpContactNumber' : lpContactNumberController.text,
        'workOffered' : workOffered,
        'lpVillage' : lpVillageController.text,
        'lpTaluk' : lpTalukController.text,
        'lpDistrict' : lpDistrictController.text,
        'lpMenFare' : lpMenFareController.text,
        'lpFemaleFare' : lpFemaleFareController.text,
        'lpOther' : lpOtherController.text,
      },
    },
    if(serviceValues['Aana Sakthi']!) {
      'Aana Sakthi': {
        'typeAana' : typeAana,
        'productYouCanSell' : productYouCanSellController.text,
        'monthlyVolume' : monthlyVolumeController.text,
        'villageCover' : villageCoverController.text,
        'stockAana' : stockAana,
      },
    },

  };

  print( data['businessDetails']);

  data['document'] = await Database().uploadDocument(selectedImageFiles,id,context);

  return data;
}

void selectPage(RemoteMessage message) {

  if(message.data.isEmpty) {
    navigatorKey.currentState?.pushNamed('/mainPage');
    return;
  }
  final data = message.data;
  final screen = data['screen'];

  if (screen == 'vendorHomePage'){ print('vendorHomePge');
    navigatorKey.currentState?.pushNamed('/vendorHomePge');
  } else if (screen == 'userHomePage') {
    navigatorKey.currentState?.pushNamed('/userHomePage');
  } else if (screen == 'vendorRequest') {
    navigatorKey.currentState?.pushNamed('/vendorRequest');
  } else if(screen == 'userRequest') {
    navigatorKey.currentState?.pushNamed('/userRequest');
  } else if(screen == 'UserNotificationPage') {
    navigatorKey.currentState?.pushNamed('/UserNotificationPage');
  } else if(screen == 'adminPage') {
    navigatorKey.currentState?.pushNamed('/adminPage');
  }
}

void makePhoneCall(String phoneNumber,BuildContext context) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  try {
    if (await launchUrl(launchUri)) {
    } else {
      // show error
      showToast("Could not call $phoneNumber", context);
    }
  } catch (e) {
    showToast("Error occurred: $e", context);
  }
}

Future<String> translateString(String content) async {
  String inputText = content;
  if(language != 'English' && content == 'Book Now') {
    inputText = 'Booking';
  }

  if(language == 'தமிழ்') {
    content = content.replaceAll('\n', '');
    if(content == 'Transplanter Operator') {
      return 'நெல் நடவு இயந்திர இயக்குனர்';
    } else if(content == 'Transplanter Owner') {
      return 'நெல் நடவு இயந்திர உரிமையாளர்';
    } else if(content == 'Nursery Mat Supplier') {
      return 'நர்சரி மேட் வழங்குநர்';
    } else if(content == 'Sand Nursery Maker') {
      return 'மணல் நர்சரி தயாரிப்பாளர்';
    } else if(content == 'Drone Services Provider') {
      return 'ட்ரோன் சேவைகள் வழங்குநர்';
    } else if(content == 'Straw Baler Owner') {
      return 'புல் பேலர் உரிமையாளர்';
    } else if(content == 'Paddy Grain Merchant') {
      return 'நெல் தானிய வணிகர்';
    } else if(content == 'Labour Provider') {
      return 'தொழிலாளர் வழங்குநர்';
    } else if(content == 'Aana Sakthi') {
      return 'ஆணா சக்தி';
    }
  } else if(language == 'తెలుగు') {
    if(content == 'Transplanter Operator') {
      return 'ట్రాన్స్‌ప్లాంటర్ ఆపరేటర్';
    } else if(content == 'Transplanter Owner') {
      return 'ట్రాన్స్‌ప్లాంటర్ యజమాని';
    } else if(content == 'Nursery Mat Supplier') {
      return 'నర్సరీ మ్యాట్ సరఫరాదారు';
    } else if(content == 'Sand Nursery Maker') {
      return 'సాండ్ నర్సరీ మేకర్';
    } else if(content == 'Drone Services Provider') {
      return 'డ్రోన్ సేవల ప్రొవైడర్';
    } else if(content == 'Straw Baler Owner') {
      return 'స్ట్రా బేలర్ యజమాని';
    } else if(content == 'Paddy Grain Merchant') {
      return 'బియ్యం దానియ వ్యాపారి';
    } else if(content == 'Labour Provider') {
      return 'శ్రమికులు ప్రొవైడర్';
    } else if(content == 'Aana Sakthi') {
      return 'ఆనా శక్తి';
    }
  }

  if (inputText.isEmpty) {
    return '';
  }

  try {
    final translate = GoogleTranslator();
    final translatedText = (language == 'தமிழ்') ? await translate.translate( //
      inputText,
      from: 'en',
      to: 'ta',
    ):(language == 'తెలుగు')?await translate.translate(
      inputText,
      from: 'en',
      to: 'te',
    ): inputText;

      return translatedText.toString();

  } catch (error) {
    print('Translation error: $error');
    return inputText;
  }
}

Future<String> getCurrentLocation(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;
  // Get the current position.
  try {
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return "Location services are disabled.";
    }

    // Check location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return 'access :(';
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    // Get the first placemark from the list.
    Placemark place = placeMarks[0];

    return '${place.street}, ${place.locality}' ?? 'India';

  } catch (e) {
    // showToast('$e', context);
    return 'India';
  }
}
//
// bool allow() {
//   final now = DateTime.now();
//   final upTo = DateTime(2025, 11, 01);
//
//   final today = DateTime(now.year, now.month, now.day);
//
//   return !(today.isAfter(upTo) || today.isAtSameMomentAs(upTo));
// }