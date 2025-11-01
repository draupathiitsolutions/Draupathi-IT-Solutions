import 'package:flutter/material.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/pages/user/user_book_vendor.dart';
import 'package:riceking/pages/vendor/vendor_review_page.dart';
import 'package:riceking/widget/button.dart';
import 'package:riceking/widget/inputField.dart';
import 'package:riceking/widget/staff.dart';
import 'package:riceking/widget/text.dart';

import '../../function/appFunction.dart';
import '../../widget/online_image.dart';

class UserViewVendor extends StatefulWidget {
  final Map<String, dynamic> vendor;
  const UserViewVendor({super.key, required this.vendor});

  @override
  State<UserViewVendor> createState() => _UserViewVendorState();
}

class _UserViewVendorState extends State<UserViewVendor> {
  bool showReview = false, onLoad = false,showInfo = false;
  TextEditingController reviewController = TextEditingController();
  int rating = 0,lh = 1;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> vendor = widget.vendor;
    List<dynamic> serviceList = vendor['companyServices'];
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
    for (var service in serviceList) {
      if(service == 'Transplanter Owner' || service == 'Transplanter Operator') {
        vendorService['Transplanter Operator'] = true;
        vendorService['Transplanter Owner'] = true;
        continue;
      }
      print(service);
      vendorService[service] = true;
    }
    List<dynamic> business = vendor['businessDetails'] ?? {};
    List<Map<String, dynamic>> businessDetails = [
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {},
    ];
    for (var i in business) {
      print("key  ${i.keys} ${i.keys.toString() == '(Straw Baler Owner)'}");
      if (i.keys.toString() == '(transplanter)') {
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
      if (i.keys.toString() == '(Labour Provider)') {
        businessDetails[6] = Map<String, dynamic>.from(i)['Labour Provider'];
      }
      if (i.keys.toString() == '(Aana Sakthi)') {
        businessDetails[7] = Map<String, dynamic>.from(i)['Aana Sakthi'];
      }
    }
    print(vendorService);
    print(businessDetails[6]);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: height(context),
          width: width(context),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: width(context),
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: width(context),
                                child: OnlineImage(url: vendor['companyUrl']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
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
                                      SizedBox(height: 14),
                                      RobotoText(
                                        title: 'Service Details',
                                        size: 16,
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
                                        TextAsButton(
                                          title: 'Review',
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        VendorReviewPage(
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
                                        const SizedBox(width: 10),
                                        IconAsButton(
                                          icon: Icons.add,
                                          onPressed: () {
                                            setState(() {
                                              showReview = true;
                                            });
                                          },

                                          size: 24,
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
                                            padding: const EdgeInsets.only(
                                              right: 8.0,
                                            ),
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
                                              vendor['ratingCount'].toString(),
                                          size: 14,
                                          lineHeight: 1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      spacing: 14,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RobotoText(
                              title: 'Service Info',
                              size: 16,
                            ),
                            TextAsButton(title: 'Show', onPressed: (){
                              setState(() {
                                showInfo = true;
                              });
                            }, color: Theme.of(context).colorScheme.primary
                                , size: 16)
                          ],
                        ),
                        ButtonWithText(
                          title: 'Booking',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => UserBookVendor(vendor: vendor),
                              ),
                            );
                          },
                          width: width(context),
                        ),
                      ],
                    ),
                  ),
                ],
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
              Visibility(visible: showInfo || showReview,child: GestureDetector(
                onTap: (){
                  setState(() {
                    showReview = showInfo = false;
                  });
                },
                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.2),
                  height: height(context),
                  width: width(context),
                ),
              )),
              Positioned(
                bottom: 0,
                child: Visibility(
                  visible: showReview,
                  child: Container(
                    height: 250,
                    width: width(context) - 48,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RobotoText(title: 'Review', size: 24),
                        SizedBox(height: 24),
                        Container(
                          height: 30,
                          width: width(context),
                          alignment: Alignment(0, 0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (builder, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    rating = index + 1;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.star,
                                    color:
                                        rating > index
                                            ? Colors.amberAccent
                                            : Colors.black26,
                                    size: 18,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 4),
                        TextFieldWithIcon(
                          controller: reviewController,
                          hintText: 'Review',
                          icons: Icons.bar_chart_rounded,
                          keyboardType: TextInputType.multiline,
                        ),
                        SizedBox(height: 18),
                        ButtonWithText(
                          title: 'Submit',
                          onPressed: () async {
                            if (rating > 0 &&
                                reviewController.text.isNotEmpty) {
                              setState(() {
                                FocusScope.of(context).unfocus();
                                onLoad = true;
                              });
                              print('pressed');
                              await Database().updateReview(
                                widget.vendor['id'],
                                widget.vendor['companyRating'],
                                widget.vendor['ratingCount'],
                                {
                                  'rating': rating,
                                  'review': reviewController.text,
                                  'by': profile['name'],
                                },
                              );
                              setState(() {
                                onLoad = false;
                                showReview = false;
                              });
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
                child: Visibility(visible: showInfo,child: Container(
                  height: height(context) * 0.6,
                  width: width(context) - 24,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.all(
                       Radius.circular(16),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RobotoText(title: 'Service Info', size: 20),
                          IconAsButton(icon: Icons.close, onPressed: (){setState(() {
                            showInfo = false;
                          });}, size: 20),
                        ],
                      ),
                      SizedBox(height: 10),
                      if (vendorService['Transplanter Operator'] ??
                          false || vendorService['Transplanter Owner'] ?? false)
                        Column(
                          children: [
                            RobotoText(
                              title: 'Transplant',
                              size: 14,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    LatoText(
                                      title:
                                      'TransPlanter Ownership',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Provide Tractor',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title: 'Model',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Year of Purchase',
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
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
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
                      if (vendorService['Sand Nursery Maker'] ??
                          false)
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
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    LatoText(
                                      title:
                                      'Area Of Operation',
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
                                      title:
                                      'SetUp Cost/Acre',
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
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
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
                              title:
                              'Nursery Mat Supplier',
                              size: 14,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    LatoText(
                                      title:
                                      'Quantity Day',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Nursery Location',
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
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
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
                              title:
                              'Drone Services Provider',
                              size: 14,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    LatoText(
                                      title:
                                      'Services Offered',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Drone Make&Model',
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
                                      title:
                                      'Permission/License',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
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
                      if (vendorService['Straw Baler Owner'] ??
                          false)
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
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    LatoText(
                                      title: 'Bale Type',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Bale Size&Weight',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title: 'Rate/Bale',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Transport Available',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
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
                              title:
                              'Paddy Grain Merchant',
                              size: 14,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    LatoText(
                                      title: 'Location',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Quality Accepts',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Paddy Varieties',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Price Range',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Payment Timeline',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
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
                      if (vendorService['Labour Provider'] ??
                          false)
                        Column(
                          children: [
                            SizedBox(height: 10),
                            RobotoText(
                              title: 'Labour Provider',
                              size: 14,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    LatoText(
                                      title: 'Name',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Father Name',
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
                                      title:
                                      'Femake Fare',
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
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
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
                      if (vendorService['Aana Sakthi'] ??
                          false)
                        Column(
                          children: [
                            SizedBox(height: 10),
                            RobotoText(
                              title: 'Aana Sakthi',
                              size: 14,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    LatoText(
                                      title: 'Aana Type',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Product Sell',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Monthly Volume',
                                      size: 14,
                                      lineHeight: 1,
                                    ),
                                    LatoText(
                                      title:
                                      'Village Cover',
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
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
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
                )),
              ),
              Visibility(visible: onLoad, child: MyLoader()),
            ],
          ),
        ),
      ),
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