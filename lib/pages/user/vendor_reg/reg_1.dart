import 'package:flutter/material.dart';

import '../../../function/appFunction.dart';
import '../../../widget/inputField.dart';
import '../../../widget/text.dart';

class Reg1 extends StatefulWidget {
  const Reg1({super.key});

  @override
  State<Reg1> createState() => _Reg1State();
}

class _Reg1State extends State<Reg1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: RobotoText(
            title: 'Register as vendor',
            size: 16,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextFieldWithIcon(controller: businessNameController, hintText: 'Business Name', icons: Icons.business_sharp, keyboardType: TextInputType.name),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: contactNameController, hintText: 'Contact Person', icons: Icons.person, keyboardType: TextInputType.name),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: contactNumberController, hintText: 'Mobile Number', icons: Icons.phone_android, keyboardType: TextInputType.number),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: optionalContactNumberController, hintText: 'Alternate Number', icons: Icons.phone_android, keyboardType: TextInputType.number),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: emailController, hintText: 'Email ID', icons: Icons.email, keyboardType: TextInputType.emailAddress),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: addressController, hintText: 'Address with Pincode', icons: Icons.location_on, keyboardType: TextInputType.multiline),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: districtController, hintText: 'District & State', icons: Icons.location_city, keyboardType: TextInputType.streetAddress),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: townController, hintText: 'Village & Town', icons: Icons.location_city, keyboardType: TextInputType.streetAddress),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: languageController, hintText: "Preferred Language", icons: Icons.language, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: aAndGstController, hintText: "Aadhaar or GST Number", icons: Icons.assignment_ind_rounded, keyboardType: TextInputType.number),
        SizedBox(
          height: 12,
        ),
        RobotoText(
          title: 'Bank Details',
          size: 14,
        ),
        SizedBox(
          height: 12,
        ),
        TextFieldWithIcon(controller: bankNameController, hintText: "Bank Name", icons: Icons.account_balance, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),TextFieldWithIcon(controller: holderNameController, hintText: 'Account Holder Name', icons: Icons.account_box, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: holderNumberController, hintText: 'Account Number', icons: Icons.payment, keyboardType: TextInputType.text),
        SizedBox(
          height: 8,
        ),
        TextFieldWithIcon(controller: ifscController, hintText: 'IFSC Code', icons: Icons.location_city, keyboardType: TextInputType.text),


        SizedBox(height: 16,),
      ],
    );
  }
}
