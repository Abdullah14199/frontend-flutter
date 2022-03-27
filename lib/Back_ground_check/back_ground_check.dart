import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Dashboard/Dashboard.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import '../models/cleanerBGModel.dart';
import '../routes/routes.dart';

class backGroundCheck extends StatefulWidget {
  const backGroundCheck({Key? key}) : super(key: key);

  @override
  State<backGroundCheck> createState() => _backGroundCheckState();
}

RxBool male = false.obs;
RxBool female = false.obs;
RxBool myOwnCar = false.obs;
RxBool otherNotSure = false.obs;
RxBool publicTransport = false.obs;

var Gender;
var CodeCountry2;
var EmailUser;
var FirstName;
var LastName;


Future<CallApiBG> createAlbum(String gender, String codeCountry ,context) async {
  final response = await http.post(
    Uri.parse('http://staging.skephome.com/api/Cleaner/CleanerBackground'),
    headers: <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept' : 'application/json'
    },
    body: jsonEncode(<String, String>{
      'gender': gender,
      'country_inti': codeCountry,
    }),
  );
  if (response.statusCode == 200) {
    // then parse the JSON.
    print(response.body);
    print(response.statusCode);

    var body = response.body;

    var gender = jsonDecode(body);
    Gender = gender['user']['gender'] ;

    var Codecountry = jsonDecode(body);
    CodeCountry2 = Codecountry['user']['country_inti'] ;

    var email = jsonDecode(body);
    EmailUser = email['user']['email'] ;

    var firstName = jsonDecode(body);
    FirstName = firstName['user']['first_name'];

    var lastName = jsonDecode(body);
    LastName = lastName['user']['last_name'];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );

    print("klsjaddhklaslkasd");
    return CallApiBG.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print("Hohohohoh");
    throw Exception('Failed to create album.');
  }
}

var token = "";


class _backGroundCheckState extends State<backGroundCheck> {
  String genderBool = '';
  String CountryCodeValue = '';


  @override
  Widget build(BuildContext context) {


    SharedPreferences.getInstance().then((sharedPrefValue){
      setState(() {
        token = sharedPrefValue.getString('token')!;
        //print(token);
      });
    });


    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              top: 15,
              right: 50,
              left: 50,
              child: Center(
                  child: Text(
                "Background Check",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold),
              ))),
          Positioned(
              top: 50,
              right: 40,
              left: 40,
              child: Center(
                child: Text(
                  "At skep home, we always focus on the best service and customer satisfation. with the account verification requirements below, we aim to ensure the comfort and reliability for all user",
                  style: TextStyle(
                      color: constants.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu'),
                ),
              )),
          Positioned(
              top: 130,
              left: 25,
              right: 15,
              child: Text(
                "Gender",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu'),
              )),
          Positioned(
              top: 155,
              left: 25,
              right: 100,
              child: Text(
                "This questions is required to process your background check",
                style: TextStyle(
                    fontSize: 12,
                    color: constants.grey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu'),
              )),
          Positioned(
            top: 190,
            right: 380,
            left: 20,
            child: RoundCheckBox(
              onTap: (value) {
                male.value = value!;
                if(male.value){
                  genderBool = "M";
                  print(genderBool);
                }else {
                  genderBool = "";
                  print(genderBool);
                }
                // print(male.value);
              },
              size: 30,
              isChecked: male.value,
              checkedColor: constants.blue2,
              uncheckedColor: Colors.white,
            ),
          ),
          Positioned(
              top: 195,
              right: 15,
              left: 60,
              child: Text(
                "Male",
                style: TextStyle(color: constants.grey),
              )),
          Positioned(
            top: 190,
            right: 295,
            left: 105,
            child: RoundCheckBox(
              onTap: (value) {
                female.value = value!;
                if(female.value){
                  genderBool = "F";
                  print(genderBool);
                }else {
                  genderBool = "";
                  print(genderBool);
                }
              },
              size: 30,
              isChecked: female.value,
              checkedColor: constants.blue2,
              uncheckedColor: Colors.white,
            ),
          ),
          Positioned(
              top: 195,
              right: 15,
              left: 145,
              child: Text(
                "Female",
                style: TextStyle(color: constants.grey),
              )),
          Positioned(
              top: 230,
              left: 20,
              child: Text(
                "Country of birth",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                ),
              )),
          Positioned(
            top: 250,
            left: 20,
            child: CountryCodePicker(
              onChanged: (countryCode) {
                print;
                CountryCodeValue = countryCode.code!;
                print(CountryCodeValue);

                } ,
              initialSelection: 'US',
              favorite: ['+1','US'],
              showCountryOnly: true,
              showOnlyCountryWhenClosed: true,
              alignLeft: false,
            ),
          ),
          Positioned(
              top: 300,
              left: 15,
              right: 15,
              child: Card(
                elevation: 3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        " I consent that i do not have a criminal \n record history.",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Switch(
                          activeColor: Colors.greenAccent,
                          value: true,
                          onChanged: (onChanged) {}),
                    ],
                  ),
                ),
              )),
          Positioned(
              top: 360,
              left: 15,
              right: 15,
              child: Card(
                elevation: 3,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        " I am legally allowed to work in \n Canada.",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 115,
                      ),
                      Switch(
                          activeColor: Colors.greenAccent,
                          value: true,
                          onChanged: (onChanged) {}),
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 420,
            left: 15,
            right: 15,
            child: Card(
              elevation: 3,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      left: 8,
                      bottom: 8,
                      right: 8,
                      child: Text(
                        "How will you be commuting?",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 15, bottom: 5),
                      child: RoundCheckBox(
                        onTap: (value) {
                          myOwnCar.value = value!;
                        },
                        size: 30,
                        isChecked: myOwnCar.value,
                        checkedColor: constants.blue2,
                        uncheckedColor: Colors.white,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 35, left: 50, bottom: 5),
                        child: Text(
                          "My own car.",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu'),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 75, left: 50, bottom: 5),
                      child: Text(
                        "Other/Not sure",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 70, left: 15, bottom: 5),
                      child: RoundCheckBox(
                        onTap: (value) {
                          otherNotSure.value = value!;
                        },
                        size: 30,
                        isChecked: otherNotSure.value,
                        checkedColor: constants.blue2,
                        uncheckedColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 220, bottom: 5),
                      child: RoundCheckBox(
                        onTap: (value) {
                          publicTransport.value = value!;
                        },
                        size: 30,
                        isChecked: publicTransport.value,
                        checkedColor: constants.blue2,
                        uncheckedColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35, left: 255, bottom: 5),
                      child: Text(
                        "Public transport.",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 650,
            right: 15,
            left: 15,
            child: Container(
              width: double.infinity,
              height: 35,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton(
                  onPressed: () {
                    print(genderBool + CountryCodeValue);
                    createAlbum(genderBool, CountryCodeValue , context);

                  },
                  child: Text(
                    "Complete",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(constants.blue2),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            side: BorderSide(color: constants.blue))),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
