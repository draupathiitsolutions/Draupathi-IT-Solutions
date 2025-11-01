import 'package:flutter/material.dart';
import 'package:riceking/function/appFunction.dart';

import '../../../widget/text.dart';

class Reg5 extends StatefulWidget {
  const Reg5({super.key});

  @override
  State<Reg5> createState() => _Reg5State();
}

class _Reg5State extends State<Reg5> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          child: RobotoText(
            title: appName,
            size: 38,
          ),
        ),
        SizedBox(
          height: 18,
        ),
        LatoText(title: 'I  confirm that all information given above is true. I agree to follow Aana Crop Solution\'s quality and service standards.', size: 14, lineHeight: 3),
        SizedBox(height: 12,),
        CheckboxListTile(
          title: LatoText(title: 'I agree!', size: 12, lineHeight: 1),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),SizedBox(height: 12),
      ],
    );
  }
}
