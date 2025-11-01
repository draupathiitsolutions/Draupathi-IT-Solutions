import 'package:flutter/material.dart';

import '../../../function/appFunction.dart';
import '../../../widget/text.dart';

class Reg2 extends StatefulWidget {
  const Reg2({super.key});

  @override
  State<Reg2> createState() => _Reg2State();
}

class _Reg2State extends State<Reg2> {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: RobotoText(
            title: 'Select your services',
            size: 16,
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Column(
          children: serviceValues.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: serviceValues[key],
              onChanged: (bool? value) {
                setState(() {
                  serviceValues[key] = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }).toList(),
        ),
        SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
