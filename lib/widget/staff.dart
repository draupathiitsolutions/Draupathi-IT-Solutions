import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/widget/online_image.dart';
import 'package:riceking/widget/text.dart';

import '../function/appFunction.dart';

class MyLoader extends StatelessWidget {
  const MyLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      height: height(context),
      width: width(context),
      child: SpinKitFadingCircle(
        color: Theme.of(context).colorScheme.tertiary,
        size: 50.0,
      ),
    );
  }
}

class BusinessDetails extends StatefulWidget {
  final Map<String, dynamic> data;
  const BusinessDetails({super.key, required this.data});

  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userDetails = widget.data['userDetails'] ?? {};
    List<dynamic> vendorService = widget.data['companyServices'] ?? [];
    List<dynamic> business = widget.data['businessDetails'] ?? {};
    List<Map<String, dynamic>> businessDetails = [{}, {}, {}, {}, {}, {}, {}];
    Map<String, dynamic> document = widget.data['document'] ?? {};
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
      if (i.keys.toString() == '(Aana Sakthi)') {
        businessDetails[6] = Map<String, dynamic>.from(i)['Aana Sakthi'];
      }
    }
    return Column(
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
                LatoText(title: 'Business Name', size: 14, lineHeight: 1),
                LatoText(title: 'Contact Name', size: 14, lineHeight: 1),
                LatoText(title: 'Mobil Number', size: 14, lineHeight: 1),
                LatoText(title: 'Alternate Number', size: 14, lineHeight: 1),
                LatoText(title: 'Email ID', size: 14, lineHeight: 1),
                LatoText(title: 'Address', size: 14, lineHeight: 1),
                LatoText(title: 'District', size: 14, lineHeight: 1),
                LatoText(title: 'Town', size: 14, lineHeight: 1),
                LatoText(title: 'Language', size: 14, lineHeight: 1),
                LatoText(title: 'Aadhaar/GST', size: 14, lineHeight: 1),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LatoText(
                        title: ' : ${userDetails['businessName']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${userDetails['contactName']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${userDetails['contactNumber']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${userDetails['optionalContactNumber']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${userDetails['email']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${userDetails['address']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${userDetails['district']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${userDetails['town']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${userDetails['language']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${userDetails['aAndGst']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Divider(color: Theme.of(context).colorScheme.tertiary, height: 1),
        SizedBox(height: 14),
        RobotoText(title: 'Bank Details', size: 16),
        SizedBox(height: 10),
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LatoText(title: 'Bank Name', size: 14, lineHeight: 1),
                LatoText(title: 'Holder Name', size: 14, lineHeight: 1),
                LatoText(title: 'Acc Number', size: 14, lineHeight: 1),
                LatoText(title: 'IFSC Code', size: 14, lineHeight: 1),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LatoText(
                  title: ' : ${userDetails['bankNameController']}',
                  size: 14,
                  lineHeight: 1,
                ),
                LatoText(
                  title: ' : ${userDetails['holderName']}',
                  size: 14,
                  lineHeight: 1,
                ),
                LatoText(
                  title: ' : ${userDetails['holderNumberController']}',
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
        SizedBox(height: 10),
        Divider(color: Theme.of(context).colorScheme.tertiary, height: 1),
        SizedBox(height: 14),
        RobotoText(title: 'Service Details', size: 16),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (vendorService.contains('Transplanter Operator'))
                  LatoText(
                    title: 'Transplanter Operator',
                    size: 14,
                    lineHeight: 1,
                  ),
                if (vendorService.contains('Transplanter Owner'))
                  LatoText(
                    title: 'Transplanter Owner',
                    size: 14,
                    lineHeight: 1,
                  ),
                if (vendorService.contains('Nursery Mat Supplier'))
                  LatoText(
                    title: 'Nursery Mat Supplier',
                    size: 14,
                    lineHeight: 1,
                  ),
                if (vendorService.contains('Sand Nursery Maker'))
                  LatoText(
                    title: 'Sand Nursery Maker',
                    size: 14,
                    lineHeight: 1,
                  ),
                if (vendorService.contains('Drone Services Provider'))
                  LatoText(
                    title: 'Drone Services Provider',
                    size: 14,
                    lineHeight: 1,
                  ),
                if (vendorService.contains('Straw Baler Owner'))
                  LatoText(title: 'Straw Baler Owner', size: 14, lineHeight: 1),
                if (vendorService.contains('Paddy Grain Merchant'))
                  LatoText(
                    title: 'Paddy Grain Merchant',
                    size: 14,
                    lineHeight: 1,
                  ),
                if (vendorService.contains('Aana Sakthi'))
                  LatoText(title: 'Aana Sakthi', size: 14, lineHeight: 1),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Divider(color: Theme.of(context).colorScheme.tertiary, height: 1),
        SizedBox(height: 14),
        RobotoText(title: 'Service Info', size: 16),
        SizedBox(height: 10),
        if (vendorService.contains('Transplanter Operator') ||
            vendorService.contains('Transplanter Owner'))
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
                      LatoText(title: 'Model', size: 14, lineHeight: 1),
                      LatoText(
                        title: 'Year of Purchase',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(title: 'Area/Day', size: 14, lineHeight: 1),
                      LatoText(title: 'Rate/Acre', size: 14, lineHeight: 1),
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
                        title: ' : ${businessDetails[0]['provideTractor']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[0]['model']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[0]['yearOfP']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[0]['perDayArea']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[0]['ratePerAcre']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        if (vendorService.contains('Sand Nursery Maker'))
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
                      LatoText(title: 'Team Size', size: 14, lineHeight: 1),
                      LatoText(title: 'Soil/Sand', size: 14, lineHeight: 1),
                      LatoText(
                        title: 'SetUp Cost/Acre',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(title: 'Capacity', size: 14, lineHeight: 1),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LatoText(
                        title: ' : ${businessDetails[1]['areaOfOperation']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[1]['teamSize']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[1]['sourceOfSoil']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[1]['setUpCost']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[1]['capacity']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        if (vendorService.contains('Nursery Mat Supplier'))
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
                      LatoText(title: 'Quantity Day', size: 14, lineHeight: 1),
                      LatoText(
                        title: 'Nursery Location',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(title: 'Lead Time', size: 14, lineHeight: 1),
                      LatoText(title: 'Rate/Mat', size: 14, lineHeight: 1),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LatoText(
                        title: ' : ${businessDetails[2]['quantityDay']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[2]['nurseryLocation']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[2]['leadTime']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[2]['ratePerMat']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        if (vendorService.contains('Drone Services Provider'))
          Column(
            children: [
              SizedBox(height: 10),
              RobotoText(title: 'Drone Services Provider', size: 14),
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
                      LatoText(title: 'Area/Day', size: 14, lineHeight: 1),
                      LatoText(title: 'Rate/Acre', size: 14, lineHeight: 1),
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
                        title: ' : ${businessDetails[3]['droneMakeModel']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[3]['areaCovered']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[3]['rateAcre']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[3]['permissionLicense']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        if (vendorService.contains('Straw Baler Owner'))
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
                      LatoText(title: 'Bale Type', size: 14, lineHeight: 1),
                      LatoText(
                        title: 'Bale Size&Weight',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(title: 'Rate/Bale', size: 14, lineHeight: 1),
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
                        title: ' : ${businessDetails[4]['baleType']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[4]['baleSizeAndWeight']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[4]['ratePerBale']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[4]['transportAvailable']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        if (vendorService.contains('Paddy Grain Merchant'))
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
                      LatoText(title: 'Location', size: 14, lineHeight: 1),
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
                      LatoText(title: 'Price Range', size: 14, lineHeight: 1),
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
                        title: ' : ${businessDetails[5]['qualityAccepts']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[5]['paddyVarieties']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[5]['priceRange']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[5]['paymentTimeline']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        if (vendorService.contains('Aana Sakthi'))
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
                      LatoText(title: 'Aana Type', size: 14, lineHeight: 1),
                      LatoText(title: 'Product Sell', size: 14, lineHeight: 1),
                      LatoText(
                        title: 'Monthly Volume',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(title: 'Village Cover', size: 14, lineHeight: 1),
                      LatoText(title: 'Stock Aana', size: 14, lineHeight: 1),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LatoText(
                        title: ' : ${businessDetails[6]['typeAana']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[6]['productYouCanSell']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[6]['monthlyVolume']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[6]['villageCover']}',
                        size: 14,
                        lineHeight: 1,
                      ),
                      LatoText(
                        title: ' : ${businessDetails[6]['stockAana']}',
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
        Divider(color: Theme.of(context).colorScheme.tertiary, height: 1),
        SizedBox(height: 14),
        RobotoText(title: 'Document Details', size: 16),
        SizedBox(height: 10),
        viewImage('Aadhaar', document['aadher'] ?? ''),
        viewImage('Passbook', document['passbook'] ?? ''),
        viewImage('Photo of Equipment / Setup', document['equipment'] ?? ''),
        viewImage('Passport Size  Photo', document['passportPhoto'] ?? ''),
      ],
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              url,
              height: 100,
              width: width(context),
              fit: BoxFit.fitHeight,
              errorBuilder: (context, e, tree) {
                return Image.asset(
                  'assets/image_not_founded.jpg',
                  fit: BoxFit.fitWidth,
                  height: 120,
                  width: 120,
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: SpinKitFadingCircle(
                      color: Theme.of(
                        context,
                      ).colorScheme.tertiary.withOpacity(0.75),
                      size: 25.0,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}


class AutoScrollingImageSlider extends StatefulWidget {
  final List<String> imageUrls;
  final Duration autoScrollDuration;
  final Curve autoScrollCurve;

  const AutoScrollingImageSlider({
    Key? key,
    required this.imageUrls,
    this.autoScrollDuration = const Duration(seconds: 3), // Default to 3 seconds
    this.autoScrollCurve = Curves.easeInOut, // Default animation curve
  }) : super(key: key);

  @override
  _AutoScrollingImageSliderState createState() => _AutoScrollingImageSliderState();
}

class _AutoScrollingImageSliderState extends State<AutoScrollingImageSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();

    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.autoScrollDuration, (Timer timer) {
      if (_pageController.hasClients) { // Check if the page controller is attached to a view
        _currentPage++;
        if (_currentPage >= widget.imageUrls.length) {
          _currentPage = 0; // Loop back to the first image
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 700), // Animation duration for scrolling
          curve: widget.autoScrollCurve,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    _pageController.dispose(); // Dispose the page controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return SpinKitFadingCircle(
        color: Theme.of(context).colorScheme.tertiary,
        size: 50.0,
      );
    }

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),child: OnlineImage(url: widget.imageUrls[index])));
            },
          ),
        ),
        // // Optional: Add page indicators
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: List.generate(widget.imageUrls.length, (index) {
        //       return Container(
        //         width: 8.0,
        //         height: 8.0,
        //         margin: const EdgeInsets.symmetric(horizontal: 4.0),
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: _currentPage == index ? Theme.of(context).colorScheme.secondary : Colors.white54,
        //         ),
        //       );
        //     }),
        //   ),
        // ),
      ],
    );
  }
}

class MyLoadScreen extends StatelessWidget {
  const MyLoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context),
      width: width(context),
      child: SpinKitFadingCircle(
        color: Theme.of(context).colorScheme.tertiary,
        size: 50.0,
      ),
    );
  }
}
