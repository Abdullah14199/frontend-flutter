import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/models/my_booking_model.dart';

import '../Login/login.dart';
import '../models/complete_booking.dart';
import '../models/verifyed_model.dart';



class MYCompleteBookingController extends GetxController {



  @override
  void onInit() {
    super.onInit();
    getMyBooking();
  }

  CompleteBooking? myCompleteBookingModel;

  var Read;

  bool isLoading = false;

  List<HistoryBooking> completeList = [];

  bool chooseScreen = true;

  bool history = true;

  void choose(bool screen){
    chooseScreen = screen;
    update();
  }

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

      myCompleteBookingModel = CompleteBooking.fromJson(read);

      myCompleteBookingModel!.history.forEach((element) {
        completeList.add(element);
      });


      isLoading = true;

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