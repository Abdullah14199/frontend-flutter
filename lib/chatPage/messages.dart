import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/chat_model.dart';

import '../MyBooking/complete_details.dart';
import '../controllers/request_details_controller.dart';

class messages extends StatefulWidget {


  @override
  _messagesState createState() => _messagesState();
}

class _messagesState extends State<messages> {

  List lists=[];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestDetailsController>(
      init: RequestDetailsController(),
      builder: (controller) {
        return StreamBuilder(
          stream: FirebaseDatabase.instance
              .ref('chat_rooms')
              .child('${idBooking}')
              .orderByChild('time').onValue,
          builder: (context, snapshot) {
            List<ChatModel> messageList = [];
            if (snapshot.hasData &&
                snapshot.data != null &&
                (snapshot.data! as DatabaseEvent).snapshot.value !=
                    null) {
              final myMessages = Map<dynamic, dynamic>.from(
                  (snapshot.data! as DatabaseEvent).snapshot.value
                  as Map<dynamic, dynamic>); //typecasting
              myMessages.forEach((key, value) {
                final currentMessage = Map<String, dynamic>.from(value);
                messageList.add(ChatModel(
                  booking_id: currentMessage['booking_id'],
                  timeStamp: currentMessage['timeStamp'],
                  message: currentMessage['message'],
                  time: currentMessage['time'],));
              }); //created a class called message and added all messages in a List of class message
              // messageList.sort()
              // final dateTime = DateTime.now();
              messageList.sort((a, b) {
                int aDate = DateTime.parse(a.time ?? '').microsecondsSinceEpoch;
                int bDate = DateTime.parse(b.time ?? '').microsecondsSinceEpoch;
                return aDate.compareTo(bDate);
              });
              return ListView.builder(
                reverse: false,
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return builderMessageReceiver("${messageList[index].message}");
                },
              );
            } else {
              return Center(
                child: Text(
                  'Say Hi...',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w400),
                ),
              );
            }
          },
        );
      }
    );
  }
  Widget builderMessageSend(String message) => Align(
    alignment: AlignmentDirectional.topStart,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Container(
        child: Text(
          message,
          style: TextStyle(fontSize: 18.0),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      ),
    ),
  );

  Widget builderMessageReceiver(String message) => Align(
    alignment: AlignmentDirectional.bottomEnd,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Container(
        child: Text(
          message,
          style: TextStyle(fontSize: 16.0 , color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: constants.blue4,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            bottomStart: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      ),
    ),
  );
}

