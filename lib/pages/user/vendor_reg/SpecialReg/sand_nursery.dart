import 'package:flutter/material.dart';

import '../../../../function/appFunction.dart';
import '../../../../widget/inputField.dart';
import '../../../../widget/text.dart';

class SandNursery extends StatefulWidget {
  const SandNursery({super.key});

  @override
  State<SandNursery> createState() => _SandNurseryState();
}

class _SandNurseryState extends State<SandNursery> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RobotoText(title : 'Sand Nursery Maker', size: 14),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: areaOfOperationController, hintText: 'Area of Operation', icons: Icons.location_on, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: teamSizeController, hintText: 'Team Size', icons: Icons.group, keyboardType: TextInputType.number),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: sourceOfSoilController, hintText: 'Source of Sand/Soil', icons: Icons.terrain, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: setUpCostController, hintText: 'Setup Cost/Acre', icons: Icons.currency_rupee, keyboardType: TextInputType.number),
        SizedBox(
          height: 8,
        ), TextFieldWithIcon(controller: capacityController, hintText: 'Capacity per Month', icons: Icons.stacked_line_chart, keyboardType: TextInputType.number),
        SizedBox(height: 8,),
        ],
    );
  }
}
