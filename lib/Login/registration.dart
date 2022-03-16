import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:http/http.dart' as http;
import 'package:skep_home_pro/models/userModelSignUp.dart';

import '../Dashboard/Dashboard.dart';
import 'package:form_field_validator/form_field_validator.dart';


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  Future<CallApi>? _futureAlbum;

  Future<CallApi> createAlbum(String first_name, String last_name , String email , String phone ) async {
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/Auth/Register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept' : 'application/json'
      },
      body: jsonEncode(<String, String>{
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'phone' : phone,
        'lat' : "43.651070",
        'lng' : "-79.347015"
      }),
    );
    if (response.statusCode == 200) {
      // then parse the JSON.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
      print(response.body);
      return CallApi.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);
      print(response.body);
      showDialog(context: context, builder: (context){
       return AlertDialog(
          title: const Text('Sorry.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('The email has already been taken.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
      print("Hohohohoh");
      throw Exception('Failed to create album.');
    }
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: formkey,
            child: Stack(
              children:[
                const Positioned(
                  top: 0,
                  right: 15,
                  left: 15,
                  child: Text("Complete your Data.",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 15,
                  right: 220,
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Required";
                      }else {
                        return null;
                      }
                    },
                    decoration:  InputDecoration(
                        labelText: 'First name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: constants.grey),
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
                            borderSide: const BorderSide(width: 2,color: constants.grey),
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                    controller: _controllerFirstName,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 220,
                  right: 15,
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Required";
                      }else {
                        return null;
                      }
                    },
                    decoration:  InputDecoration(
                        labelText: 'Last name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: constants.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: constants.grey),
                            borderRadius: BorderRadius.circular(15)
                        ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),

                    ),
                    controller: _controllerLastName,
                  ),
                ),
                Positioned(
                  top: 130,
                  left: 15,
                  right: 15,
                  child: TextFormField(
                    validator: MultiValidator(
                      [
                        EmailValidator(errorText: "Not A Valid Email"),
                        RequiredValidator(errorText: "Required"),
                      ]
                    ),
                    decoration:  InputDecoration(
                      labelText: 'Email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: constants.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: constants.grey),
                            borderRadius: BorderRadius.circular(15)
                        ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    controller: _controllerEmail,
                  ),
                ),
                Positioned(
                  top: 220,
                  right: 15,
                  left: 15,
                  child: TextFormField(
                    validator: MultiValidator(
                      [
                        MinLengthValidator(11, errorText: "The Phone number must be 11 numbers"),

                      ]
                    ),
                    decoration:  InputDecoration(
                      labelText: 'Mobile Number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: constants.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: constants.grey),
                            borderRadius: BorderRadius.circular(15)
                        ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    controller: _controllerPhone,
                  ),
                ),
                Positioned(
                  top: 310,
                  left: 15,
                  right: 15,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: 'Referral Code ( optional )',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: constants.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: constants.grey),
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                  ),
                ),
                const Positioned(
                  top: 510,
                  right: 15,
                  left: 15,
                  child: Text("By signing up you are ready to accept the",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.normal
                    ),),
                ),
                const Positioned(
                  top: 510,
                  right: 15,
                  left: 280,
                  child: Text("privacy policy",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.normal,
                      color: constants.yellow
                    ),),
                ),
                const Positioned(
                  top: 525,
                  right: 15,
                  left: 15,
                  child: Text("&",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.normal
                    ),),
                ),
                const Positioned(
                  top: 525,
                  right: 15,
                  left: 28,
                  child: Text("terms & conditions",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.normal,
                      color: constants.yellow
                    ),),
                ),
                Positioned(
                  top: 545,
                  left: 15,
                  right: 15,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_back),
                          label: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 14,),
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(constants.blue),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                                    side: BorderSide(color: constants.blue)
                                )
                            ),
                          ),
                          onPressed: () {
                            if(_controllerFirstName.text.isEmpty ||_controllerLastName.text.isEmpty || _controllerEmail.text.isEmpty ||_controllerPhone.text.isEmpty ){
                              validate();
                            }else {
                              setState(() {
                                _futureAlbum = createAlbum(
                                    _controllerFirstName.text,
                                    _controllerLastName.text,
                                    _controllerEmail.text,
                                    _controllerPhone.text);
                              });
                            }
                          }
                      ),
                    ),
                  ),
                )
              ],

            ),
          ),
    ));
  }

  void validate() {
    if(formkey.currentState!.validate()){
      print("Validate");
    }else{
      print("Not Validate");
    }
  }
}
