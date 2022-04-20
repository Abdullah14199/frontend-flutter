import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Dashboard/TodaysList.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import '../Dashboard/Dashboard.dart';
import '../models/cleanerBGModel.dart';
import '../routes/routes.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen({Key? key}) : super(key: key);

  @override
  State<settingsScreen> createState() => _settingsScreen();
}


class _settingsScreen extends State<settingsScreen> {

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon: Image.asset("assets/images/ring.png"),
                onPressed: () {
                  // do something
                },
              )
            ],
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Center(
              child: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Card(
                elevation: 3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0 , right: 8.0, top: 2 , bottom: 2),
                        child: Image.asset("assets/images/accountSettings.png"),
                      ),
                      Text(
                        "ACCOUNT SETTINGS",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                elevation: 3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0 , right: 8.0, top: 2),
                        child: Image.asset("assets/images/Notification.png"),
                      ),
                      Text(
                        "NOTIFICATION",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 200,),
                      Switch(
                          activeColor: Colors.greenAccent,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          }, value: isSwitched,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Card(
                elevation: 3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0 , right: 8.0, top: 2),
                        child: Image.asset("assets/images/queistionMark.png"),
                      ),
                      Text(
                        "Terms & condition",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0 , right: 8.0, top: 2),
                        child: Image.asset("assets/images/queistionMark.png"),
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0 , right: 8.0, top: 2 ),
                        child: Image.asset("assets/images/queistionMark.png"),
                      ),
                      Text(
                        "FAQ",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 50,),
              Card(
                elevation: 3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GestureDetector(
                  onTap: () async{
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.remove('token3');
                    Get.offNamed(Routes.first_walk_through);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0 , right: 8.0, top: 2),
                          child: Image.asset("assets/images/logoutBtn.png"),
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
