import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Login/login.dart';
import 'package:skep_home_pro/constatns/constants.dart';

import '../Dashboard/service_request.dart';
import '../controllers/certn_verifyed_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
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
            "Account Settings",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      ),
      body: GetBuilder<CertnVerifyedController>(
        init: CertnVerifyedController(),
        builder: (controller) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 150 , top: 10),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://staging.skephome.com/storage/${Selfie}" ,),
                radius: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0 , top: 175),
              child: Text('First Name' , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu'),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 210, top: 175),
              child: Text('Last Name' , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu')),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15 , top: 200 , right: 210),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: '${FirstName}',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 3, color: constants.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 2, color: constants.grey),
                        borderRadius: BorderRadius.circular(15))),
                controller: _controllerFirstName,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 210 , top: 200 , right: 15),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: '${LastName}',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 3, color: constants.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 2, color: constants.grey),
                        borderRadius: BorderRadius.circular(15))),
                controller: _controllerLastName,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18, top: 275),
              child: Text('Email' , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu')),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15 , top: 300 , right: 40),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: '${EmailUser}',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 3, color: constants.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 2, color: constants.grey),
                        borderRadius: BorderRadius.circular(15))),
                controller: _controllerEmail,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 300 , top: 300 , right: 15),
              child: Container(
                height: 59,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16)
                ),
                child: controller.EmailVerifiedBool == false ? ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(constants.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                            side: BorderSide(color: constants.red)
                        )
                    ),
                  ),
                  onPressed: () {
                    controller.postUpdateEmail();
                    },
                  child: Text("Verify"),
                ) : SizedBox(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18, top: 375),
              child: Text('Date of Birth' , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu')),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15 , top: 400 , right: 15),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: '${dateOfBirth}',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 3, color: constants.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 2, color: constants.grey),
                        borderRadius: BorderRadius.circular(15))),
                controller: _controllerDate,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18, top: 475),
              child: Text('Phone Number' , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu')),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15 , top: 500 , right: 300),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: '${dialCodeDigits}',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 3, color: constants.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 2, color: constants.grey),
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 100 , top: 500 , right: 15),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: '${Phone}',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 3, color: constants.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 2, color: constants.grey),
                        borderRadius: BorderRadius.circular(15))),
                controller: _controllerDate,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15 , top: 580 , right: 15),
              child: Container(
                height: 59,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(constants.yellow),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                            side: BorderSide(color: constants.yellow)
                        )
                    ),
                  ),
                  onPressed: () {
                    controller.postUpdateUser();
                    },
                  child: Text("Apply changes"),
                ),
              ),
            ),

          ],
        ),

      ),
    ),
    );
  }
}
