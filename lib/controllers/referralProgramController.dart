import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/models/certn_verifyed.dart';
import 'package:skep_home_pro/models/referral_program_model.dart';


import '../Back_ground_check/back_ground_check.dart';
import '../Login/login.dart';
import '../models/UserModel.dart';
import '../models/verifyed_model.dart';

class RefeeralProgramController extends GetxController {



  @override
  void onInit() {
    super.onInit();
    getReferralCode();
  }


  refalProgramModel ? referralProgramModel;


  var EmailVerifiedBool;

  // bool email_verified = true;
  String ReferalCode = "";
  int ReferalBalance = 0;


  void getReferralCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/Referral/GetUserReferral'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {

      print(response.statusCode);
      print(body);

      referralProgramModel =  refalProgramModel.fromJson(body);

      ReferalCode = referralProgramModel!.ReferralCode;

    } else {

      print(response.statusCode);

      throw Exception('Failed to create album.');
    }
    update();
  }


}