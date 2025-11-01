import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../function/appFunction.dart';

class TextFieldWithIcon extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icons;
  final TextInputType keyboardType;
  final int length;
  const TextFieldWithIcon(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.icons,
      required this.keyboardType,this.length = 1});

  @override
  State<TextFieldWithIcon> createState() => _TextFieldWithIconState();
}

class _TextFieldWithIconState extends State<TextFieldWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      height: 50,
      width: width(context) * 0.8,
      alignment: Alignment(0, 0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.75,
            color: Theme.of(context).colorScheme.primary,
          )),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        maxLines: widget.length,
        style: GoogleFonts.lato(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        cursorColor: Theme.of(context).colorScheme.tertiary,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.openSans(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
          ),
          prefixIcon: Icon(
            widget.icons,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class OTPField extends StatefulWidget {
  final TextEditingController controller;

  const OTPField({super.key, required this.controller});

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      autofocus: true,
      length: 6,
      controller: widget.controller,
      onCompleted: (pin) {
        setState(() {
          inputOtp = pin;
        });
      },
      defaultPinTheme: PinTheme(
        height: 40,
        width: 40,
        textStyle: GoogleFonts.lato(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 14,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              width: 0.75,
              color: Theme.of(context).colorScheme.primary,
            )),
      ),
    );
  }
}

class TextFieldForMsg extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icons;
  final TextInputType keyboardType;
  final Function onPressed;

  const TextFieldForMsg({super.key, required this.controller,
  required this.hintText,
  required this.icons,
  required this.keyboardType, required this.onPressed});

  @override
  State<TextFieldForMsg> createState() => _TextFieldForMsgState();
}

class _TextFieldForMsgState extends State<TextFieldForMsg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( left: 12,top: 4, bottom: 4),
      height: 50,
      width: width(context),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
          border: Border.all(
            width: 0.75,
            color: Theme.of(context).colorScheme.primary,
          )),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        style: GoogleFonts.lato(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        cursorColor: Theme.of(context).colorScheme.tertiary,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.openSans(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              widget.onPressed();
            },
            child: Icon(
              widget.icons,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

