import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Login/OtpController.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/userModelSignUp.dart';
import 'package:store_redirect/store_redirect.dart';
import '../Dashboard/Dashboard.dart';
import '../models/apiSplashScreenModels.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var token3;
var dialCodeDigits;
var dateOfBirth;
var FCMToken;
var UID;

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();

  String phone = "";

  Future<CallApi> fetchDataUser(context) async {
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/Auth/LWAD'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'phone': _controller.text,
        'app_type': 'cleaner',
        'new_fcm_token': FCMToken,
        //'new_firebase' : UID,
      }),
    );

    final responseJson = jsonDecode(response.body);
    var body = response.body;


    if (response.statusCode == 200) {
      var gender = jsonDecode(body);
      Gender = gender['user']['gender'];

      var dateOfBirthjs = jsonDecode(body);
      dateOfBirth = dateOfBirthjs['user']['date_of_birth'];

      var Codecountry = jsonDecode(body);
      CodeCountry2 = Codecountry['user']['country_inti'];

      var email = jsonDecode(body);
      EmailUser = email['user']['email'];

      var firstName = jsonDecode(body);
      FirstName = firstName['user']['first_name'];

      var lastName = jsonDecode(body);
      LastName = lastName['user']['last_name'];

      var level = jsonDecode(body);
      Level = level['user']['level'];

      var level_statues = jsonDecode(body);
      Level_statues = level_statues['user']['level_status'];

      print(response.body);

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token3', email['accessToken']);
      token3 = pref.get('token3').toString();

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OtpControllerScreen(phone: _controller.text, dialCodeDigits: dialCodeDigits),
      //   ),
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Dashboard() ),
      );
      return CallApi.fromJson(responseJson);
    } else if (response.statusCode == 421) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpControllerScreen(phone: _controller.text, dialCodeDigits: dialCodeDigits),
        ),
      );
      return CallApi.fromJson(responseJson);
    } else{
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to load album');
    }
  }

  Future<userModelSplash> fetchData(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(
            'https://staging.skephome.com/api/Auth/ExistingUser/${_controller.text}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${pref.get('token3').toString()}'
        });

    final responseJson = jsonDecode(response.body);
    var body = response.body;
    var message = json.decode(body);
    print(message['message']);
    var userType = json.decode(body);
    print(userType['user_type']);

    if (response.statusCode == 200) {
      print(response.body);
      // print(token);
      if (userType['user_type'] == "cleaner" && message['message'] == true) {
        fetchDataUser(context);
      } else if(userType['user_type'] == "homeowner" && message['message'] == true) {
        fetchDataUser(context);
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpControllerScreen(phone: _controller.text, dialCodeDigits: dialCodeDigits),
          ),
        );
      }
      return userModelSplash.fromJson(responseJson);
    } else {
      print("assasassas${response.statusCode}");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const GetStarted()),
      // );
      throw Exception('Failed to load album');
    }
  }

  late Future<userModelSplash> checkUser;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getToken().then((newToken) async{
      print("FCM Token");
      FCMToken = newToken;
      print(newToken);

      SharedPreferences pref = await SharedPreferences.getInstance();

      User? user ;
      User? userData = FirebaseAuth.instance.currentUser;
      user = userData;
      print("CCCCCCCCCC${userData?.uid}");
      userIDFirebase = userData?.uid;
      print("HAHAHAHAHAHAHAHA ${userIDFirebase}");
      pref.setString('userID', userIDFirebase);
      UID = pref.get('userID').toString();
    });



  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Enter you mobile number.",
                  style: TextStyle(fontSize: 20, fontFamily: 'Ubuntu'),
                ),
              ), // const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: constants.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: constants.grey),
                        borderRadius: BorderRadius.circular(15)),
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 5, top: 0),
                      child: CountryCodePicker(
                        onChanged: (country) {
                          setState(() async {
                            dialCodeDigits = country.dialCode!;
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.setString('codeCountry', dialCodeDigits);
                            dialCodeDigits = pref.get('codeCountry').toString();
                            print("qqqqqqqqq$dialCodeDigits");
                            // _controller.text = phone;
                          });
                        },
                        initialSelection: "CA",
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        favorite: const ["+1", "US", "+92", "PAK"],
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Please confirm your country code & enter your mobile number to create an account or login.",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 350,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "By continuing you may receive an SMS for verification. Message & data rates may apply.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(constants.blue2),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      side:
                                          BorderSide(color: constants.blue2))),
                        ),
                        onPressed: () {
                          checkUser = fetchData(context);
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
