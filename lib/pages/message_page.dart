import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:googleapis/analyticsreporting/v4.dart';
import 'package:riceking/function/appFunction.dart';
import 'package:riceking/function/dataBaseFunction.dart';
import 'package:riceking/pages/admin/admin_report.dart';
import 'package:riceking/pages/user/user_setting_page.dart';
import 'package:riceking/widget/inputField.dart';

import '../widget/button.dart';
import '../widget/report.dart';
import '../widget/text.dart';

class MessagePage extends StatefulWidget {
  final String vendorId;
  final String userId;
  final bool isUser;
  final String phone;
  const MessagePage({
    super.key,
    required this.vendorId,
    required this.userId,
    required this.isUser,
    this.phone = ''
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController msgController = TextEditingController();
  String msgId = '';bool onDelete = false;
  @override
  Widget build(BuildContext context) {
    print(widget.phone);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(

        title: RobotoText(title: widget.isUser ? 'Former' : 'Vendor', size: 20),
        elevation: 0,
        actions: [
          if(adminId != FirebaseAuth.instance.currentUser!.uid)
          IconAsButton(
            icon: Icons.help,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RiceKingReportPage(isUser: false,)),
              );
            },
            size: 24,
          ),
          if(adminId == FirebaseAuth.instance.currentUser!.uid)
          IconAsButton(icon: Icons.phone_in_talk_sharp, onPressed: (){
            makePhoneCall(widget.phone,context);
          }, size: 24),
          SizedBox(width: 12,),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: height(context),
          width: width(context),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: width(context),
                      child: StreamBuilder(
                        stream:
                            FirebaseFirestore.instance
                                .collection('communication')
                                .doc('${widget.vendorId}_${widget.userId}')
                                .collection('message').orderBy('msgId', descending: true)
                                .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return SizedBox();
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: SpinKitFadingCircle(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            );
                          }
                          final userData = snapshot.data?.docs ?? [];
                          return ListView.builder(
                            reverse: true,
                            itemCount: userData.length,
                            itemBuilder: (context, index) {
                              final user = userData[index];
                              final data = user.data();
                              return messageCard(data);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  TextFieldForMsg(
                    controller: msgController,
                    hintText: 'Message',
                    icons: Icons.send,
                    keyboardType: TextInputType.text,
                    onPressed: () {

                      Database().sendMessage(
                        widget.vendorId,
                        widget.userId,
                        msgController.text,
                        (widget.isUser)?'user':'vendor',
                      );
                      setState(() {
                        msgController.clear();
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                visible: onDelete,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      onDelete = false;
                    });
                  },

                  child: Container(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.15),
                    height: height(context),
                    width: width(context),
                    alignment: Alignment(0, 0),
                    child: Container(
                      height: 200,
                      padding: EdgeInsets.all(16),
                      width: width(context) * 0.8,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RobotoText(title: 'Delete msg', size: 24),
                          SizedBox(height: 20,),
                          LatoText(
                            title:
                            'Do You want to Delete',
                            size: 14,
                            lineHeight: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonWithText(title: 'Delete', onPressed: () async {
                            setState(() {
                              onDelete = false;
                            });
                            await Database().deleteMsg(msgId,widget.vendorId);
                          }, width: width(context)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget messageCard(Map<String, dynamic> data) {
    bool isRight = widget.isUser
        ? data['messageBy'] == 'user'
        : data['messageBy'] == 'vendor';
    print(isRight);
    return GestureDetector(
      onLongPress: (){
        setState(() {
          onDelete = true;
          msgId = data['msgId'];
        });
      },
      child: Column(
        crossAxisAlignment: isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: isRight ? 50 :16,
              right: isRight ? 16 : 50,
              top: 5,
              bottom: 5,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
            decoration: BoxDecoration(
              color: isRight
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.7)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: isRight ? const Radius.circular(12) : Radius.zero,
                bottomRight: isRight ? Radius.zero : const Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: isRight? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                LatoText(
                  title: data['message'],
                  size: 16,
                  lineHeight: data['message'].length < 10? 2: (data['message'].length/10).toInt(),
                  color: isRight ? Colors.white: Theme.of(context).colorScheme.tertiary,
                ),
                LatoText(
                  title: data['time'],
                  size: 12,
                  lineHeight: 1,
                  color: isRight ? Colors.white: Theme.of(context).colorScheme.tertiary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
