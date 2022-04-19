import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/Dashboard.dart';
import 'package:skep_home_pro/MyBooking/complete_details.dart';
import 'package:skep_home_pro/controllers/chat_controller.dart';

import '../controllers/request_details_controller.dart';
import '../notification/notification.dart';
import 'messages.dart';

class chatpage extends StatefulWidget {
  String email;
  chatpage({required this.email});
  @override
  _chatpageState createState() => _chatpageState(email: email);
}

class _chatpageState extends State<chatpage> {
  String email;
  _chatpageState({required this.email});

  final fs = FirebaseFirestore.instance;
  final TextEditingController message = new TextEditingController();


  final FCMNotificationService _fcmNotificationService = FCMNotificationService();
  String _otherDeviceToken="";


  @override
  void initState() {
    super.initState();


    //Subscribe to the NEWS topic.
    _fcmNotificationService.subscribeToTopic(topic: 'NEWS');
    _otherDeviceToken = FcmTokenOwner;
    print("<<<<<<<<<<<<<<<<<<<<<<${_otherDeviceToken}");
  }




  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestDetailsController>(
      init: RequestDetailsController(),
      builder: (controller)=> Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Image.asset("assets/images/ring.png"),
              onPressed: () {
                // do something
              },
            )
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Center(
            child: Text(
              "Chat With us",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.79,
                child: messages(),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Write your message…',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {

                      },
                      onSaved: (value) {
                        message.text = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: CircleAvatar(
                      child: IconButton(
                        onPressed: ()async {
                          try {
                            await _fcmNotificationService.sendNotificationToUser(
                              title: '${FirstName}',
                              body: message.text,
                              fcmToken: "cRqRIFe4QDee7l1pi_2FNP:APA91bGthCV2BViH_-j02qCuXMzzEJldzh0sz5BcOhYfDDhE4dGfkQN6Hmm9KM14UfQCSRGtl7bzp2-yJs9HoNHR_Xwq8WJ1ieB7tJ5ASRtQIPL5QwhnMkGaEKaGda7UkUDEO9EIRvIY",
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error, ${e.toString()}.'),
                              ),
                            );
                          }
                          if (message.text.isNotEmpty) {
                            fs.collection('Messages').doc().set({
                              'message': message.text.trim(),
                              'time': DateTime.now(),
                              'email': email,
                            });
                            controller.send(message.text);
                            message.clear();
                          }
                        },
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}