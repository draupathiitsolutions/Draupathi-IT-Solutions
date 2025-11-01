import 'package:flutter/material.dart';
import 'package:riceking/pages/user/user_home_page.dart';
import 'package:riceking/pages/user/vendor_reg/reg_1.dart';
import 'package:riceking/pages/user/vendor_reg/reg_2.dart';
import 'package:riceking/pages/user/vendor_reg/reg_3.dart';
import 'package:riceking/pages/user/vendor_reg/reg_4.dart';
import 'package:riceking/pages/user/vendor_reg/reg_5.dart';
import 'package:riceking/widget/inputField.dart';
import 'package:riceking/widget/staff.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/button.dart';
import '../../widget/text.dart';

class UserRegVendor extends StatefulWidget {
  const UserRegVendor({super.key});

  @override
  State<UserRegVendor> createState() => _UserRegVendorState();
}

class _UserRegVendorState extends State<UserRegVendor> {
  List<Widget> regPage = [Reg1(), Reg2(), Reg3(), Reg4(), Reg5()];
  int pageIndex = 0;
  bool showSubmit = false,onLoad = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment(0, 0),
          children: [
            SizedBox(
              height: height(context),
              width: width(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 130,
                        width: width(context),
                        child: Image.asset('assets/banner.png', fit: BoxFit.fill),
                      ),
                      Positioned(
                        top: 18,
                        left: 18,
                        child: IconAsButton(
                          icon: Icons.arrow_back_rounded,
                          onPressed: () {
                            if (pageIndex == 0) {
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                pageIndex--;
                              });
                            }
                          },
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                        width: width(context),
                        child: ListView(
                          children: [
                            Visibility(
                              visible: pageIndex != 4,
                              child: Align(
                                child: RobotoText(title: 'Info', size: 48),
                              ),
                            ),
                            regPage[pageIndex],
                            Align(
                              child: ButtonWithText(
                                width: width(context) * 0.8,
                                title: pageIndex == 4 ? 'Submit' : 'Next',
                                onPressed: () {
                                  // showSubmit = true;
                                  if (pageIndex == 4) {
                                    if (isChecked) {
                                      // data submit;
                                      setState(() {
                                        showSubmit = true;
                                      });
                                    } else {
                                      showToast(
                                        'Please accept the terms and conditions',
                                        context,
                                      );
                                    }
                                  } else {
                                    setState(() {
                                      if (pageIndex == 0 &&
                                          (businessNameController
                                                  .text
                                                  .isEmpty ||
                                              contactNameController
                                                  .text
                                                  .isEmpty ||
                                              contactNumberController
                                                  .text
                                                  .isEmpty ||
                                              emailController.text.isEmpty ||
                                              optionalContactNumberController
                                                  .text
                                                  .isEmpty ||
                                              addressController.text.isEmpty ||
                                              districtController.text.isEmpty ||
                                              townController.text.isEmpty ||
                                              languageController.text.isEmpty ||
                                              aAndGstController.text.isEmpty ||
                                              holderNameController
                                                  .text
                                                  .isEmpty ||
                                              holderNumberController
                                                  .text
                                                  .isEmpty ||
                                              ifscController.text.isEmpty ||
                                              bankNameController
                                                  .text
                                                  .isEmpty)) {
                                        showToast(
                                          'Please fill all the field!',
                                          context,
                                        );
                                      } else if (pageIndex == 1 &&
                                          !(serviceValues['Transplanter Operator'] ==
                                                  true ||
                                              serviceValues['Transplanter Owner'] ==
                                                  true ||
                                              serviceValues['Nursery Mat Supplier'] ==
                                                  true ||
                                              serviceValues['Sand Nursery Maker'] ==
                                                  true ||
                                              serviceValues['Drone Services Provider'] ==
                                                  true ||
                                              serviceValues['Straw Baler Owner'] ==
                                                  true ||
                                              serviceValues['Paddy Grain Merchant'] ==
                                                  true ||
                                              serviceValues['Labour Provider'] ==
                                                  true ||
                                              serviceValues['Aana Sakthi'] ==
                                                  true)) {
                                        showToast(
                                          'Select atleast one',
                                          context,
                                        );
                                      }
                                      else if (pageIndex == 2) {
                                        bool show = false;
                                        if ((serviceValues['Transplanter Operator'] ==
                                                    true ||
                                                serviceValues['Transplanter Owner'] ==
                                                    true) &&
                                            ((transPlanterOwnership ?? '')
                                                    .isEmpty ||
                                                (provideTractor ?? '')
                                                    .isEmpty ||
                                                modelController.text.isEmpty ||
                                                yearOfPController
                                                    .text
                                                    .isEmpty ||
                                                perDayAreaController
                                                    .text
                                                    .isEmpty ||
                                                ratePerAcreController
                                                    .text
                                                    .isEmpty)) {
                                          show = true;
                                        }
                                        if (serviceValues['Nursery Mat Supplier'] ==
                                                true &&
                                            (quantityDayController
                                                    .text
                                                    .isEmpty ||
                                                nurseryLocationController
                                                    .text
                                                    .isEmpty ||
                                                leadTimeController
                                                    .text
                                                    .isEmpty ||
                                                ratePerMatController
                                                    .text
                                                    .isEmpty)) {
                                          show = true;
                                        }
                                        if (serviceValues['Sand Nursery Maker'] ==
                                                true &&
                                            (areaOfOperationController
                                                    .text
                                                    .isEmpty ||
                                                teamSizeController
                                                    .text
                                                    .isEmpty ||
                                                sourceOfSoilController
                                                    .text
                                                    .isEmpty ||
                                                setUpCostController
                                                    .text
                                                    .isEmpty ||
                                                capacityController
                                                    .text
                                                    .isEmpty)) {
                                          show = true;
                                        }
                                        if (serviceValues['Drone Services Provider'] ==
                                                true &&
                                            (droneMakeModelController
                                                    .text
                                                    .isEmpty ||
                                                (permissionLicense ?? '')
                                                    .isEmpty ||
                                                areaCoveredController
                                                    .text
                                                    .isEmpty ||
                                                rateAcreController
                                                    .text
                                                    .isEmpty ||
                                                !(servicesOffered['Spraying'] ==
                                                        true ||
                                                    servicesOffered['Mapping'] ==
                                                        true))) {
                                          show = true;
                                        }
                                        if (serviceValues['Straw Baler Owner'] ==
                                                true &&
                                            ((baleType ?? '').isEmpty ||
                                                baleSizeAndWeightController
                                                    .text
                                                    .isEmpty ||
                                                ratePerBaleController
                                                    .text
                                                    .isEmpty ||
                                                (transportAvailable ?? '')
                                                    .isEmpty)) {
                                          show = true;
                                        }
                                        if (serviceValues['Paddy Grain Merchant'] ==
                                                true &&
                                            (purchaseCenterLocationController
                                                    .text
                                                    .isEmpty ||
                                                qualityAcceptsController
                                                    .text
                                                    .isEmpty ||
                                                paddyVarietiesController
                                                    .text
                                                    .isEmpty ||
                                                priceRangeController
                                                    .text
                                                    .isEmpty ||
                                                paymentTimelineController
                                                    .text
                                                    .isEmpty)) {
                                          show = true;
                                        }
                                        if (serviceValues['Labor Provider'] ==
                                                true &&
                                            (lpNameController.text.isEmpty ||
                                                lpFatherNameController
                                                    .text
                                                    .isEmpty ||
                                                lpContactNumberController
                                                    .text
                                                    .isEmpty ||
                                                lpVillageController
                                                    .text
                                                    .isEmpty ||
                                                lpDistrictController
                                                    .text
                                                    .isEmpty ||
                                                lpTalukController.text.isEmpty ||
                                                lpDistrictController
                                                    .text
                                                    .isEmpty ||
                                                lpMenFareController
                                                    .text
                                                    .isEmpty ||
                                                lpFemaleFareController
                                                    .text
                                                    .isEmpty
                                            )) {
                                          show = true;
                                        }
                                        if (serviceValues['Aana Sakthi'] ==
                                                true &&
                                            ((typeAana ?? '').isEmpty ||
                                                productYouCanSellController
                                                    .text
                                                    .isEmpty ||
                                                monthlyVolumeController
                                                    .text
                                                    .isEmpty ||
                                                villageCoverController
                                                    .text
                                                    .isEmpty ||
                                                (stockAana ?? '').isEmpty)) {
                                          show = true;
                                        }
                                        if (show) {
                                          showToast(
                                            'Please fill the form',
                                            context,
                                          );
                                        } else {
                                          pageIndex++;
                                        }
                                      // } else if (pageIndex == 3 ) {
                                      //   showToast('All Files need', context);
                                      }
                                      else if(pageIndex == 3) {
                                        print(selectedImageFiles);
                                        if(selectedImageFiles.isEmpty) {
                                          showToast('Please upload image', context);
                                          return;
                                        }
                                        for(var i in selectedImageFiles.entries) {
                                          if(i.value == null) {
                                            showToast('Please upload ${i.key} image', context);
                                            return;
                                          }
                                        }
                                        pageIndex++;
                                      } else if (pageIndex == 4){
                                          setState(() {
                                            showSubmit = true;
                                          });
                                      }
                                      else {

                                        print(serviceValues);
                                        print(serviceValues['Labour Provider']);
                                        pageIndex++;
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showSubmit,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showSubmit = false;
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
            Visibility(visible: showSubmit, child: _submit()),
            Visibility(visible:onLoad ,child: MyLoader()),
          ],
        ),
      ),
    );
  }

  Widget _submit() {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 18, left: 18),
      padding: EdgeInsets.all(18),
      width: width(context) * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RobotoText(title: appName, size: 24),
            LatoText(
              title:
                  'The admin will contact you soon, it will take some time. Kindly, wait a moment.',
              size: 14,
              lineHeight: 3,
            ),
            LatoText(
              title:
                  'Press submit to confirm your registration as a vendor.',
              size: 12,
              lineHeight: 3,
            ),
            ButtonWithText(
              title: 'Submit',
              width: width(context),
              onPressed: () async {
                setState(() {
                  onLoad = true;
                });
                final data  = await makeRegData(context);
                if(data['document'].isEmpty) {
                  showToast('Try again Later!', context);
                  setState(() {
                    onLoad = false;
                  });
                  return;
                }
                bool status = await Database().requestForVendor(data);
                if(status)  {
                  final vendorName = data['userDetails'];
                  AppNotification().send(adminId, 'Vendor Request', '${vendorName['businessName']} has applied to become a vendor.', 'vendorRequest');
                  showToast('Registration successful', context);
                  Navigator.of(context).pop(true);
                } else {
                  showToast('Something went wrong, try again later', context);
                }
                setState(() {
                  onLoad = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
