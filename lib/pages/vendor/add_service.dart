import 'package:flutter/material.dart';
import 'package:riceking/function/appFunction.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/widget/button.dart';
import 'package:riceking/widget/staff.dart';

import '../../widget/text.dart';
import '../user/vendor_reg/SpecialReg/aana_sakthi.dart';
import '../user/vendor_reg/SpecialReg/drone_services.dart';
import '../user/vendor_reg/SpecialReg/labor_provider.dart';
import '../user/vendor_reg/SpecialReg/nursery_mat.dart';
import '../user/vendor_reg/SpecialReg/paddy_grain.dart';
import '../user/vendor_reg/SpecialReg/sand_nursery.dart';
import '../user/vendor_reg/SpecialReg/straw_baler.dart';
import '../user/vendor_reg/SpecialReg/transplanter.dart';

class AddService extends StatefulWidget {
  final String id;
  final Map<String,bool> service ;
  final List<dynamic> oldService;
  final List<dynamic> oldDetails;
  const AddService({super.key, required this.service, required this.oldService, required this.oldDetails, required this.id});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  bool onLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: RobotoText(
        title: 'Service Info',
        size: 16,
      ),),
      body: Stack(
        children: [
          Padding(padding: EdgeInsets.all(18),child: SizedBox(
            child: ListView(
              children: [
                Visibility(visible: (widget.service[ 'Transplanter Operator']??false ) || (widget.service['Transplanter Owner']??false),child: TransPlanter()),
                Visibility(visible:widget.service['Nursery Mat Supplier']??false,child: NurseryMat()),
                Visibility(visible:widget.service['Sand Nursery Maker']??false,child: SandNursery()),
                Visibility(visible:widget.service['Drone Services Provider']??false,child: DroneServices()),
                Visibility(visible:widget.service['Straw Baler Owner']??false,child: StrawBaler()),
                Visibility(visible:widget.service[ 'Paddy Grain Merchant']??false,child: PaddyGrain()),
                Visibility(visible:widget.service[ 'Labour Provider']??false,child: LaborProvider()),
                Visibility(visible:widget.service['Aana Sakthi']??false,child: AanaSakthi()),
                SizedBox(height: 18),
                ButtonWithText(title: 'Submit', onPressed: () async {
                  {
                    bool show = false;
                    if ((widget.service['Transplanter Operator'] ==
                        true ||
                        widget.service['Transplanter Owner'] ==
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
                    if (widget.service['Nursery Mat Supplier'] ==
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
                    if (widget.service['Sand Nursery Maker'] ==
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
                    if (widget.service['Drone Services Provider'] ==
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
                    if (widget.service['Straw Baler Owner'] ==
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
                    if (widget.service['Paddy Grain Merchant'] ==
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
                    if (widget.service['Labor Provider'] ==
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
                    if (widget.service['Aana Sakthi'] ==
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
                      final currentDetails = {
                        if(widget.service['Transplanter Operator'] ?? false){
                          'transplanter': {
                            'transPlanterOwnership' : transPlanterOwnership,
                            'provideTractor': provideTractor,
                            'model' : modelController.text,
                            'yearOfP' : yearOfPController.text,
                            'perDayArea' : perDayAreaController.text,
                            'ratePerAcre' : ratePerAcreController.text,
                          },},
                        if(widget.service['Transplanter Owner'] ?? false){
                          'transplanter': {
                            'transPlanterOwnership' : transPlanterOwnership,
                            'provideTractor': provideTractor,
                            'model' : modelController.text,
                            'yearOfP' : yearOfPController.text,
                            'perDayArea' : perDayAreaController.text,
                            'ratePerAcre' : ratePerAcreController.text,
                          },},

                        if(widget.service['Sand Nursery Maker'] ?? false) {
                          'Sand Nursery Maker': {
                            'areaOfOperation' : areaOfOperationController.text,
                            'teamSize' : teamSizeController.text,
                            'sourceOfSoil' : sourceOfSoilController.text,
                            'setUpCost' : setUpCostController.text,
                            'capacity' : capacityController.text,
                          },},
                        if(widget.service['Nursery Mat Supplier'] ?? false) {
                          'Nursery Mat Supplier':{
                            'quantityDay': quantityDayController.text,
                            'nurseryLocation': nurseryLocationController.text,
                            'leadTime': leadTimeController.text,
                            'ratePerMat': ratePerMatController.text,
                          },
                        },
                        if(widget.service['Drone Services Provider'] ?? false) {
                          'Drone Services Provider': {
                            'servicesOffered': servicesOffered,
                            'droneMakeModel': droneMakeModelController.text,
                            'areaCovered': areaCoveredController.text,
                            'rateAcre': rateAcreController.text,
                            'permissionLicense': permissionLicense,
                          },},
                        if(widget.service['Straw Baler Owner'] ?? false) {
                          'Straw Baler Owner' : {
                            'baleType' : baleType,
                            'baleSizeAndWeight' : baleSizeAndWeightController.text,
                            'ratePerBale' : ratePerBaleController.text,
                            'transportAvailable' : transportAvailable,
                          },
                        },
                        if(widget.service['Paddy Grain Merchant'] ?? false) {
                          'Paddy Grain Merchant': {
                            'purchaseCenterLocation' : purchaseCenterLocationController.text,
                            'qualityAccepts' : qualityAcceptsController.text,
                            'paddyVarieties' : paddyVarietiesController.text,
                            'priceRange' : priceRangeController.text,
                            'paymentTimeline' : paymentTimelineController.text,
                          },
                        },
                        if(widget.service['Labour Provider'] ?? false) {
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
                        if(widget.service['Aana Sakthi'] ?? false) {
                          'Aana Sakthi': {
                            'typeAana' : typeAana,
                            'productYouCanSell' : productYouCanSellController.text,
                            'monthlyVolume' : monthlyVolumeController.text,
                            'villageCover' : villageCoverController.text,
                            'stockAana' : stockAana,
                          },
                        },
                      };
                      setState(() {
                        onLoad = true;
                      });
                      // pageIndex++;
                      FocusScope.of(context).unfocus();
                      List<String> currentService = [];
                      widget.service.forEach((key, value) {
                        if(value) {
                        currentService.add(key);}
                      });
                      bool status = await Database().addServiceRequest(widget.id,currentService,currentDetails,widget.oldService,widget.oldDetails);
                      if(status) {
                        AppNotification().send(adminId, 'Update Service', 'Vendor need to extend there service.', '/adminPage');
                        showToast('Request Send', context);
                        Navigator.pop(context,true);
                      } else {
                        showToast('Something went wrong', context);
                      }
                      setState(() {
                        onLoad = false;
                      });
                    }
                  }
                }, width: width(context)),
              ],
            ),
          ),),
          Visibility(visible: onLoad,child: MyLoader()),
        ],
      ),
    );
  }
}
