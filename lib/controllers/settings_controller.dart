import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/models/certn_verifyed.dart';

import '../Back_ground_check/back_ground_check.dart';
import '../Login/login.dart';
import '../models/UserModel.dart';
import '../models/verifyed_model.dart';

class SettingsController extends GetxController {



  @override
  void onInit() {
    super.onInit();
  }






  void getLogOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/User/Logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = jsonDecode( response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(body);




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