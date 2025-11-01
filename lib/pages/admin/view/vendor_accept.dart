import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/function/appFunction.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/widget/button.dart';

import '../../../widget/online_image.dart';
import '../../../widget/staff.dart';
import '../../../widget/text.dart';

class VendorAccept extends StatefulWidget {
  final Map<String, dynamic> data;
  const VendorAccept({super.key, required this.data});

  @override
  State<VendorAccept> createState() => _VendorAcceptState();
}

class _VendorAcceptState extends State<VendorAccept> {
  bool onLoad = false, showInfo = false;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userDetails = widget.data['userDetails'] ?? {};
    List<dynamic> business = widget.data['businessDetails'] ?? {};
    print(business);
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

    // List<dynamic> serviceList = vendor['companyServices'];
    // for (var service in serviceList) {
    //   if (service == 'Transplanter Owner' ||
    //       service == 'Transplanter Operator') {
    //     vendorService['Transplanter Operator'] = true;
    //     vendorService['Transplanter Owner'] = true;
    //     continue;
    //   }
    //   vendorService[service] = true;
    // }

    Map<String, dynamic> document = widget.data['document'] ?? {};
    for (var i in business) {
      String key = i.keys.toString().replaceAll('(', '').replaceAll(')', '');
      vendorService[key] = true;
      if (i.keys.toString() == '(transplanter)') {
        vendorService['Transplanter Operator'] = true;
        vendorService['Transplanter Owner'] = true;
        businessDetails[0] = Map<String, dynamic>.from(i)['transplanter'];
      }
      if (i.keys.toString() == '(Sand Nursery Maker)') {
        businessDetails[1] = Map<String, dynamic>.from(i)['Sand Nursery Maker'];
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
        businessDetails[4] = Map<String, dynamic>.from(i)['Straw Baler Owner'];
      }
      if (i.keys.toString() == '(Paddy Grain Merchant)') {
        businessDetails[5] =
            Map<String, dynamic>.from(i)['Paddy Grain Merchant'];
      }
      if( i.keys.toString() == '(Labour Provider)') {
        businessDetails[6] = Map<String, dynamic>.from(i)['Labour Provider'];
      }
      if (i.keys.toString() == '(Aana Sakthi)') {
        businessDetails[7] = Map<String, dynamic>.from(i)['Aana Sakthi'];
      }
    }
    print(vendorService);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: height(context),
              width: width(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width(context),
                    height: 200,
                    child: Image.asset(
                      'assets/banner.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(height: 10),
                  RobotoText(title: 'Welcome to $appName', size: 22),
                  SizedBox(height: 4),
                  LatoText(
                    title: '${userDetails['businessName']} Request',
                    size: 20,
                    lineHeight: 1,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: Container(
                      width: width(context),
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: ListView(
                        children: [
                          SizedBox(height: 14),
                          RobotoText(title: 'Personal Details', size: 16),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LatoText(
                                    title: 'Business Name',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'Contact Name',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'Mobil Number',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'Alternate Number',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'Email ID',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'Address',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'District',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'Town',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'Language',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'Aadhaar/GST',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        LatoText(title: ' : ${userDetails['businessName']}', size: 14, lineHeight: 1),
                                        LatoText(title: ' : ${userDetails['contactName']}', size: 14, lineHeight: 1),
                                        LatoText(title: ' : ${userDetails['contactNumber']}', size: 14, lineHeight: 1),
                                        LatoText(title: ' : ${userDetails['optionalContactNumber']}', size: 14, lineHeight: 1),
                                        LatoText(title: ' : ${userDetails['email']}', size: 14, lineHeight: 1),
                                        LatoText(title: ' : ${userDetails['address']}', size: 14, lineHeight: 1),
                                        LatoText(title: ' : ${userDetails['district']}', size: 14, lineHeight: 1),
                                        LatoText(title: ' : ${userDetails['town']}', size: 14, lineHeight: 1),
                                        LatoText(title: ' : ${userDetails['language']}', size: 14, lineHeight: 1),
                                        LatoText(title: ' : ${userDetails['aAndGst']}', size: 14, lineHeight: 1),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          RobotoText(title: 'Bank Details', size: 16),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LatoText(
                                    title: 'Bank Name',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'Holder Name',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'Acc Number',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: 'IFSC Code',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LatoText(
                                    title:
                                        ' : ${userDetails['bankNameController']}',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: ' : ${userDetails['holderName']}',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title:
                                        ' : ${userDetails['holderNumberController']}',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                  LatoText(
                                    title: ' : ${userDetails['ifsc']}',
                                    size: 14,
                                    lineHeight: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          RobotoText(title: 'Service Details', size: 16),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection:
                            Axis.horizontal,
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
                                    'Transplanter \nOperator',
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
                                    'Transplanter \nOwner',
                                  ),
                                // LatoText(
                                //   title: 'Transplanter Owner',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Nursery Mat Supplier'] ??
                                    false)
                                  service(
                                    'Nursery Mat \nSupplier',
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
                                    'Sand Nursery \nMaker',
                                  ),
                                // LatoText(
                                //   title: 'Sand Nursery Maker',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Drone Services Provider'] ??
                                    false)
                                  service(
                                    'Drone Services \nProvider',
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
                                    'Straw Baler \nOwner',
                                  ),
                                // LatoText(
                                //   title: 'Straw Baler Owner',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Paddy Grain Merchant'] ??
                                    false)
                                  service(
                                    'Paddy Grain \nMerchant',
                                  ),
                                // LatoText(
                                //   title:
                                //   'Paddy Grain Merchant',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Labour Provider'] ??
                                    false)
                                  service(
                                    'Labour \nProvider',
                                  ),
                                // LatoText(
                                //   title:
                                //   'Paddy Grain Merchant',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Aana Sakthi'] ??
                                    false)
                                  service('Aana Sakthi'),
                                // LatoText(
                                //   title: 'Aana Sakthi',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
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

                          SizedBox(height: 14),
                          RobotoText(title: 'Document Details', size: 16),
                          SizedBox(height: 10),
                          viewImage('Aadhaar', document['aadher']),
                          viewImage('Passbook', document['passbook']),
                          viewImage(
                            'Photo of Equipment / Setup',
                            document['equipment'],
                          ),
                          viewImage(
                            'Passport Size  Photo',
                            document['passportPhoto'],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonWithText(
                          title: 'Accept',
                          onPressed: () async {
                            setState(() {
                              onLoad = true;
                            });
                            bool success = await Database().acceptVendor(
                              widget.data,
                            );
                            if (success) {
                              AppNotification().send(widget.data['userId'], 'Request Accept!', 'Now, Your are the vendor of $appName', 'vendorHomePage');
                              showToast('Vendor Added Successfully', context);
                              Navigator.of(context).pop();
                            } else {
                              showToast('Something Went Wrong!', context);
                            }
                            setState(() {
                              onLoad = false;
                            });
                          },
                          width: width(context) * 0.4,
                        ),
                        ButtonWithText(
                          title: 'Decline',
                          onPressed: () async {
                            setState(() {
                              onLoad = true;
                            });
                            bool success = await Database().declineVendor(
                              widget.data['id'],
                              widget.data['userId'],
                              [
                                document['aadher'],
                                document['passbook'],
                                document['equipment'],
                                document['passportPhoto'],
                              ]
                            );
                            if (success) {
                              AppNotification().send(widget.data['userId'], 'Request Decline!', 'Your Application has been rejected.', 'vendorHomePage');
                              showToast('Vendor Declined', context);
                              Navigator.of(context).pop();
                            } else {
                              showToast('Something Went Wrong!', context);
                            }
                            setState(() {
                              onLoad = false;
                            });
                          },
                          width: width(context) * 0.4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8),
                child: IconAsButton(icon: Icons.arrow_back_outlined, onPressed: (){
                  Navigator.pop(context);
                }, size: 28),
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
            Visibility(visible: onLoad, child: MyLoader()),
          ],
        ),
      ),
    );
  }

  Widget viewImage(String title, String url) {
    return Column(
      children: [
        LatoText(title: title, size: 14, lineHeight: 1),
        Container(
          margin: EdgeInsets.all(8),
          height: width(context) * 0.5,
          width: width(context),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.75,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: OnlineImage(url: url,border: 20,),
        ),
      ],
    );
  }

  Widget service(String key) {
    String word = key;
    key = key.replaceAll('\n', '');
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      width: 80,
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
              width: 50, // 75
              height: 50,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 4),
          LatoText(title: word, size: 8, lineHeight: 2),
        ],
      ),
    );
  }

}
