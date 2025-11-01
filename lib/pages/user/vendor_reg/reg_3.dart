import 'package:flutter/material.dart';
import 'package:riceking/pages/user/vendor_reg/SpecialReg/aana_sakthi.dart';
import 'package:riceking/pages/user/vendor_reg/SpecialReg/drone_services.dart';
import 'package:riceking/pages/user/vendor_reg/SpecialReg/nursery_mat.dart';
import 'package:riceking/pages/user/vendor_reg/SpecialReg/paddy_grain.dart';
import 'package:riceking/pages/user/vendor_reg/SpecialReg/sand_nursery.dart';
import 'package:riceking/pages/user/vendor_reg/SpecialReg/straw_baler.dart';
import 'package:riceking/pages/user/vendor_reg/SpecialReg/transplanter.dart';
import 'package:riceking/widget/inputField.dart';
import 'package:riceking/widget/text.dart';

import '../../../function/appFunction.dart';
import 'SpecialReg/labor_provider.dart';

class Reg3 extends StatefulWidget {
  const Reg3({super.key});

  @override
  State<Reg3> createState() => _Reg3State();
}

class _Reg3State extends State<Reg3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: RobotoText(
            title: 'Service Info',
            size: 16,
          ),
        ),
        SizedBox(height: 18),
        Visibility(visible: (serviceValues[ 'Transplanter Operator']??false ) || (serviceValues['Transplanter Owner']??false),child: TransPlanter()),
        Visibility(visible:serviceValues['Nursery Mat Supplier']??false,child: NurseryMat()),
        Visibility(visible:serviceValues['Sand Nursery Maker']??false,child: SandNursery()),
        Visibility(visible:serviceValues['Drone Services Provider']??false,child: DroneServices()),
        Visibility(visible:serviceValues['Straw Baler Owner']??false,child: StrawBaler()),
        Visibility(visible:serviceValues[ 'Paddy Grain Merchant']??false,child: PaddyGrain()),
        Visibility(visible:serviceValues[ 'Labour Provider']??false,child: LaborProvider()),
        Visibility(visible:serviceValues['Aana Sakthi']??false,child: AanaSakthi()),
        SizedBox(height: 18),
      ],
    );
  }
}
