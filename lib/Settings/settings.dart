import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Dashboard/TodaysList.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/Login/edit_profile.dart';
import 'package:skep_home_pro/Settings/faq.dart';
import 'package:skep_home_pro/Settings/privacy_policy.dart';
import 'package:skep_home_pro/Settings/terms_and_condations.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/settings_controller.dart';
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
        child: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (controller) => Scaffold(
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
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Card(
                    elevation: 3,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      color: Colors.white,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()),);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, right: 8.0, top: 8, bottom: 2),
                                  child:
                                  Image.asset("assets/images/accountSettings.png"),
                                ),
                                Text(
                                  "ACCOUNT SETTINGS",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 135,
                                ),
                                IconButton(
                                    iconSize: 10,
                                    color: constants.grey,
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward_ios_rounded))
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6.0, right: 8.0, top: 8),
                                child: Image.asset("assets/images/Notification.png"),
                              ),
                              Text(
                                "NOTIFICATION",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 160,
                              ),
                              Switch(
                                activeColor: Colors.greenAccent,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                },
                                value: isSwitched,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Card(
                    elevation: 3,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.white,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap :() {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsAndCondations()),);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 8.0, top: 2),
                                  child: Image.asset("assets/images/queistionMark.png"),
                                ),
                                Text(
                                  "Terms & condition",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 148,
                                ),
                                IconButton(
                                    iconSize: 10,
                                    color: constants.grey,
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward_ios_rounded)),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()),);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 8.0, top: 2),
                                  child: Image.asset("assets/images/queistionMark.png"),
                                ),
                                Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 175,
                                ),
                                IconButton(
                                    iconSize: 10,
                                    color: constants.grey,
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward_ios_rounded)),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()),);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 8.0, top: 2),
                                  child: Image.asset("assets/images/queistionMark.png"),
                                ),
                                Text(
                                  "FAQ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 235,
                                ),
                                IconButton(
                                    iconSize: 10,
                                    color: constants.grey,
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward_ios_rounded)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0 , right: 20.0),
                  child: Card(
                    elevation: 3,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        controller.getLogOut();
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.clear();
                        Get.offNamed(Routes.first_walk_through);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 4.0, right: 8.0, top: 2),
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
                ),
              ],
            ),
          ),
        ));
  }
}
