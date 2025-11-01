import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riceking/widget/inputField.dart';
import 'package:riceking/widget/online_image.dart';
import 'package:riceking/widget/staff.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/button.dart';
import '../../widget/text.dart';

class UserBookVendor extends StatefulWidget {
  final Map<String, dynamic> vendor;
  const UserBookVendor({super.key, required this.vendor});

  @override
  State<UserBookVendor> createState() => _UserBookVendorState();
}

class _UserBookVendorState extends State<UserBookVendor> {
  String? _selectedItem;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool onLoad = false, showConform = false;
  TextEditingController acreController = TextEditingController();
  String serSelect = '';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> vendor = widget.vendor;List<dynamic> serviceList = vendor['companyServices'];
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
      vendorService[service] = true;
    }

    List<Map<String, dynamic>> businessDetails = [{}, {}, {}, {}, {}, {}, {}, {}];
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

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment(0, 0),
          children: [
            SizedBox(
              width: width(context),
              height: height(context),
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: width(context),
                      child: ListView(
                        children: [
                          Container(
                            height: 200,
                            width: width(context),
                            child: OnlineImage(
                              url: vendor['companyUrl'],
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RobotoText(title: vendor['companyName'], size: 24),
                                const SizedBox(height: 12),
                                LatoText(
                                  title: vendor['description'],
                                  size: 14,
                                  lineHeight: 2,
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
                                // const SizedBox(height: 18),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                //   child: SizedBox(
                                //     width: width(context) - 16,
                                //     child: DropdownButtonFormField<dynamic>(
                                //       value: _selectedItem,
                                //       onChanged: (dynamic newValue) {
                                //         if (newValue != null) {
                                //           setState(() {
                                //             _selectedItem = newValue;
                                //           });
                                //         }
                                //       },
                                //       itemHeight: 50,
                                //       borderRadius: BorderRadius.horizontal(
                                //         right: Radius.circular(16),
                                //       ),
                                //       items:
                                //           vendor['companyServices']
                                //               .map<DropdownMenuItem<dynamic>>((
                                //                 dynamic value,
                                //               ) {
                                //                 return DropdownMenuItem<dynamic>(
                                //                   value: value,
                                //                   child: Text(value),
                                //                 );
                                //               })
                                //               .toList(),
                                //       decoration: const InputDecoration(
                                //         labelText: 'Select Service!',
                                //         border: OutlineInputBorder(),
                                //         contentPadding: EdgeInsets.symmetric(
                                //           horizontal: 16,
                                //         ),
                                //       ),
                                //       validator: (value) {
                                //         if (value == null || value.isEmpty) {
                                //           return 'Select an service';
                                //         }
                                //         return null;
                                //       },
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(height: 18),
                                RobotoText(title: 'Select Slot', size: 16),
                                TableCalendar(
                                  firstDay: DateTime.utc(2020, 1, 1),
                                  lastDay: DateTime.utc(2030, 12, 31),
                                  focusedDay: _focusedDay,
                                  selectedDayPredicate: (DateTime date) {
                                    return isSameDay(_selectedDay, date);
                                  },
                                  calendarFormat: CalendarFormat.week,
                                  onDaySelected: _onDaySelected,
                                  headerStyle: HeaderStyle(
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                    formatButtonShowsNext: false,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    titleTextStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  calendarStyle: CalendarStyle(
                                    markerSize: 20,
                                    todayDecoration: BoxDecoration(
                                      color:Theme.of(context).colorScheme.surface,
                                      shape: BoxShape.circle,
                                    ),
                                    todayTextStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    selectedDecoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    weekendTextStyle: TextStyle(color: Colors.red),
                                    markerDecoration: BoxDecoration(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ButtonWithText(
                      title: 'Book Now',
                      width: width(context) - 36,
                      onPressed: () {
                        if (_selectedItem == null) {
                          showToast('Select Service!', context);
                        } else if (_selectedDay == null) {
                          showToast('Select Day!', context);
                        } else {
                          setState(() {
                            showConform = true;
                          });
                        }
                      },
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
            Visibility(
              visible: showConform,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showConform = false;
                  });
                },

                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.2),
                  height: height(context),
                  width: width(context),
                  alignment: Alignment(0, 0),
                  child: Container(
                    height: 294,
                    padding: EdgeInsets.all(16),
                    width: width(context) * 0.8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RobotoText(title: 'Conform Slot', size: 24),
                        SizedBox(height: 20,),
                        LatoText(
                          title:
                              'Do You want $_selectedItem service on ${_selectedDay?.day}:${_selectedDay?.month}:${_selectedDay?.year} from ${vendor['companyName']}',
                          size: 14,
                          lineHeight: 3,
                        ),
                        SizedBox(height: 12,),
                        TextFieldWithIcon(controller: acreController, hintText: serSelect == 'labor' ? 'How many labour Need?' : serSelect == 'aanaSathi' ? 'Product need' : 'How many acre', icons: Icons.grass, keyboardType: TextInputType.text),
                        SizedBox(height: 12),
                        ButtonWithText(title: 'submit', onPressed: () async {
                          if (acreController.text.isNotEmpty) {
                            setState(() {
                              onLoad = true;
                            });
                            String day = '${_selectedDay?.day}:${_selectedDay?.month}:${_selectedDay?.year}';
                            bool success = await Database().conformSlot(vendor['id'], day, _selectedItem??'', vendor['companyUrl'],acreController.text,vendor['companyName']);
                            if(success) {
                              showToast('Request Send', context);
                              AppNotification().send(vendor['userId'], 'Booking Request!', 'You have a new booking request from a farmer.', 'userRequest');
                            } else {
                              showToast('Something Went Wrong', context);
                            }

                            setState(() {
                              showConform = false;
                              onLoad = false;
                            });Navigator.pop(context);
                          } else {
                            showToast('Enter acre', context);
                          }
                        }, width: width(context)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(visible: onLoad,child: MyLoader())
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (_isUpcomingDay(selectedDay)) {
      print(selectedDay);
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = selectedDay;
      });
    }
  }

  bool _isUpcomingDay(DateTime dayToCheck) {
    final now = DateTime.now();
    final today = DateTime.utc(now.year, now.month, now.day);
    final checkingDay = DateTime.utc(
      dayToCheck.year,
      dayToCheck.month,
      dayToCheck.day,
    );
    return checkingDay.isAfter(today);
  }


  Widget service(String key,String price) {
    String word = key;
    key = key.replaceAll('\n', '');

    return GestureDetector(
      onTap: (){
        setState(() {
          _selectedItem = key;
          if(key == 'Labour Provider') {
            serSelect = 'labor';
          } else if(key == 'Aana Sakthi') {
            serSelect = 'aanaSathi';
          } else {
            serSelect = 'other';
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(8),
        width: 80,
        decoration: BoxDecoration(
          color: '$_selectedItem' == key ? Theme.of(context).colorScheme.primary : Colors.white ,
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
                width: 65, // 75
                height: 65,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 4),
            LatoText(title: word, size: 8, lineHeight: 2,color: '$_selectedItem' == key ? Colors.white : Theme.of(context).colorScheme.tertiary,),
            SizedBox(height: 8,),
            LatoText(title: price, size: 10, lineHeight: 1,color: '$_selectedItem' == key ? Colors.white : Theme.of(context).colorScheme.tertiary,),
          ],
        ),
      ),
    );
  }
}