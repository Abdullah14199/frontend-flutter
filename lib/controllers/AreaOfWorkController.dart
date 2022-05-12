import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Dashboard/areaOfWork.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/certn_verifyed.dart';
import 'package:skep_home_pro/models/my_area_of_work_model.dart';

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
    myAreaOfWork();
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

  MyAreaOfWorkModel ? myAreaOfWorkModel;
  List<UserCity> userCity = [];

  void myAreaOfWork() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('https://staging.skephome.com/api/AreaOfWork/MyAreaOfWork'),
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer ${pref.get('token3').toString()}'
        });
    var responseJson = json.decode(response.body);
    print(responseJson);
    var body = response.body;
    var read = jsonDecode(body);
    if(response.statusCode == 200 ){
    print("huhuhuhuhuhu");
      myAreaOfWorkModel = MyAreaOfWorkModel.fromJson(read);
      myAreaOfWorkModel!.userCities.forEach((element) {
        userCity.add(element);
      });


    }

  }

  Map <String, String> data = {};


  void SaveAreas() async {
   // print("aaaaa a a a a  a ${idList}");
    for(int i=0;  i < idList.length;  i++){
      print("aaaaa a a a a  a eeeee${idList}");
    data.addAll({
      "add_city[$i]": idList[i]
    });
    print("aaaaaaaaaaaaa ${data.values}");
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse('https://staging.skephome.com/api/AreaOfWork/SaveAreas'),
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer ${pref.get('token3').toString()}'
        },
      body: data
        );

    var body = response.body;
    if(response.statusCode == 200 ){

      print("aaaaaaaaaaaaa ${data.values}");

      print(body);

    }else{
      print(body);

    }

  }

  void DeleteAreas() async {
    for(int i=0;  i < idList.length;  i++){
      print("aaaaa a a a a  a eeeee${idList}");
      data.remove({
        "add_city[$i]": idList[i]
      });
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse('https://staging.skephome.com/api/AreaOfWork/DeleteAreas'),
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer ${pref.get('token3').toString()}'
        },
        body: data
    );
    var body = response.body;
    if(response.statusCode == 200 ){
      print("aaaaaaaaaaaaa33333 ${data.values}");

      print(body);
    }else{
      print(body);
    }

  }





}