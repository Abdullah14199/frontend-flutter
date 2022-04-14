import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
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

GlobalKey<FormState> formkey = GlobalKey<FormState>();

class _EditProfileState extends State<EditProfile> {

  late TextEditingController _controllerFirstName = TextEditingController();
  late TextEditingController _controllerLastName = TextEditingController();
  late TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  bool isButtonActive = false ;



  @override
  void initState(){
    super.initState();

    _controllerFirstName = TextEditingController();
    _controllerLastName = TextEditingController();
    _controllerEmail = TextEditingController();

    _controllerFirstName.text = '$FirstName';
    _controllerLastName.text = '$LastName';
    _controllerEmail.text = '$EmailUser';

    _controllerFirstName.addListener(() {
      final isButtonActive = _controllerFirstName.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    _controllerLastName.addListener(() {
      final isButtonActive = _controllerLastName.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    _controllerEmail.addListener(() {
      final isButtonActive = _controllerEmail.text.isEmail;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose(){
    _controllerFirstName.dispose();
    _controllerLastName.dispose();

    super.dispose();
  }

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
        builder: (controller) => Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formkey,
          child: Stack(
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
                child: Container(
                  height: 65,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      } else {
                        return null;
                      }
                    },

                    decoration: InputDecoration(
                        //hintText: '${FirstName}',
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 7.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: constants.grey),
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
                            const BorderSide(width: 1, color: constants.grey),
                            borderRadius: BorderRadius.circular(15))),
                    controller: _controllerFirstName,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 210 , top: 200 , right: 15),
                child: Container(
                  height: 65,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        //hintText: '${LastName}',
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 7.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: constants.grey),
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
                            const BorderSide(width: 1, color: constants.grey),
                            borderRadius: BorderRadius.circular(15))),
                    controller: _controllerLastName,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 18, top: 275),
                child: Text('Email' , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu')),
              ),

              Padding(
                padding: EdgeInsets.only(left: 15 , top: 300 , right: 40),
                child: Container(
                  height: 65,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.isEmail) {
                        return '';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 7.0),
                        //hintText: '${EmailUser}',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: constants.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: !isButtonActive ? OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ) : null,
                        focusedErrorBorder: !isButtonActive ?  OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ) : null,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(width: 1, color: constants.grey),
                            borderRadius: BorderRadius.circular(15))),
                    controller: _controllerEmail,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 290 , top: 300 , right: 15),
                child: Container(
                  height: 47,
                  width: 90,
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
                child: Container(
                  height: 65,
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: '${dateOfBirth}',
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 7.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: constants.grey),
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
              ),

              Padding(
                padding: const EdgeInsets.only(left: 18, top: 475),
                child: Text('Phone Number' , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu')),
              ),

              Padding(
                padding: EdgeInsets.only(left: 15 , top: 500 , right: 300),
                child: Container(
                  height: 65,
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: '${dialCodeDigits}',
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 7.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: constants.grey),
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
              ),

              Padding(
                padding: EdgeInsets.only(left: 100 , top: 500 , right: 15),
                child: Container(
                  height: 65,
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 7.0),
                        hintText: '${Phone}',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: constants.grey),
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
              ),

              Padding(
                padding: EdgeInsets.only(left: 15 , top: 580 , right: 15),
                child: Container(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(isButtonActive ? constants.yellow : constants.grey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                           RoundedRectangleBorder(
                              borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                              side: BorderSide(color: isButtonActive ? constants.yellow : constants.grey)
                          )
                      ),
                    ),
                    onPressed: isButtonActive ? () {
                      if (_controllerFirstName.text.isEmpty ||
                          _controllerLastName.text.isEmpty ||
                          _controllerEmail.text.isEmpty || !_controllerEmail.text.isEmail) {
                        validate();
                      }else{
                        controller.getEmailExisit(_controllerEmail.text);
                        controller.postUpdateProfileUser(_controllerFirstName.text, _controllerLastName.text);
                        controller.postUpdateEmail2(_controllerEmail.text);
                      }
                      } : null,
                    child: Text("Apply changes"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}




void validate() {
  if (formkey.currentState!.validate()) {
    print("Validate");
  } else {
    print("Not Validate");
  }
}