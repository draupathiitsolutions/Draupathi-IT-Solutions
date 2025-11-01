import 'package:flutter/material.dart';
import 'package:riceking/pages/vendor/add_service.dart';
import 'package:riceking/widget/button.dart';

import '../../function/appFunction.dart';
import '../../function/dataBaseFunction.dart';
import '../../widget/staff.dart';
import '../../widget/text.dart';

class ModifyService extends StatefulWidget {
  final String id;
  final List<dynamic> service;
  final List<dynamic> serviceDetails;
  const ModifyService({super.key, required this.id, required this.service, required this.serviceDetails});

  @override
  State<ModifyService> createState() => _ModifyServiceState();
}

class _ModifyServiceState extends State<ModifyService> {
  Map<String,bool> service = {
  }, reminderService = {};
  List<dynamic> ourService = ['Transplanter Operator',
    'Transplanter Owner',
    'Nursery Mat Supplier',
    'Sand Nursery Maker',
    'Drone Services Provider',
    'Straw Baler Owner',
    'Paddy Grain Merchant',
    'Labour Provider',
    'Aana Sakthi',];

  bool onLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for( var i in widget.service) {
      setState(() {
        service[i] = true;
      });
    }
    for(var i in ourService) {
      if(!widget.service.contains(i)) {
        reminderService[i] = false;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: RobotoText(title: 'Manage Service', size: 24),
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              height: height(context),
              width: width(context),
              child:
              ListView(
                children: [
                  // SizedBox(
                  //   width: width(context),
                  //   height: widget.service.length * 45,
                  //   child: ListView.builder(itemCount: widget.service.length,itemBuilder: (context,index) {return Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //     child: LatoText(title: widget.service[index], size: 18, lineHeight: 2),
                  //   );}),
                  // ),
                  RobotoText(title: 'Delete Service', size: 18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: service.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: service[key],
                        onChanged: (bool? value) {
                          setState(() {
          print(value);
                            service[key] = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 18),
                  ButtonWithText(title: 'Update', onPressed: ()async {
                    setState(() {
                      onLoad = true;
                    });
                    List<String> serviceList = [];
                    for( var i in service.keys) {
                      if(service[i] == true) {
                        serviceList.add(i);
                      }
                    }
                    if(serviceList.isEmpty) {
                      showToast('Any One service is need', context);
                    } else {
                    bool status = await Database().updateVendorService(widget.id, serviceList);
                    if(status) {
                      showToast('Service Removed!', context);
                      Navigator.pop(context,true);
                    } else  {
                      showToast('Something went wrong', context);
                    }}
                    setState(() {
                      onLoad = false;
                    });
                  }, width: width(context)),
                  SizedBox(height: 18,),
                  Visibility(
                    visible: widget.service.length != 9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RobotoText(title: 'Add Service', size: 18),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: reminderService.keys.map((String key) {
                            return CheckboxListTile(
                              title: Text(key),
                              value: reminderService[key],
                              onChanged: (bool? value) {
                                setState(() {
                                  print(value);
                                  reminderService[key] = value!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 18,),
                        ButtonWithText(title: 'Next', onPressed: () async {
                          bool ok = false;
                          for(var i in reminderService.keys) {
                            if(reminderService[i]??false) {
                              ok = true;
                              break;
                            }
                          }
                          if(ok) {
                            bool status = await 
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddService(service: reminderService, oldService: widget.service, oldDetails: widget.serviceDetails, id: widget.id,)),
                            );
                            if(status) {

                              Navigator.pop(context,true);
                            } else  {
                              showToast('Something went wrong', context);
                            }
                          } else {
                            showToast('Select the service', context);
                          }
                        }, width: width(context)),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),

          Visibility(visible: onLoad, child: MyLoader()),
        ],
      ),
    );
  }
}
