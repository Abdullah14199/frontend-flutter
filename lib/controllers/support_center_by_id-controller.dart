import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/MyBooking/schedule.dart';
import 'package:skep_home_pro/constatns/constants.dart';

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
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          width: double.infinity,
          height: 350,
          decoration: const BoxDecoration(color: Colors.white ,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            children:[
              Container(
                width: 150,
                height: 5,
                decoration: const BoxDecoration(
                  color: constants.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Image.asset("assets/images/correction.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50 , right: 50 , top: 15),
                child: Center(child: Text("Ticket is placed successfully,")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20 , right: 20 , top: 15),
                child: Center(child: Text("Your ticket has been submitted successfully. You will be Hearing from us soon." , style: TextStyle(color: constants.grey , fontSize: 12),)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0 , right: 10 , left: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Schedule()),
                    );
                  }, child: Text("Close")),
                ),
              ),
             
            ] ,
          ),
        ),
      );


      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);

      throw Exception('Failed to create album.');
    }
    update();
  }

  void getSupportCenterMenu(String title , String description  , BuildContext context) async {
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
        }
    );

    var body = jsonDecode( response.body);
    if (response.statusCode == 200) {

      print(body);
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          width: double.infinity,
          height: 350,
          decoration: const BoxDecoration(color: Colors.white ,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            children:[
              Container(
                width: 150,
                height: 5,
                decoration: const BoxDecoration(
                  color: constants.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Image.asset("assets/images/correction.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50 , right: 50 , top: 15),
                child: Center(child: Text("Ticket is placed successfully,")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20 , right: 20 , top: 15),
                child: Center(child: Text("Your ticket has been submitted successfully. You will be Hearing from us soon." , style: TextStyle(color: constants.grey , fontSize: 12),)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0 , right: 10 , left: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Schedule()),
                    );
                  }, child: Text("Close")),
                ),
              ),

            ] ,
          ),
        ),
      );


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