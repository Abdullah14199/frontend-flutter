import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Dashboard/Dashboard.dart';
import 'package:skep_home_pro/MyBooking/requests_details.dart';
import 'package:skep_home_pro/MyBooking/schedule.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/certn_verifyed.dart';
import 'package:skep_home_pro/models/my_booking_model.dart';
import 'package:skep_home_pro/models/request_details_model.dart';
import 'package:skep_home_pro/notification/notification.dart';

import '../Back_ground_check/back_ground_check.dart';
import '../MyBooking/complete_details.dart';
import '../models/chat_model.dart';
import '../models/rating_user_model.dart';

class RequestDetailsController extends GetxController {
  ScheduleBooking? scheduleBooking;
  RequestDetailsModel? requestDetailsModel;
  RatingUserModel? ratingUserModel;

  bool isLoading = false;
  String booking_statues = "";


  RequestDetailsController(){
    getData();
    getCleanerRating();
  }

  List<ServiceRequest> serviceRequestList = [];

  double lat = 0.0;
  double log = 0.0;

  String jobId = "";

  ChatModel? chatModel;

  bool color = true;



  void send(String message) {
    ChatModel model = ChatModel(
        booking_id:'$idBooking',
        message: message,
        receiver: homeOwnerPhone ,
        receiverUid: homeOwnerUid,
        sender: "$Phone",
        senderUid: '$userID',
        time:'${DateTime.now()}',
        timeStamp:DateTime
            .now()
            .millisecondsSinceEpoch,
    );


    FirebaseDatabase.instance
        .ref('chat_rooms')
        .child('${idBooking}')
        .child('${DateTime
        .now()
        .millisecondsSinceEpoch}')
        .set(model.toJson());
  }

   void getData(){
    FirebaseDatabase.instance
        .ref('chat_rooms')
        .child('${idBooking}')
        .orderByChild('time')
        .get().then((value) {
        print(value.value);
    });


  }

  void postRating(int id , String comment ,int valueRating) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/Rating/StoreRating/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'cleaner_rate': "$valueRating",
        'cleaner_comment': comment,
      }),
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
     print(body);
     print("done");
      // then parse the JSON.
    } else {
      print(response.statusCode);

      throw Exception('Failed to create album.');
    }

    update();
  }



  void getCleanerRating() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/Rating/GetClenaerRating/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      ratingUserModel = RatingUserModel.fromJson(body);

      print(response.statusCode);

      isLoading = true;

      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);

      throw Exception('Failed to create album.');
    }

    update();
  }


  void getRequestDetails(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/Booking/BookingByID/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      requestDetailsModel = RequestDetailsModel.fromJson(body);
      idBooking = requestDetailsModel!.serviceRequest.id;

      print("ffffffffffffffffffffffffff$idBooking");
      booking_statues = requestDetailsModel!.serviceRequest.bookingStatus;
      lat = double.parse(requestDetailsModel!.serviceRequest.lat);
      log = double.parse(requestDetailsModel!.serviceRequest.lng);
      // print(latDouble);

      jobId = requestDetailsModel!.serviceRequest.jobId;

      isLoading = true;
      // certin_status =

      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);

      throw Exception('Failed to create album.');
    }

    update();
  }

  void postMarkAsStartRequest(int id, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/BookingStatus/MarkAsStart'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'booking_id': "$id",
      }),
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      requestDetailsModel = RequestDetailsModel.fromJson(body);

      booking_statues = requestDetailsModel!.serviceRequest.bookingStatus;
      booking_statues = 'inprogress';

      isLoading = true;
      // certin_status =

      // then parse the JSON.
    }
    if (response.statusCode == 409) {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: const Text('Skep Pro.')),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Center(
                        child: Text(
                            'Sorry, you can’t start the job before the start time.')),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });

      print(response.statusCode);
    } else {
      print(response.statusCode);

      throw Exception('Failed to create album.');
    }

    update();
  }

  void postMarkAsCompleteRequest(int id, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/BookingStatus/MarkAsComplete'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'booking_id': "$id",
      }),
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      requestDetailsModel = RequestDetailsModel.fromJson(body);

      booking_statues = requestDetailsModel!.serviceRequest.bookingStatus;
      booking_statues = 'completed';

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) =>
            Container(
              width: double.infinity,
              height: 350,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: constants.grey,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Image.asset("assets/images/correction.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 15),
                    child: Center(
                        child: Text(
                          "Booking Complete",
                          style: TextStyle(fontSize: 14),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 10, left: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Schedule()),
                              );
                            },
                            child: Text("Close")),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      );

      isLoading = true;
      // certin_status =

    }
    if (response.statusCode == 409) {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: const Text('Skep Pro.')),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Center(
                        child: Text(
                            'You Can not Complete the Job before to do the checklist.')),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });

      print(response.statusCode);
    } else {
      print(response.statusCode);
      print(body);

      throw Exception('Failed to create album.');
    }

    update();
  }

  void postMarkAsCancelRequest(int id, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(
          'http://staging.skephome.com/api/BookingStatus/CancelForCleaner'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'booking_id': "$id",
      }),
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Schedule()),
      );

      // certin_status =

      // then parse the JSON.
    } else {
      print(response.statusCode);
      print(body);

      throw Exception('Failed to create album.');
    }

    update();
  }
}
