import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riceking/function/appFunction.dart';
import 'package:riceking/pages/user/user_book_vendor.dart';
import 'package:riceking/pages/user/user_view_vendor.dart';

import '../../widget/button.dart';
import '../../widget/inputField.dart';
import '../../widget/online_image.dart';
import '../../widget/text.dart';

class FilterPage extends StatefulWidget {
  final List<dynamic> vendorList;
  final String title;
  final bool price;
  const FilterPage({
    super.key,
    required this.vendorList,
    required this.title,
    required this.price,
  });

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool showFilter = false;
  TextEditingController otherController = TextEditingController();
  String price = '';
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> list = [];
    for (var vendor in widget.vendorList) {
      List<dynamic> keywords = vendor.data()['searchKeyword'];
      List<String> word = widget.title.split('  ');
      for (String w in word) {
        if (keywords.contains(w)) {
          list.add(vendor.data());
        }
      }
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SizedBox(
          height: height(context),
          width: width(context),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: Image.asset(
                        'assets/appLogo.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(width: 24),
                    SizedBox(
                      width: width(context) - 150,
                      height: 50,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.tertiary.withOpacity(0.75),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: width(context),
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return _vendorCard(list[index]);
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

  Widget _vendorCard(Map<String, dynamic> vendor) {
    List<dynamic> serviceList = vendor['companyServices'];
    String key =
        widget.title == 'Transplanter Operator' ||
            widget.title == 'Transplanter Owner'
        ? 'transplanter'
        : widget.title;
    var businessDetails = {};
    List<dynamic> business = vendor['businessDetails'] ?? {};
    for (var i in business) {
      if (i.keys.toString() == '($key)') {
        businessDetails = Map<String, dynamic>.from(i)[key];
      }
    }

    print('the services');
    print(businessDetails);
    if (widget.title == 'Transplanter Operator') {
      key = '₹ ${businessDetails['ratePerAcre'] ?? '-'} /acre';
    } else if (widget.title == 'Transplanter Owner') {
      key = '₹ ${businessDetails['ratePerAcre'] ?? '-'} /acre';
    } else if (widget.title == 'Nursery Mat Supplier') {
      key = '₹ ${businessDetails['ratePerMat'] ?? '-'} /nursery mat';
    } else if (widget.title == 'Sand Nursery Maker') {
      key = '₹ ${businessDetails['setUpCost'] ?? '-'} /bag of seeds';
    } else if (widget.title == 'Drone Services Provider') {
      key = '₹ ${businessDetails['rateAcre'] ?? '-'} /acre';
    } else if (widget.title == 'Straw Baler Owner') {
      key = '₹ ${businessDetails['ratePerBale'] ?? '-'} /bale';
    } else if (widget.title == 'Paddy Grain Merchant') {
      key = '₹ ${businessDetails['priceRange'] ?? '-'} /acre';
    } else if (widget.title == 'Labour Provider') {
      key =
          '₹ ${businessDetails['lpFemaleFare'] ?? '-'}or${businessDetails['lpMenFare'] ?? '-'}';
    } else if (widget.title == 'Aana Sakthi') {
      key = '₹100';
    }
    print(serviceList.join(', '));
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
                        builder: (context) => UserViewVendor(vendor: vendor),
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
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                (int.parse(vendor['companyRating'] ?? 0) >
                                        index)
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 16,
                                color:
                                    (int.parse(vendor['companyRating'] ?? 0) >
                                        index)
                                    ? Colors.amberAccent
                                    : Theme.of(
                                        context,
                                      ).colorScheme.tertiary.withOpacity(0.7),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      LatoText(
                        title: vendor['userDetails']['town'],
                        size: 10,
                        lineHeight: 1,
                      ),
                    ],
                  ),
                  if (!widget.price)
                    Expanded(
                      child: LatoText(
                        title: serviceList.join(', '),
                        size: 10,
                        lineHeight: 2,
                      ),
                    ),
                  if (widget.price)
                    LatoText(title: key, size: 14, lineHeight: 2),
                  SizedBox(height: 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonWithText(
                        title: 'Book Now',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserBookVendor(vendor: vendor),
                            ),
                          );
                        },
                        width: 140,
                        height: 30,
                      ),
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
