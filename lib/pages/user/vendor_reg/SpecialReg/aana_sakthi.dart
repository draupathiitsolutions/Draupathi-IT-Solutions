import 'package:flutter/material.dart';
import 'package:riceking/widget/inputField.dart';

import '../../../../function/appFunction.dart';
import '../../../../widget/text.dart';

class AanaSakthi extends StatefulWidget {
  const AanaSakthi({super.key});

  @override
  State<AanaSakthi> createState() => _AanaSakthiState();
}

class _AanaSakthiState extends State<AanaSakthi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RobotoText(title : 'Aana Sakthi', size: 14),
        SizedBox(height: 8,),
        Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: LatoText(title: 'Type', size: 12, lineHeight: 1),
            ),
            RadioListTile<String>(
              title: const Text('Shop'),
              value: 'shop',
              groupValue: typeAana,
              onChanged: (String? value) {
                setState(() {
                  typeAana = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Home-based'),
              value: 'home base',
              groupValue: typeAana,
              onChanged: (String? value) {
                setState(() {
                  typeAana = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Mobile Seller'),
              value: 'Mobile Seller',
              groupValue: typeAana,
              onChanged: (String? value) {
                setState(() {
                  typeAana = value;
                });
              },
            ),
          ],
        ),
        TextFieldWithIcon(controller: productYouCanSellController, hintText: 'Product you can sell', icons: Icons.production_quantity_limits, keyboardType: TextInputType.text),
        const SizedBox(height: 8),
        TextFieldWithIcon(controller: monthlyVolumeController, hintText: 'Monthly Volume Estimate', icons: Icons.calendar_today, keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        TextFieldWithIcon(controller: villageCoverController, hintText: 'Villages Covered', icons: Icons.holiday_village, keyboardType: TextInputType.multiline),
        const SizedBox(height: 8,),
        Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: LatoText(title: 'Willing to stock Aana Product?', size: 12, lineHeight: 1),
            ),
            RadioListTile<String>(
              title: const Text('Yes'),
              value: 'yes',
              groupValue: stockAana,
              onChanged: (String? value) {
                setState(() {
                  stockAana = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('No'),
              value: 'no',
              groupValue: stockAana,
              onChanged: (String? value) {
                setState(() {
                  stockAana = value;
                });
              },
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ],
    );
  }
}

