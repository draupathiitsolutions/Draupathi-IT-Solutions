import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riceking/function/appFunction.dart';
import 'package:image_picker/image_picker.dart';
import '../../../widget/text.dart';

class Reg4 extends StatefulWidget {
  const Reg4({super.key});

  @override
  State<Reg4> createState() => _Reg4State();
}

class _Reg4State extends State<Reg4> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          child: RobotoText(
            title: 'Upload Documents',
            size: 16,
          ),
        ),
        SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: LatoText(title: 'Aadhaar / ID Proof', size: 12, lineHeight: 1),
        ),
        GestureDetector(
          onTap: (){
            getImage(ImageSource.gallery,'aadher');
          },
          child: Container(
            margin: EdgeInsets.all(8),
            height: width(context)*0.5,
            width: width(context),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.75,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            child: showImage('aadher'),
          ),
        ),Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: LatoText(title: 'Bank Passbook', size: 12, lineHeight: 1),
        ),
        GestureDetector(
          onTap: (){
            getImage(ImageSource.gallery,'passbook');
          },
          child: Container(
            margin: EdgeInsets.all(8),
            height: width(context)*0.5,
            width: width(context),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.75,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            child: showImage('passbook'),
          ),
        ),Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: LatoText(title: 'Photo of Equipment / Setup', size: 12, lineHeight: 1),
        ),
        GestureDetector(
          onTap: (){
            getImage(ImageSource.gallery,'equipment');
          },
          child: Container(
            margin: EdgeInsets.all(8),
            height: width(context)*0.5,
            width: width(context),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.75,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            child: showImage('equipment'),
          ),
        ),Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: LatoText(title: 'Passport size photo', size: 12, lineHeight: 1),
        ),
        GestureDetector(
          onTap: (){
            getImage(ImageSource.gallery,'passportPhoto');
          },
          child: Container(
            margin: EdgeInsets.all(8),
            height: width(context)*0.5,
            width: width(context),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.75,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            child: showImage('passportPhoto'),
          ),
        ),
        SizedBox(height: 18),
      ],
    );
  }


  Future<void> getImage(ImageSource source,String imageType) async {

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        selectedImageFiles[imageType] = image;
      });
      showToast('$imageType image selected!',context);
    } else {
      showToast('No image selected for $imageType.',context);
    }
  }

  Widget showImage(String imageType) {
    if (selectedImageFiles[imageType] != null) {
      return Image.file(
        File(selectedImageFiles[imageType]!.path),
        height: 100,
        width: width(context),
        fit: BoxFit.fitHeight,
      );
    } else {
      return Icon(Icons.add, size: 24,color: Theme.of(context).colorScheme.tertiary,);
    }
  }

}
