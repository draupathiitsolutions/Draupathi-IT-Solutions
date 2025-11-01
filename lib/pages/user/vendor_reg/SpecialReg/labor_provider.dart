import 'package:flutter/material.dart';

import '../../../../function/appFunction.dart';
import '../../../../widget/inputField.dart';
import '../../../../widget/text.dart';

class LaborProvider extends StatefulWidget {
  const LaborProvider({super.key});

  @override
  State<LaborProvider> createState() => _LaborProviderState();
}

class _LaborProviderState extends State<LaborProvider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RobotoText(title : 'Labours Provider', size: 14),
        SizedBox(height: 8,),
        TextFieldWithIcon(controller: lpNameController, hintText: 'Name', icons: Icons.person, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: lpFatherNameController, hintText: 'Father Name', icons: Icons.group, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: lpContactNumberController, hintText: 'Mobil No', icons: Icons.phone, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: LatoText(title: 'Work offered', size: 12, lineHeight: 1),
        ),
        Column(
          children: workOffered.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: workOffered[key],
              onChanged: (bool? value) {
                setState(() {
                  workOffered[key] = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }).toList(),
        ),SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: lpVillageController, hintText: 'Village', icons: Icons.place, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: lpTalukController, hintText: 'Taluk', icons: Icons.place, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: lpDistrictController, hintText: 'District', icons: Icons.place, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: lpMenFareController, hintText: 'Men Fare/day', icons: Icons.man, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: lpFemaleFareController, hintText: 'Women Fare/day', icons: Icons.woman, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: lpOtherController, hintText: 'Other', icons: Icons.add_circle_outline, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
