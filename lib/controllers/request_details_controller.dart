import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/MyBooking/schedule.dart';
import 'package:skep_home_pro/models/certn_verifyed.dart';
import 'package:skep_home_pro/models/my_booking_model.dart';
import 'package:skep_home_pro/models/request_details_model.dart';


class RequestDetailsController extends GetxController {
  ScheduleBooking ? scheduleBooking;
  RequestDetailsModel? requestDetailsModel;

  bool isLoading = false;
  String booking_statues = "";

  List<ServiceRequest> serviceRequestList = [];

  double lat = 0.0;
  double log = 0.0;

  String jobId = "";

  void getRequestDetails(int id) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/Booking/BookingByID/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {

      requestDetailsModel =  RequestDetailsModel.fromJson(body);

      booking_statues = requestDetailsModel!.serviceRequest.bookingStatus;
      lat = double.parse(requestDetailsModel!.serviceRequest.lat);
      log = double.parse(requestDetailsModel!.serviceRequest.lng);
      // print(latDouble);

      jobId = requestDetailsModel!.serviceRequest.jobId;



      isLoading =true;
      // certin_status =
      print("RRRRRRRRRRRRRRR${booking_statues}");
      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);

      throw Exception('Failed to create album.');
    }

    update();
  }

  void postMarkAsStartRequest(int id , BuildContext context) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/BookingStatus/MarkAsStart'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept' : 'application/json'
      },
      body: jsonEncode(<String, String>{
        'booking_id': "$id",
      }),

    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {

      requestDetailsModel =  RequestDetailsModel.fromJson(body);

      booking_statues = requestDetailsModel!.serviceRequest.bookingStatus;
      booking_statues = 'inprogress';



      isLoading =true;
      // certin_status =
      print("RRRRRRRRRRRRRRR${booking_statues}");
      // then parse the JSON.
    } if (response.statusCode == 409) {
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
                    Center(child: Text('Sorry, you can’t start the job before the start time.')),
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


    } else{

      print(response.statusCode);

      throw Exception('Failed to create album.');
    }

    update();
  }

  void postMarkAsCompleteRequest(int id , BuildContext context) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/BookingStatus/MarkAsComplete'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept' : 'application/json'
      },
      body: jsonEncode(<String, String>{
        'booking_id': "$id",
      }),

    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {

      requestDetailsModel =  RequestDetailsModel.fromJson(body);

      booking_statues = requestDetailsModel!.serviceRequest.bookingStatus;
      booking_statues = 'completed';



      isLoading =true;
      // certin_status =
      print("RRRRRRRRRRRRRRR${booking_statues}");
      // then parse the JSON.
    } if (response.statusCode == 409) {
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
                    Center(child: Text('You Can not Complete the Job before to do the checklist.')),
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


    } else{
      print(response.statusCode);
      print(body);

      throw Exception('Failed to create album.');
    }

    update();
  }





  void postMarkAsCancelRequest(int id , BuildContext context) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/BookingStatus/CancelForCleaner'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept' : 'application/json'
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
      print("RRRRRRRRRRRRRRR${booking_statues}");
      // then parse the JSON.
    } else{
      print(response.statusCode);
      print(body);

      throw Exception('Failed to create album.');
    }

    update();
  }
}