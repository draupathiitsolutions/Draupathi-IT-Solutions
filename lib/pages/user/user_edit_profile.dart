import 'package:flutter/material.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/button.dart';
import '../../widget/inputField.dart';
import '../../widget/staff.dart';
import '../../widget/text.dart';

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({super.key});

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  TextEditingController locationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool onLoad = false;
  String languageSelected = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      locationController = TextEditingController(text: profile['address']);
      nameController = TextEditingController(text: profile['name']);
      languageSelected = profile['language'] ?? 'English';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RobotoText(title: 'Edit Profile',size: 24,),
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,

      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(

              children: [
                SizedBox(height: 16),
                TextFieldWithIcon(
                  controller: nameController,
                  hintText: 'Name',
                  icons: Icons.person_2_rounded,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 12),
                TextFieldWithIcon(
                  controller: locationController,
                  hintText: 'Address',
                  icons: Icons.location_on_rounded,
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: LatoText(title: 'Language', size: 12, lineHeight: 1),
                    ),
                    RadioListTile<String>(
                      title: Text('English'),
                      value: 'English',
                      groupValue: languageSelected,
                      onChanged: (String? value) {
                        setState(() {
                          languageSelected = value?? 'English';
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('தமிழ்'),
                      value: 'தமிழ்',
                      groupValue: languageSelected,
                      onChanged: (String? value) {
                        setState(() {
                          languageSelected = value ?? 'தமிழ்';
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('తెలుగు') ,
                      value: 'తెలుగు',
                      groupValue: languageSelected,
                      onChanged: (String? value) {
                        setState(() {
                          languageSelected = value?? 'తెలుగు';
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ButtonWithText(
                  onPressed: () async {
                    setState(() {
                      onLoad = true;
                    });
                    if (nameController.text.isEmpty ||
                        locationController.text.isEmpty) {
                      showToast('Please fill all the fields', context);
                      setState(() {
                        onLoad = false;
                      });
                      return;
                    }
                    bool status = await Database().updateProfile({
                      'name':   nameController.text,
                      'address': locationController.text,
                      'language': languageSelected,
                    });
                    if(status) {
                      final data = await Database().getProfile();
                      showToast(languageSelected == language ? 'Profile Updated':'Restart The App!', context);
                      setState(() {
                        profile = data;
                        language = data['language'] ?? 'English';
                      });
                      Navigator.pop(context);
                    } else {
                      showToast('Unable to update profile', context);
                    }
                    setState(() {
                      onLoad = false;
                    });
                  },
                  title: 'Update Profile', width: width(context),
                ),
              ],
            ),
          ),
          Visibility(visible: onLoad,child: MyLoader()),
        ],
      ),
    );
  }
}
