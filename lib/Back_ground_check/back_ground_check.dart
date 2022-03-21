import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:skep_home_pro/constatns/constants.dart';

import '../models/cleanerBGModel.dart';

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




Future<CallApiBG> createAlbum(String gender, String codeCountry ) async {
  final response = await http.post(
    Uri.parse('http://staging.skephome.com/api/Cleaner/CleanerBackground'),
    headers: <String, String>{
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1MSIsImp0aSI6ImUxM2YzYmVjZWFjMzc0NDcwZTA2ODNkZDVmYWZmOWJkYzkzMmZmZWE3MjY2YmE1NDI5MDUwMDM0NzRlM2JhOWNmNGM3ZGM2NzIzZDZjNjFhIiwiaWF0IjoxNjQ3MzQ4NDQ4LCJuYmYiOjE2NDczNDg0NDgsImV4cCI6MTY3ODg4NDQ0OCwic3ViIjoiNTYiLCJzY29wZXMiOltdfQ.oUr1WS1-YuWrF9VdPOsJmRMCRxZVtULJSpVRDC_cM7CjpkIztzEB2mQCt9EMvWTwj_cr6r-UYiU-S4dnOS-GaK6FV2KInbM-23Nv-tOYj8Th19_qwpRgzEJWlukv2R-05vA7FDegRJ0L4jEtfycBSDqNd6KEXaULqiYvjHuCaO0nRnyp1_QWU-5Uan0Od7vdPQ6uYLd_ecP1oYtoF1gnzPq7dkbaVHkGwDCd8NIyVBvnDxr3PLkjU6RhazptZD7zDu65-ItIlEr_0NHVqOh78MpHRoPFag531OYQIPMj8NjNdw8SRdpZnr2Rxt-XdV1pfJrzvfsZZ1oG2ydyrwnkTQqiqwPYyxsT6UlElvlXMwA9XCpzzro16W1V66paDgrv5Fp0-Ev1IngnlZhfEduEkVUA2hWd68q-a0yl6j_8s48Mcc3_nFf-HD2cyIpbkNVPJww8YJ18mxR0s-fwGdke6wq2yPCnTwqLZcjSjb_jED6IMNgY_tSUX9v5Bq1dGYm5IxtQ039suJj53YpTikSawj8-UPrj3rPjnvaHpdvChsb3Ln2zaBJXew5QEgJBX7KlRIUTn2hIXL5lEkJbfB5TbZNzK5bw5sfNQLbU4yI2nWtpMTBfscCIMB-sp9x9JM1MQQw_dLNwiJA2jCTXzFjKeExG3G8mp8OmbEEO8vrcz6Q',
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



class _backGroundCheckState extends State<backGroundCheck> {
  String genderBool = '';
  String CountryCode = '';

  @override
  Widget build(BuildContext context) {
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
                print(countryCode);
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
            top: 780,
            right: 15,
            left: 15,
            child: Container(
              width: double.infinity,
              height: 35,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton(
                  onPressed: () {
                    print(genderBool + CountryCode);
                    createAlbum(genderBool, CountryCode);
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
                        MaterialStateProperty.all<Color>(constants.blue),
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
