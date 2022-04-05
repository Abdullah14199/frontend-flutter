import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/models/my_booking_model.dart';

import '../Login/login.dart';
import '../models/verifyed_model.dart';

class MYBookingController extends GetxController {



  @override
  void onInit() {
    super.onInit();
    getMyBooking();
  }

  MyBookingModel? myBookingModel;

  var Read;

  List<ScheduleBooking> bookingList = [];



  void getMyBooking() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/Homeowner/MyBookings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = response.body;
    var read = jsonDecode(body);
    if (response.statusCode == 200) {

       myBookingModel = MyBookingModel.fromJson(read);

      myBookingModel!.schedule.forEach((element) {
        bookingList.add(element);
      });


      print(body);
      print(response.statusCode);

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