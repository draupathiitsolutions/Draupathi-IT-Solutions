import 'package:flutter/material.dart';

import '../../../../function/appFunction.dart';
import '../../../../widget/inputField.dart';
import '../../../../widget/text.dart';

class StrawBaler extends StatefulWidget {
  const StrawBaler({super.key});

  @override
  State<StrawBaler> createState() => _StrawBalerState();
}

class _StrawBalerState extends State<StrawBaler> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RobotoText(title : 'Straw Baler Owner', size: 14),
        SizedBox(height: 8,),
        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: LatoText(title: 'Baler type', size: 12, lineHeight: 1),
            ),
            RadioListTile<String>(
              title: const Text('Round'),
              value: 'Round',
              groupValue: baleType,
              onChanged: (String? value) {
                setState(() {
                  baleType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Square'),
              value: 'Square',
              groupValue: baleType,
              onChanged: (String? value) {
                setState(() {
                  baleType = value;
                });
              },
            ),
          ],
        ),
        TextFieldWithIcon(
          controller: baleSizeAndWeightController,
          hintText: 'Bale size & weight ',
          icons: Icons.precision_manufacturing,
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 8,),TextFieldWithIcon(
          controller: ratePerBaleController,
          hintText: 'Rate per bale/acre',
          icons: Icons.currency_rupee,
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: LatoText(title: 'Transport available?', size: 12, lineHeight: 1),
            ),
            RadioListTile<String>(
              title: const Text('Yes'),
              value: 'yes',
              groupValue: transportAvailable,
              onChanged: (String? value) {
                setState(() {
                  transportAvailable = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('No'),
              value: 'no',
              groupValue: transportAvailable,
              onChanged: (String? value) {
                setState(() {
                  transportAvailable = value;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
