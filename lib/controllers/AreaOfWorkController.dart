import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/models/certn_verifyed.dart';

import '../Back_ground_check/back_ground_check.dart';
import '../Login/login.dart';
import '../models/UserModel.dart';
import '../models/allCitiesModel.dart';
import '../models/verifyed_model.dart';

class AreaOfWorkController extends GetxController {



  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }


  AllCitiesModel ? allCitiesModel;
  List<AllCity> allCity = [];

  void fetchPosts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('https://staging.skephome.com/api/AreaOfWork/AllCitys'),
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer ${pref.get('token3').toString()}'
        });
    var responseJson = json.decode(response.body);
    print(responseJson);
    var body = response.body;
    var read = jsonDecode(body);
    if(response.statusCode == 200 ){
      allCitiesModel = AllCitiesModel.fromJson(read);

      allCitiesModel!.allCitys.forEach((element) {
        allCity.add(element);

      });


    }

  }

  void SaveAreas(List int) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse('https://staging.skephome.com/api/AreaOfWork/SaveAreas'),
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer ${pref.get('token3').toString()}'
        },
      body: {
        "add_city[0]" : 1,
        "add_city[1]" : 2,
        "add_city[2]" : 3,
      }
        );
    var responseJson = json.decode(response.body);
    print(responseJson);
    var body = response.body;
    var read = jsonDecode(body);
    if(response.statusCode == 200 ){
      allCitiesModel = AllCitiesModel.fromJson(read);

      allCitiesModel!.allCitys.forEach((element) {
        allCity.add(element);

      });


    }

  }






}