import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/pages/user/vendor_reg/reg_2.dart';
import 'package:riceking/pages/vendor/modify_service.dart';
import 'package:riceking/widget/text.dart';

import '../../function/appFunction.dart';
import '../../widget/button.dart';
import '../../widget/inputField.dart';
import '../../widget/staff.dart';

class EditVendorProfile extends StatefulWidget {
  final Map<String, dynamic> data;
  const EditVendorProfile({super.key, required this.data});

  @override
  State<EditVendorProfile> createState() => _EditVendorProfileState();
}

class _EditVendorProfileState extends State<EditVendorProfile> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  String imageUrl = '';
  List<dynamic> searchKeyword = [];
  bool onShow = false;

  bool onLoad = false;
  XFile? imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      companyNameController = TextEditingController(
        text: widget.data['companyName'],
      );
      descriptionController = TextEditingController(
        text: widget.data['description'],
      );
      imageUrl =
          widget.data['companyUrl'] ??
          'https://firebasestorage.googleapis.com/v0/b/aana-crop-solution.firebasestorage.app/o/app_reference%2Fbanner.png?alt=media&token=10c309ac-fb60-483a-95d1-6c937c815ef0';
      searchKeyword = widget.data['searchKeyword'] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RobotoText(title: 'Edit Profile', size: 24),
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                SizedBox(height: 16),
                TextFieldWithIcon(
                  controller: companyNameController,
                  hintText: 'Company Name',
                  icons: Icons.business,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 12),
                TextFieldWithIcon(
                  controller: descriptionController,
                  hintText: 'Description',
                  icons: Icons.segment_rounded,
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(height: 18,),
                GestureDetector(
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    spacing: 8,
                    children: [
                      LatoText(title: 'Change Banner', size: 16, lineHeight: 1),
                      Icon(Icons.image,color: Theme.of(context).colorScheme.tertiary,size: 16,)
                    ],
                  ),
                ),
                SizedBox(height: 16),
                RobotoText(title: 'Search Keyword', size: 18),
                SizedBox(height: 8),
                _userFilter(),
                ButtonWithText(
                  onPressed: () async {
                    setState(() {
                      onLoad = true;
                      FocusScope.of(context).unfocus();
                    });
                    if (imageFile != null) {
                      final data = await Database().uploadDocument(
                        {'banner': imageFile},
                        widget.data['id'],
                        context,
                      );
                      setState(() {
                        imageUrl = data['banner'] ?? imageUrl;
                      });
                    }
                    bool status = await Database().editVendor(
                      {
                        'companyName': companyNameController.text,
                        'description': descriptionController.text,
                        'searchKeyword': searchKeyword,
                        'companyUrl': imageUrl,
                      },
                      widget.data['id'],
                      context,
                    );
                    if(status) {
                      Navigator.pop(context, true);
                      showToast('Vendor updated', context);
                    } else {
                      showToast('Something went wrong', context);
                    }
                    setState(() {
                      onLoad = false;
                    });
                  },
                  title: 'Update Profile',
                  width: width(context),
                ),
                SizedBox(height: 12,),
                ButtonWithText(title: 'Modify Service', onPressed: () async {
                  bool status = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifyService(id: widget.data['id'], service: widget.data['companyServices'] ?? [],serviceDetails: widget.data['businessDetails'],
                      ) ),

                  );
                  if(status) {
                    Navigator.pop(context,true);
                  }

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const Reg2()),
                  // );
                }, width: width(context))
              ],
            ),
          ),
          Visibility(visible: onLoad, child: MyLoader()),
        ],
      ),
    );
  }

  Widget _userFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RobotoText(title: 'Other', size: 14),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: searchKeyword.length,
            itemBuilder: (context, index) {
              if (searchKeyword[index].toString().isEmpty) {
                return SizedBox();
              }
              return _otherFields(searchKeyword[index], index);
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 8, top: 4, left: 8),
              height: 50,
              width: width(context) * 0.9,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.75,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: TextField(
                controller: otherController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                style: GoogleFonts.lato(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                cursorColor: Theme.of(context).colorScheme.tertiary,
                decoration: InputDecoration(
                  hintText: 'Pin code, Location, Name..',
                  hintStyle: GoogleFonts.openSans(
                    color: Theme.of(
                      context,
                    ).colorScheme.tertiary.withOpacity(0.5),
                  ),
                  suffixIcon: IconAsButton(
                    icon: Icons.add,
                    onPressed: () {
                      setState(() {
                        if (!searchKeyword.contains(otherController.text)) {
                          searchKeyword.add(otherController.text);
                        }
                        otherController.clear();
                      });
                    },
                    size: 18,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              onShow = !onShow;
            });
          },
          child: Row(
            spacing: 10,
            children: [
              LatoText(title: 'Show Keyword', size: 12, lineHeight: 1),
              Icon(
                onShow ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                size: 18,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ],
          ),
        ),
        Visibility(
          visible: onShow,
          child: Column(
            children: [
              RobotoText(title: 'By Service', size: 14),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _filterFields('Transplanter Operator'),
                    _filterFields('Transplanter Owner'),
                  ],
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _filterFields('Sand Nursery Maker'),
                    _filterFields('Nursery Mat Supplier'),
                  ],
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _filterFields('Straw Baler Owner'),
                    _filterFields('Drone Services Provider'),
                  ],
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _filterFields('Paddy Grain Merchant'),
                    _filterFields('Labour Provider'),
                    _filterFields('Aana Sakthi'),
                  ],
                ),
              ),
              SizedBox(height: 12),
              RobotoText(title: 'By Price', size: 14),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _filterFields('below 1k'),
                    _filterFields('1k-2k'),
                    _filterFields('2k-3k'),
                  ],
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _filterFields('3k-4k'),
                    _filterFields('4k-5k'),
                    _filterFields('above 5k'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18),
      ],
    );
  }

  Widget _filterFields(String key) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!searchKeyword.contains(key)) {
            searchKeyword.add(key);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        margin: EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color:
              filterUser[key] ?? false
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(45),
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: LatoText(title: key, size: 12, lineHeight: 1),
      ),
    );
  }

  Widget _otherFields(String key, int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      margin: EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color:
            filterUser[key] ?? false
                ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(45),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          LatoText(title: key, size: 12, lineHeight: 1),
          GestureDetector(
            onTap: () {
              setState(() {
                searchKeyword.remove(key);
              });
            },
            child: Icon(Icons.clear, size: 16),
          ),
        ],
      ),
    );
  }

  Future<void> getImage(ImageSource source) async {

    final ImagePicker picker = ImagePicker();
    final XFile? data = await picker.pickImage(source: source);

    if (data != null) {
      setState(() {
        imageFile = data;
      });
      showToast('Banner image selected!',context);
    } else {
      showToast('No image selected for Banner.',context);
    }
  }

}
