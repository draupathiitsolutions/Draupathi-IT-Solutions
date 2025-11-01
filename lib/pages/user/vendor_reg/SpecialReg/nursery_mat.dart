import 'package:flutter/material.dart';

import '../../../../function/appFunction.dart';
import '../../../../widget/inputField.dart';
import '../../../../widget/text.dart';

class NurseryMat extends StatefulWidget {
  const NurseryMat({super.key});

  @override
  State<NurseryMat> createState() => _NurseryMatState();
}

class _NurseryMatState extends State<NurseryMat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RobotoText(title : 'Nursery Mat Supplier', size: 14),
        SizedBox(height: 8,),
        // TextFieldWithIcon(controller: typesOfNurseryController, hintText: 'Type of Nursery', icons: Icons.local_florist, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: quantityDayController, hintText: 'Quantity you can supply', icons: Icons.production_quantity_limits, keyboardType: TextInputType.number),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: nurseryLocationController, hintText: 'Nursery Location', icons: Icons.location_on, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: leadTimeController, hintText: 'Lead Time', icons: Icons.schedule, keyboardType: TextInputType.number),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: ratePerMatController, hintText: 'Rate per mat', icons: Icons.currency_rupee, keyboardType: TextInputType.number),
        SizedBox(height: 8,),
      ],
    );
  }
}
