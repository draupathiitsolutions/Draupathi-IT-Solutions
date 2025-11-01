import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../function/appFunction.dart';
import '../../widget/button.dart';
import '../../widget/online_image.dart';
import '../../widget/text.dart';
import '../user/user_book_vendor.dart';
import '../user/user_view_vendor.dart';
import '../vendor/vendor_home_page.dart';

class AdminVendorView extends StatefulWidget {
  final data;
  const AdminVendorView({super.key, this.data});

  @override
  State<AdminVendorView> createState() => _AdminVendorViewState();
}

class _AdminVendorViewState extends State<AdminVendorView> {
  @override
  Widget build(BuildContext context) {

    final vendorData = widget.data;
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
              //
              //   child: Image.asset(
              //     'assets/banner.png',
              //     fit: BoxFit.fitWidth,
              //   ),
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
                  LatoText(title: 'Vendors', size: 16, lineHeight: 1),
                  SizedBox(
                    width: 24,
                  )
                ],
              ),
              SizedBox(height: 12,),
              Expanded(
                child: SizedBox(
                  width: width(context),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 12),
                    itemCount: vendorData.length,
                    itemBuilder: (context, index) {
                      final vendor = vendorData[index];
                      return VendorData(data: vendor.data());
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


class VendorData extends StatefulWidget {
  final Map<String, dynamic> data;
  const VendorData({super.key, required this.data});

  @override
  State<VendorData> createState() => _VendorDataState();
}

class _VendorDataState extends State<VendorData> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> vendor = widget.data;

    List<dynamic> serviceList = vendor['companyServices'];
    return Container(
      height: 165,
      width: width(context),
      margin: EdgeInsets.only(bottom: 18, left: 16, right: 16),
      padding: const EdgeInsets.only(top: 18, bottom: 8, left: 8),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(shape: BoxShape.circle),
                margin: EdgeInsets.only(right: 8),
                child: OnlineImage(
                  url: vendor['companyUrl'],
                  border: 100,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: TextAsButton(
                  title: 'View',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => VendorHomePage(id: vendor['id'],),
                      ),
                    );
                  },
                  color: Theme.of(context).colorScheme.primary,
                  size: 12,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              height: 165,
              child: Column(
                spacing: 6,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RobotoText(
                    title: vendor['companyName'] ?? 'Company Name',
                    size: 20,
                  ),
                  SizedBox(
                    height: 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Icon(
                            (int.parse(vendor['companyRating'] ?? 0) >
                                index)
                                ? Icons.star : Icons.star_border,
                            size: 16,
                            color:
                            (int.parse(vendor['companyRating'] ?? 0) >
                                index)
                                ? Colors.amberAccent
                                : Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: LatoText(
                      title: serviceList.join(', '),
                      size: 10,
                      lineHeight: 2,
                    ),
                  ),
                  SizedBox(height: 0.1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonWithText(title: 'View', onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => VendorHomePage(id: vendor['id'],),
                          ),
                        );
                      }, width: 125,height: 30,),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}

