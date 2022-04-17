import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/chat_model.dart';

import '../controllers/request_details_controller.dart';

class messages extends StatefulWidget {
  String email;
  messages({required this.email});

  @override
  _messagesState createState() => _messagesState(email: email);
}

class _messagesState extends State<messages> {
  String email;
  _messagesState({required this.email});

  Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('time')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestDetailsController>(
      init: RequestDetailsController(),
      builder: (controller) {
        return StreamBuilder<DatabaseEvent>(
          stream: controller.getData(),
          builder: (BuildContext context, snapshot) {
            print('Snapshot: ${snapshot.data!.snapshot.value!['']}');
            if (snapshot.hasError) {
              return Text("something is wrong");
            } else {
              return ListView.builder(
                itemCount: snapshot.data.snapshot,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                itemBuilder: (_, index) {
                  QueryDocumentSnapshot qs = snapshot.data!.docs[index];
                  Timestamp t = qs['time'];
                  DateTime d = t.toDate();
                  print(d.toString());
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: email == qs['email']
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: constants.blue4,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: constants.blue4,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              title: Text(
                                qs['message'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 200,
                                  ),
                                  Text(
                                    d.hour.toString() + ":" + d.minute.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

          },
        );
      }
    );
  }
}