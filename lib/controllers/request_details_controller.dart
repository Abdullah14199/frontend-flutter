import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/models/certn_verifyed.dart';
import 'package:skep_home_pro/models/my_booking_model.dart';
import 'package:skep_home_pro/models/request_details_model.dart';

import '../Back_ground_check/back_ground_check.dart';
import '../Login/login.dart';
import '../models/UserModel.dart';
import '../models/verifyed_model.dart';

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
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');


    // var latDouble = double.parse(requestDetailsModel!.serviceRequest.lat);

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

}