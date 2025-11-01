import 'package:flutter/material.dart';

import '../../../../function/appFunction.dart';
import '../../../../widget/inputField.dart';
import '../../../../widget/text.dart';

class PaddyGrain extends StatefulWidget {
  const PaddyGrain({super.key});

  @override
  State<PaddyGrain> createState() => _PaddyGrainState();
}

class _PaddyGrainState extends State<PaddyGrain> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RobotoText(title : 'Paddy Grain Merchant', size: 14),
        SizedBox(height: 8,),
        TextFieldWithIcon(controller: purchaseCenterLocationController, hintText: 'Purchase center location', icons: Icons.location_on, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: qualityAcceptsController, hintText: 'Quantity accepted (kg or ton)', icons: Icons.line_weight, keyboardType: TextInputType.number),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: paddyVarietiesController, hintText: 'Paddy varieties preferred', icons: Icons.grass, keyboardType: TextInputType.multiline),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: priceRangeController, hintText: 'Price range offered', icons: Icons.currency_rupee, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: paymentTimelineController, hintText: 'Payment timeline', icons: Icons.calendar_today, keyboardType: TextInputType.number),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
