import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/pages/message_page.dart';
import 'package:riceking/pages/vendor/edit_vendor_profile.dart';
import 'package:riceking/pages/vendor/vendor_booked.dart';
import 'package:riceking/pages/vendor/vendor_booking_request.dart';
import 'package:riceking/pages/vendor/vendor_review_page.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/button.dart';
import '../../widget/online_image.dart';
import '../../widget/report.dart';
import '../../widget/text.dart';
import '../admin/admin_home_page.dart';
import '../user/ai_assist.dart';
import '../user/user_book_vendor.dart';
import '../user/user_notification_page.dart';
import '../user/user_setting_page.dart';

class VendorHomePage extends StatefulWidget {
  final String id;
  const VendorHomePage({super.key, required this.id});

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  Map<String, dynamic> vendor = {
    'companyUrl':
        'https://www.dailypioneer.com/uploads/2024/story/images/big/transforming-lives--of-the-indian-farmers-2024-10-02.jpg',
    'companyRating': '4',
    'description':
        'If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic wor',
    'id': 1751045275703498,
    'booking': [],
    'companyServices': ['a', 'b', 'c'],
    'companyName': 'Company name',
  };

  int requestCount = 0, onGoingCount = 0, totalBookedCount = 0, cancelCount = 0,totalAmount = 0;
  bool onLoad = false, showInfo = false, showDelete = false;
  List<Map<String, dynamic>> businessDetails = [{}, {}, {}, {}, {}, {}, {}, {}];
  Map<String, dynamic> vendorService = {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      onLoad = true;
    });
    getData();
  }

  Future<void> getData() async {
    await Future.wait([
      Database().getVendorRequestCount(widget.id).then((value) {
        setState(() {
          requestCount = value;
        });
      }),
      Database().getAmountForVendor(widget.id).then((value) {
        setState(() {
          totalAmount = value;
        });
        print(value);
      }),
      Database().getVendorBookedCount(widget.id).then((value) {
        print(value);
        setState(() {
          totalBookedCount = value['total'] ?? 0;
          onGoingCount = value['pending'] ?? 0;
          cancelCount = value['cancel'] ?? 0;
        });
      }),
    ]);
    final data = await Database().getVendorData(widget.id);
    setState(() {
      vendor = data;
      List<dynamic> serviceList = data['companyServices'];
      for (var service in serviceList) {
        if (service == 'Transplanter Owner' ||
            service == 'Transplanter Operator') {
          vendorService['Transplanter Operator'] = true;
          vendorService['Transplanter Owner'] = true;
          continue;
        }
        vendorService[service] = true;
      }
      print(vendorService);
      List<dynamic> business = vendor['businessDetails'] ?? {};
      for (var i in business) {
        if (i.keys.toString() == '(transplanter)') {
          businessDetails[0] = Map<String, dynamic>.from(i)['transplanter'];
        }
        if (i.keys.toString() == '(Sand Nursery Maker)') {
          businessDetails[1] =
              Map<String, dynamic>.from(i)['Sand Nursery Maker'];
        }
        if (i.keys.toString() == '(Nursery Mat Supplier)') {
          businessDetails[2] =
              Map<String, dynamic>.from(i)['Nursery Mat Supplier'];
        }
        if (i.keys.toString() == '(Drone Services Provider)') {
          businessDetails[3] =
              Map<String, dynamic>.from(i)['Drone Services Provider'];
        }
        if (i.keys.toString() == '(Straw Baler Owner)') {
          businessDetails[4] =
              Map<String, dynamic>.from(i)['Straw Baler Owner'];
        }
        if (i.keys.toString() == '(Paddy Grain Merchant)') {
          businessDetails[5] =
              Map<String, dynamic>.from(i)['Paddy Grain Merchant'];
        }
        if (i.keys.toString() == '(Labour Provider)') {

          businessDetails[6] = Map<String, dynamic>.from(i)['Labour Provider'];
        }
        if (i.keys.toString() == '(Aana Sakthi)') {
          businessDetails[7] = Map<String, dynamic>.from(i)['Aana Sakthi'];
        }
      }
      print(businessDetails);
      print(businessDetails[6]);
      onLoad = false;
    });
  }
  int lh = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child:
            onLoad
                ? SizedBox(
                  height: height(context),
                  width: width(context),
                  child: SpinKitFadingCircle(
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 50.0,
                  ),
                )
                : Stack(
                  alignment: Alignment(0, 0),
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: RobotoText(title: appName, size: 24),
                              ),
                              Row(
                                children: [
                                  IconAsButton(
                                    icon: Icons.delete,
                                    onPressed: () {
                                      setState(() {
                                        showDelete = true;
                                      });
                                    },
                                    size: 26,
                                  ),
                                  SizedBox(width: 18),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: SizedBox(
                            width: width(context),
                            child: ListView(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 18.0,
                                        right: 18,
                                        bottom: 18,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          RobotoText(
                                            title: 'Vendor Dashboard',
                                            size: 16,
                                          ),
                                          SizedBox(height: 14),
                                          SizedBox(
                                            width: width(context),
                                            height: 150,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                Container(
                                                  width: 125,
                                                  height: 150,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                    border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withOpacity(0.5),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      LatoText(
                                                        title: '$onGoingCount',
                                                        size: 24,
                                                        lineHeight: 1,
                                                      ),
                                                      SizedBox(height: 10),
                                                      LatoText(
                                                        title: 'Pending',
                                                        size: 18,
                                                        lineHeight: 1,
                                                      ),
                                                      TextAsButton(
                                                        title: 'View',
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (
                                                                    context,
                                                                  ) => VendorBooked(
                                                                    id:
                                                                        widget
                                                                            .id,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                        color:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Container(
                                                  width: 125,
                                                  height: 150,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.15),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                    border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary
                                                          .withOpacity(0.5),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      LatoText(
                                                        title:
                                                            '$totalBookedCount',
                                                        size: 24,
                                                        lineHeight: 1,
                                                      ),
                                                      SizedBox(height: 10),
                                                      LatoText(
                                                        title: 'Total',
                                                        size: 18,
                                                        lineHeight: 1,
                                                      ),
                                                      TextAsButton(
                                                        title: 'View',
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (
                                                                    context,
                                                                  ) => VendorBooked(
                                                                    id:
                                                                        widget
                                                                            .id,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                        color:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Container(
                                                  width: 125,
                                                  height: 150,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                    border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withOpacity(0.5),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      LatoText(
                                                        title: '$cancelCount',
                                                        size: 24,
                                                        lineHeight: 1,
                                                      ),
                                                      SizedBox(height: 10),
                                                      LatoText(
                                                        title: 'Cancel',
                                                        size: 18,
                                                        lineHeight: 1,
                                                      ),
                                                      TextAsButton(
                                                        title: 'View',
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (
                                                                    context,
                                                                  ) => VendorBooked(
                                                                    id:
                                                                        widget
                                                                            .id,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                        color:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          RobotoText(
                                            title: vendor['companyName'],
                                            size: 24,
                                          ),
                                          const SizedBox(height: 12),
                                          LatoText(
                                            title: vendor['description'],
                                            size: 14,
                                            lineHeight: lh,
                                          ),
                                          Row(
                                            children: [
                                              TextAsButton(
                                                title: lh == 1 ? 'Read More' : 'Less',
                                                onPressed: () {
                                                  setState(() {
                                                    print(lh);
                                                    if(lh == 1) {
                                                      print('Press if');
                                                      setState(() {
                                                        lh = 20;
                                                      });
                                                      print(lh);
                                                    } else {
                                                      print('Press else');
                                                      setState(() {
                                                        lh = 1;
                                                      });
                                                    }
                                                  });
                                                },
                                                color: Colors.blueAccent,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextAsButton(
                                                title: 'Review',
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => VendorReviewPage(
                                                            id: vendor['id'],
                                                          ),
                                                    ),
                                                  );
                                                },
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.tertiary,
                                                size: 14,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 8.0,
                                                      ),
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 14,
                                                    color:
                                                        (int.parse(
                                                                  vendor['companyRating'] ??
                                                                      0,
                                                                ) >
                                                                index)
                                                            ? Colors.amberAccent
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .tertiary,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Row(
                                            spacing: 4,
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.tertiary,
                                                size: 18,
                                              ),
                                              LatoText(
                                                title:
                                                    vendor['ratingCount']
                                                        .toString(),
                                                size: 14,
                                                lineHeight: 1,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16,),
                                          LatoText(
                                            title:'Total Amount: ₹$totalAmount/-',
                                            size: 18,
                                            lineHeight: 1,
                                          ),

                                          SizedBox(height: 16),
                                          RobotoText(
                                            title: 'Services',
                                            size: 14,
                                          ),

                                          SizedBox(height: 10),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              spacing: 4,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (vendorService['Transplanter Operator'] ??
                                                    false)
                                                  service(
                                                    'Transplanter \nOperator', '₹' + businessDetails[0]['ratePerAcre'] + '/acre'
                                                  ),
                                                // LatoText(
                                                //   title:
                                                //   'Transplanter Operator',
                                                //   size: 14,
                                                //   lineHeight: 1,
                                                // ),
                                                if (vendorService['Transplanter Owner'] ??
                                                    false)
                                                  service(
                                                    'Transplanter \nOwner', '₹' + businessDetails[0]['ratePerAcre'] + '/acre'
                                                  ),
                                                // LatoText(
                                                //   title: 'Transplanter Owner',
                                                //   size: 14,
                                                //   lineHeight: 1,
                                                // ),
                                                if (vendorService['Nursery Mat Supplier'] ??
                                                    false)
                                                  service(
                                                    'Nursery Mat \nSupplier', '₹' + businessDetails[2]['ratePerMat'] + '/nursery mat'
                                                  ),
                                                // LatoText(
                                                //   title:
                                                //   'Nursery Mat Supplier',
                                                //   size: 14,
                                                //   lineHeight: 1,
                                                // ),
                                                if (vendorService['Sand Nursery Maker'] ??
                                                    false)
                                                  service(
                                                    'Sand Nursery \nMaker','₹' + businessDetails[1]['setUpCost'] + '/bag of seeds'
                                                  ),
                                                // LatoText(
                                                //   title: 'Sand Nursery Maker',
                                                //   size: 14,
                                                //   lineHeight: 1,
                                                // ),
                                                if (vendorService['Drone Services Provider'] ??
                                                    false)
                                                  service(
                                                    'Drone Services \nProvider','₹' + businessDetails[3]['rateAcre'] + '/acre'
                                                  ),
                                                // LatoText(
                                                //   title:
                                                //   'Drone Services Provider',
                                                //   size: 14,
                                                //   lineHeight: 1,
                                                // ),
                                                if (vendorService['Straw Baler Owner'] ??
                                                    false)
                                                  service(
                                                    'Straw Baler \nOwner', '₹' + businessDetails[4]['ratePerBale'] + '/bale'
                                                  ),
                                                // LatoText(
                                                //   title: 'Straw Baler Owner',
                                                //   size: 14,
                                                //   lineHeight: 1,
                                                // ),
                                                if (vendorService['Paddy Grain Merchant'] ??
                                                    false)
                                                  service(
                                                    'Paddy Grain \nMerchant','₹' + businessDetails[5]['priceRange'] + '/acre'
                                                  ),
                                                // LatoText(
                                                //   title:
                                                //   'Paddy Grain Merchant',
                                                //   size: 14,
                                                //   lineHeight: 1,
                                                // ),
                                                if (vendorService['Labour Provider'] ??
                                                    false)
                                                  service('Labour \nProvider','₹' + businessDetails[6]['lpFemaleFare'] + 'or' + businessDetails[6]['lpMenFare']),
                                                // LatoText(
                                                //   title:
                                                //   'Paddy Grain Merchant',
                                                //   size: 14,
                                                //   lineHeight: 1,
                                                // ),
                                                if (vendorService['Aana Sakthi'] ??
                                                    false)
                                                  service('Aana Sakthi', ''),
                                                // LatoText(
                                                //   title: 'Aana Sakthi',
                                                //   size: 14,
                                                //   lineHeight: 1,
                                                // ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 14),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RobotoText(
                                                title: 'Service Info',
                                                size: 16,
                                              ),
                                              TextAsButton(
                                                title: 'Show',
                                                onPressed: () {
                                                  setState(() {
                                                    showInfo = true;
                                                  });
                                                },
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          LatoText(
                                            title: 'Banner Image',
                                            size: 12,
                                            lineHeight: 1,
                                          ),
                                          SizedBox(height: 8),
                                          SizedBox(
                                            height: 200,
                                            width: width(context),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                              child: OnlineImage(
                                                url: vendor['companyUrl'],
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 24),
                                          if(adminId != FirebaseAuth.instance.currentUser!.uid)
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: TextAsButton(
                                              title: 'Change Banner',
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            EditVendorProfile(
                                                              data: vendor,
                                                            ),
                                                  ),
                                                );
                                              },
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                              size: 12,
                                            ),
                                          ),
                                          SizedBox(height: 24),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: showInfo || showDelete,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showInfo = showDelete = false;
                          });
                        },
                        child: Container(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.2),
                          height: height(context),
                          width: width(context),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0),
                      child: Visibility(
                        visible: showDelete,
                        child: Container(
                          height: 150,
                          width: width(context) - 48,
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Column(
                            spacing: 14,
                            children: [
                              LatoText(
                                title: 'Are you want to Delete this Profile!',
                                size: 16,
                                lineHeight: 2,
                              ),
                              ButtonWithText(
                                title: 'Delete',
                                onPressed: () async {
                                  setState(() {
                                    onLoad = true;
                                  });
                                  bool delete = await Database().deleteVendor(
                                    vendor['userId'],
                                    vendor['id'],
                                  );
                                  if (delete) {
                                    setState(() {
                                      onLoad = false;
                                      showDelete = false;
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    showToast('Unable to Delete!', context);
                                  }
                                },
                                width: width(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0),
                      child: Visibility(
                        visible: showInfo,
                        child: Container(
                          height: height(context) * 0.6,
                          width: width(context) - 24,
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RobotoText(title: 'Service Info', size: 20),
                                  IconAsButton(
                                    icon: Icons.close,
                                    onPressed: () {
                                      setState(() {
                                        showInfo = false;
                                      });
                                    },
                                    size: 20,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              if (vendorService['Transplanter Operator'] ??
                                  false ||
                                      vendorService['Transplanter Owner'] ??
                                  false)
                                Column(
                                  children: [
                                    RobotoText(title: 'Transplant', size: 14),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title: 'TransPlanter Ownership',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Provide Tractor',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Model',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Year of Purchase',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Area/Day',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Rate/Acre',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[0]['transPlanterOwnership']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[0]['provideTractor']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[0]['model']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[0]['yearOfP']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[0]['perDayArea']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[0]['ratePerAcre']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (vendorService['Sand Nursery Maker'] ?? false)
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    RobotoText(
                                      title: 'Sand Nursery Maker',
                                      size: 14,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title: 'Area Of Operation',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Team Size',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Soil/Sand',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'SetUp Cost/Acre',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Capacity',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[1]['areaOfOperation']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[1]['teamSize']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[1]['sourceOfSoil']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[1]['setUpCost']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[1]['capacity']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (vendorService['Nursery Mat Supplier'] ??
                                  false)
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    RobotoText(
                                      title: 'Nursery Mat Supplier',
                                      size: 14,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title: 'Quantity Day',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Nursery Location',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Lead Time',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Rate/Mat',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[2]['quantityDay']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[2]['nurseryLocation']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[2]['leadTime']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[2]['ratePerMat']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (vendorService['Drone Services Provider'] ??
                                  false)
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    RobotoText(
                                      title: 'Drone Services Provider',
                                      size: 14,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title: 'Services Offered',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Drone Make&Model',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Area/Day',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Rate/Acre',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Permission/License',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title:
                                                  ' : ${(businessDetails[3]['servicesOffered']['Spraying']) ? 'Spraying' : ''}${(businessDetails[3]['servicesOffered']['Mapping']) ? 'Mapping' : ''}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[3]['droneMakeModel']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[3]['areaCovered']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[3]['rateAcre']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[3]['permissionLicense']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (vendorService['Straw Baler Owner'] ?? false)
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    RobotoText(
                                      title: 'Straw Baler Owner',
                                      size: 14,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title: 'Bale Type',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Bale Size&Weight',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Rate/Bale',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Transport Available',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[4]['baleType']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[4]['baleSizeAndWeight']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[4]['ratePerBale']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[4]['transportAvailable']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (vendorService['Paddy Grain Merchant'] ??
                                  false)
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    RobotoText(
                                      title: 'Paddy Grain Merchant',
                                      size: 14,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title: 'Location',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Quality Accepts',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Paddy Varieties',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Price Range',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Payment Timeline',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[5]['purchaseCenterLocation']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[5]['qualityAccepts']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[5]['paddyVarieties']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[5]['priceRange']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[5]['paymentTimeline']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (vendorService['Labour Provider'] ?? false)
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    RobotoText(
                                      title: 'Labor Provider',
                                      size: 14,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title: 'Name',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Father Name',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Number',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Works ',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Village',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Taluk',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'District',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Men Fare',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Femake Fare',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Other',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[6]['lpName']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[6]['lpFatherName']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[6]['lpContactNumber']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${(businessDetails[6]['workOffered']['Sowing']) ? 'Sowing' : ''} :${(businessDetails[6]['workOffered']['Weeding']) ? 'Weeding' : ''} :${(businessDetails[6]['workOffered']['Transplanting']) ? 'Transplanting' : ''} :${(businessDetails[6]['workOffered']['Spraying']) ? 'Spraying' : ''} :${(businessDetails[6]['workOffered']['Field labor']) ? 'Field labor' : ''} :${(businessDetails[6]['workOffered']['Harvesting']) ? 'Harvesting' : ''} :${(businessDetails[6]['workOffered']['Agri processing']) ? 'Agri processing' : ''} ',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[6]['lpVillage']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[6]['lpTaluk']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[6]['lpDistrict']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[6]['lpMenFare']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[6]['lpFemaleFare']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[6]['lpOther']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (vendorService['Aana Sakthi'] ?? false)
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    RobotoText(title: 'Aana Sakthi', size: 14),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title: 'Aana Type',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Product Sell',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Monthly Volume',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Village Cover',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title: 'Stock Aana',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[7]['typeAana']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[7]['productYouCanSell']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[7]['monthlyVolume']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[7]['villageCover']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                            LatoText(
                                              title:
                                                  ' : ${businessDetails[7]['stockAana']}',
                                              size: 14,
                                              lineHeight: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: FirebaseAuth.instance.currentUser?.uid == adminId,
                      child: Align(
                        alignment: Alignment(0.9, 0.85),
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(
                                  color:Colors.black12,
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: Offset(1, 1)
                              )]
                          ),
                          child: IconAsButton(icon: Icons.phone_in_talk_sharp, onPressed: (){
                            makePhoneCall(vendor['userDetails']['contactNumber'],context);
                          }, size: 24),
                        ),
                      ),
                    ),
                  ],
                ),
      ),

      bottomNavigationBar: StylishBottomBar(
        option: DotBarOptions(
          dotStyle: DotStyle.tile,
          gradient: const LinearGradient(
            colors: [Color(0xff2E402A), Color(0xff2E402A)],
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
            icon: Badge(
              isLabelVisible: (requestCount > 0) ? true : false,
              child: Icon(Icons.notifications),
            ),
            title: RobotoText(title: 'Info', size: 14),
            backgroundColor: Colors.black,
          ),
          BottomBarItem(
            icon:  Icon(adminId == FirebaseAuth.instance.currentUser!.uid ? Icons.chat : Icons.edit),
            title: RobotoText(title: 'Edit', size: 14),
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
        currentIndex: 0,
        onTap: (index) async {
          if (index == 1) {
            if (!onLoad) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VendorBookingRequest(id: widget.id),
                ),
              );
            } else {
              showToast('Loading...', context);
            }
            setState(() {
              requestCount = 0;
            });
          }
          if (index == 2) {
            if (adminId == FirebaseAuth.instance.currentUser!.uid) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessagePage(vendorId: widget.id, userId: FirebaseAuth.instance.currentUser!.uid, isUser: true,phone: vendor['userDetails']['contactNumber'],)),
              );
            } else {
              bool isEdit = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditVendorProfile(data: vendor),
                ),
              );
              if (isEdit) {
                print('vendor.......');
                setState(() {
                  onLoad = true;
                });
                await getData();
                setState(() {
                  onLoad = false;
                });
              }
            }
          }
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RiceKingReportPage(isUser: false),
              ),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
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

  Widget service(String key,String price) {
    String word = key;
    key = key.replaceAll('\n', '');
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/services/$key.png',
              width: 75, // 75
              height: 75,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 4),
          LatoText(title: word, size: 8, lineHeight: 2),
          SizedBox(height: 8,),
          LatoText(title: price, size: 12, lineHeight: 1),
        ],
      ),
    );
  }
}
