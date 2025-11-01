import 'package:flutter/material.dart';

import '../../../function/appFunction.dart';
import '../../../function/dataBaseFunction.dart';
import '../../../widget/button.dart';
import '../../../widget/staff.dart';
import '../../../widget/text.dart';

class VendorExtend extends StatefulWidget {
  final Map<String, dynamic> data;
  const VendorExtend({super.key, required this.data});

  @override
  State<VendorExtend> createState() => _VendorExtendState();
}

class _VendorExtendState extends State<VendorExtend> {
  bool showInfo = false;
  bool onLoad = false;
  List<Map<String, dynamic>> businessDetails = [{}, {}, {}, {}, {}, {}, {}, {}];

  @override
  Widget build(BuildContext context) {
    final services = widget.data['currentService'];
    Map<String, bool> vendorService = {};
    for (var i in services) {}
    final details = widget.data['currentDetails'];

    for (var i in services) {
      int index = 0;
      vendorService[i] = true;
      if (i == 'Transplanter Operator' ) {
        index = 0;
      } else if (i == 'Transplanter Owner' ) {
        index = 0;
      } else if (i == 'Sand Nursery Maker') {
        index = 1;
      } else if (i == 'Nursery Mat Supplier') {
        index = 2;
      } else if (i == 'Drone Services Provider') {
        index = 3;
      } else if (i == 'Straw Baler Owner') {
        index = 4;
      } else if (i == 'Paddy Grain Merchant') {
        index = 5;
      } else if (i == 'Labour Provider') {
        index = 6;
      } else if (i == 'Aana Sakthi') {
        index = 7;
      }
      for (var s in details) {
        print(s);
        for (var key in Map<String, dynamic>.from(s).keys) {
          if (key == i || key == 'transplanter') {
            businessDetails[index] = s[key];
          }
        }
      }
    }
    print(services);
    print(details);

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
                    title: '${widget.data['vendorName']} Request',
                    size: 20,
                    lineHeight: 1,
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Container(
                      width: width(context),
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: ListView(
                        children: [
                          SizedBox(height: 14),
                          RobotoText(title: 'Service Details', size: 16),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 4,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (vendorService['Transplanter Operator'] ??
                                    false)
                                  service('Transplanter \nOperator'),
                                // LatoText(
                                //   title:
                                //   'Transplanter Operator',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Transplanter Owner'] ??
                                    false)
                                  service('Transplanter \nOwner'),
                                // LatoText(
                                //   title: 'Transplanter Owner',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Nursery Mat Supplier'] ??
                                    false)
                                  service('Nursery Mat \nSupplier'),
                                // LatoText(
                                //   title:
                                //   'Nursery Mat Supplier',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Sand Nursery Maker'] ??
                                    false)
                                  service('Sand Nursery \nMaker'),
                                // LatoText(
                                //   title: 'Sand Nursery Maker',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Drone Services Provider'] ??
                                    false)
                                  service('Drone Services \nProvider'),
                                // LatoText(
                                //   title:
                                //   'Drone Services Provider',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Straw Baler Owner'] ?? false)
                                  service('Straw Baler \nOwner'),
                                // LatoText(
                                //   title: 'Straw Baler Owner',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Paddy Grain Merchant'] ??
                                    false)
                                  service('Paddy Grain \nMerchant'),
                                // LatoText(
                                //   title:
                                //   'Paddy Grain Merchant',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Labour Provider'] ?? false)
                                  service('Labour \nProvider'),
                                // LatoText(
                                //   title:
                                //   'Paddy Grain Merchant',
                                //   size: 14,
                                //   lineHeight: 1,
                                // ),
                                if (vendorService['Aana Sakthi'] ?? false)
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RobotoText(title: 'Service Info', size: 16),
                              TextAsButton(
                                title: 'Show',
                                onPressed: () {
                                  setState(() {
                                    showInfo = true;
                                  });
                                },
                                color: Theme.of(context).colorScheme.primary,
                                size: 16,
                              ),
                            ],
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
                            bool success = await Database().acceptUpdate(
                              widget.data,
                            );
                            if (success) {
                              AppNotification().send(
                                widget.data['userId'],
                                'Request Accept!',
                                'Now, Your have new service',
                                'vendorHomePage',
                              );
                              showToast('Vendor Updated Successfully', context);
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
                            bool success = await Database().decliedUpdate(widget.data['id']);
                            if (success) {
                              AppNotification().send(
                                widget.data['userId'],
                                'Request Decline!',
                                'Your Application has been rejected.',
                                'vendorHomePage',
                              );
                              showToast('Request Declined', context);
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
                child: IconAsButton(
                  icon: Icons.arrow_back_outlined,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  size: 28,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      if (vendorService['Transplanter Operator'] ?? false)
                        Column(
                          children: [
                            RobotoText(title: 'Transplant', size: 14),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      if (vendorService['Transplanter Owner'] ?? false)
                        Column(
                          children: [
                            RobotoText(title: 'Transplant', size: 14),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            RobotoText(title: 'Sand Nursery Maker', size: 14),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      if (vendorService['Nursery Mat Supplier'] ?? false)
                        Column(
                          children: [
                            SizedBox(height: 10),
                            RobotoText(title: 'Nursery Mat Supplier', size: 14),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      if (vendorService['Drone Services Provider'] ?? false)
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            RobotoText(title: 'Straw Baler Owner', size: 14),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      if (vendorService['Paddy Grain Merchant'] ?? false)
                        Column(
                          children: [
                            SizedBox(height: 10),
                            RobotoText(title: 'Paddy Grain Merchant', size: 14),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            RobotoText(title: 'Labor Provider', size: 14),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    // LatoText(
                                    //   title: 'Works ',
                                    //   size: 14,
                                    //   lineHeight: 1,
                                    // ),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    // LatoText(
                                    //   title:
                                    //       ' : ${(businessDetails[6]['workOffered']['Sowing']) ? 'Sowing' : ''} :${(businessDetails[6]['workOffered']['Weeding']) ? 'Weeding' : ''} :${(businessDetails[6]['workOffered']['Transplanting']) ? 'Transplanting' : ''} :${(businessDetails[6]['workOffered']['Spraying']) ? 'Spraying' : ''} :${(businessDetails[6]['workOffered']['Field labor']) ? 'Field labor' : ''} :${(businessDetails[6]['workOffered']['Harvesting']) ? 'Harvesting' : ''} :${(businessDetails[6]['workOffered']['Agri processing']) ? 'Agri processing' : ''} ',
                                    //   size: 14,
                                    //   lineHeight: 1,
                                    // ),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
