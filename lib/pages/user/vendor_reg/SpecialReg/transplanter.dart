import 'package:flutter/material.dart';

import '../../../../function/appFunction.dart';
import '../../../../widget/inputField.dart';
import '../../../../widget/text.dart';

class TransPlanter extends StatefulWidget {
  const TransPlanter({super.key});

  @override
  State<TransPlanter> createState() => _TransPlanterState();
}

class _TransPlanterState extends State<TransPlanter> {
  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          RobotoText(title : 'Transplanter Operator / Owner', size: 14),
          SizedBox(height: 8,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment
            .start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: LatoText(title: 'Do you own a transplanter?', size: 12, lineHeight: 1),
              ),
              RadioListTile<String>(
                title: const Text('Yes'),
                value: 'yes',
                groupValue: transPlanterOwnership,
                onChanged: (String? value) {
                  setState(() {
                    transPlanterOwnership = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('No'),
                value: 'no',
                groupValue: transPlanterOwnership,
                onChanged: (String? value) {
                  setState(() {
                    transPlanterOwnership = value;
                  });
                },
              ),
            ],
          ),
          TextFieldWithIcon(controller: modelController, hintText: 'Model', icons: Icons.construction, keyboardType: TextInputType.text),
          SizedBox(
            height: 8,
          ),
          TextFieldWithIcon(controller: yearOfPController, hintText: 'Year of Purchase', icons: Icons.calendar_today, keyboardType: TextInputType.number),
          SizedBox(
            height: 8,
          ),
          TextFieldWithIcon(controller: perDayAreaController, hintText: 'Area Coverage per day', icons: Icons.area_chart, keyboardType: TextInputType.number),
          SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: LatoText(title: 'Do you provide tractor?', size: 12, lineHeight: 1),
              ),
              RadioListTile<String>(
                title: const Text('Yes'),
                value: 'yes',
                groupValue: provideTractor,
                onChanged: (String? value) {
                  setState(() {
                    provideTractor = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('No'),
                value: 'no',
                groupValue: provideTractor,
                onChanged: (String? value) {
                  setState(() {
                    provideTractor = value;
                  });
                },
              ),
            ],
          ),
          TextFieldWithIcon(controller: ratePerAcreController, hintText: 'Rate per Acre', icons: Icons.paid, keyboardType: TextInputType.number),
          SizedBox(height: 8,),
        ],
      );
  }
}
