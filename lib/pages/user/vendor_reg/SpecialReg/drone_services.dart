import 'package:flutter/material.dart';

import '../../../../function/appFunction.dart';
import '../../../../widget/inputField.dart';
import '../../../../widget/text.dart';

class DroneServices extends StatefulWidget {
  const DroneServices({super.key});

  @override
  State<DroneServices> createState() => _DroneServicesState();
}

class _DroneServicesState extends State<DroneServices> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RobotoText(title : 'Drone Services Provider', size: 14),
        SizedBox(height: 8,),
        TextFieldWithIcon(controller: droneMakeModelController, hintText: 'Drone make & model ', icons: Icons.location_on, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: LatoText(title: 'Do you have permission/license?', size: 12, lineHeight: 1),
            ),
            RadioListTile<String>(
              title: const Text('Yes'),
              value: 'yes',
              groupValue: permissionLicense,
              onChanged: (String? value) {
                setState(() {
                  permissionLicense = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('No'),
              value: 'no',
              groupValue: permissionLicense,
              onChanged: (String? value) {
                setState(() {
                  permissionLicense = value;
                });
              },
            ),
          ],
        ),TextFieldWithIcon(controller: areaCoveredController, hintText: 'Area covered/day', icons: Icons.group, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: rateAcreController, hintText: 'Rate/acre', icons: Icons.terrain, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: LatoText(title: 'Services offered', size: 12, lineHeight: 1),
        ),

        Column(
          children: servicesOffered.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: servicesOffered[key],
              onChanged: (bool? value) {
                setState(() {
                  servicesOffered[key] = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }).toList(),
        ),SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
