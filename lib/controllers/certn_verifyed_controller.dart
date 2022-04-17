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

class CertnVerifyedController extends GetxController {



  @override
  void onInit() {
    super.onInit();
    getCertnVerifyed();
    postUpdateUser();
  }


  CertnVerifyedModel ? certnVerifyedModel;
  UserModel? updateUser;

  var EmailVerifiedBool;

  // bool email_verified = true;
  String certin_status = "";


  void getCertnVerifyed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/AppStatus/GetCertificateStatus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = jsonDecode( response.body);
    if (response.statusCode == 200) {

      certnVerifyedModel =  CertnVerifyedModel.fromJson(body);

      certin_status = certnVerifyedModel!.certin_status!;

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


  void postUpdateEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/User/UpdateEmail'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept' : 'application/json'
      },
      body: jsonEncode(<String, String>{
        'email': EmailUser,
      }),
    );

    var body = jsonDecode( response.body);
    if (response.statusCode == 200) {

      print(body);

      print(response.statusCode);

      // certin_status =
      print("Done");

      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);

      print(body);

      throw Exception('Failed to create album.');
    }
  }

  void postUpdateEmail2(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/User/UpdateEmail'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept' : 'application/json'
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    var body = jsonDecode( response.body);
    if (response.statusCode == 200) {

      print(body);

      print(response.statusCode);

      // certin_status =
      print("Done");

      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);

      print(body);

      throw Exception('Failed to create album.');
    }
  }


  void getEmailExisit(String emailUser) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/Auth/ExistingEmail/$emailUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = jsonDecode( response.body);
    if (response.statusCode == 200) {

      print(body);

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


  void postUpdateUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/User/UpdateProfile'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept' : 'application/json'
      },
    );

    // var body = jsonDecode( response.body);
    var body =response.body;
    if (response.statusCode == 200) {


      var email_verified = jsonDecode(body);
      EmailVerifiedBool = email_verified['user']['email_verified'] ;

      print(response.statusCode);
      print(body);



      print("Done    $EmailVerifiedBool}");





      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);

      throw Exception('Failed to create album.');
    }
    update();
  }

  //User/UpdateProfile

  void postUpdateProfileUser(String firstName , String lastName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/User/UpdateProfile'),
      headers: <String, String>{
        'Authorization': 'Bearer ${pref.get('token3').toString()}',
        'Accept' : 'application/json'
      },
      body: {
        'first_name' : firstName,
        'last_name' : lastName ,
      }
    );

    // var body = jsonDecode( response.body);
    var body =response.body;
    if (response.statusCode == 200) {


      var email_verified = jsonDecode(body);
      EmailVerifiedBool = email_verified['user']['email_verified'] ;

      print(response.statusCode);
      print(body);

      FirstName = email_verified['user']['first_name'];
      LastName = email_verified['user']['last_name'];
      EmailUser = email_verified['user']['email'];


      print("Done    $EmailVerifiedBool}");
      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);
      print(body);

      throw Exception('Failed to create album.');
    }
    update();
  }




}