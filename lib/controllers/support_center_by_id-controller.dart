import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login/login.dart';
import '../models/verifyed_model.dart';

class SupportCenterByIdController extends GetxController {



  void getSupportCenter(String title , String description , String jobId , BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/Ticket/CreateTicket'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
      body: {
        "title" : title,
        "description" : description ,
        "job_id" : jobId
      }
    );

    var body = jsonDecode( response.body);
    if (response.statusCode == 200) {

      print(body);
      Navigator.pop(context);

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