import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:skep_home_pro/Dashboard/TodaysList.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/serviceRequestModel.dart';
import 'package:http/http.dart' as http;

import '../Dashboard/Dashboard.dart';


class OtpControllerScreen extends StatefulWidget {
  final String phone;
  final String dialCodeDigits;

  OtpControllerScreen({required this.phone, required this.dialCodeDigits});

  @override
  State<OtpControllerScreen> createState() => _OtpControllerScreenState();

}

class _OtpControllerScreenState extends State<OtpControllerScreen> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFoucus =FocusNode();
  String? verificationcode ;



  Future<ServiceRequestModel> fetchData(context) async{
    final response =await http
        .get(Uri.parse('https://staging.skephome.com/api/ServiceRequest/CheckServiceRequest'),
        headers: {
          HttpHeaders.authorizationHeader : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1MSIsImp0aSI6IjUxODMzYTE0YmIzMGQ5OWU5NGNiODgyMzk0ZjU3NjgxZDBjYjY4NDRkYTlhYmVkY2Y1MDgyMzc1NDJjNGNmYWE4NTkyNzFkOGY1ZmMwOWU4IiwiaWF0IjoxNjQ3OTU3ODI5LCJuYmYiOjE2NDc5NTc4MjksImV4cCI6MTY3OTQ5MzgyOSwic3ViIjoiODIiLCJzY29wZXMiOltdfQ.o-m4r7LQWsBm8Gdor-R_TMwseCDdhTi6aN72aoLDUOEEQ4OOWu6oLqsKbjAbZl4-aZFoaJmoPna7JI3rSPOgYrjgF52r3j19Oq8gLWWTujTaMd8lEBO1ufS83sdxYtSeMu5GyrgonqnojIrbGbbxFnQVYIXgoReLB_FMOAiYHLSn_gh3QyvWUDQPXbMOrwNyv5zG10jsDzlCsoOOUcIQ3NuPN9jEEJSais2asBYuWq0deWYuwP7pWPQMM8uhiEYZj1RGoxM11mDWq9ny4vqvd9UNzMFyJfd1gX7jNgX0bVrqJcsG8IULylqRYQHBidyMX3UQNAYpV7TQIa9wguXfAvH9Zc2Vb0Jj7Luwkd2GyiBy82283gOkeW7O3YRB8_fxmlQ2gf8ubyUUsHlkXwKi-EZNaDKTRJoxnQD8y4Gd4bL4Oh4oL_s4VP38slynJw7bpauQzXpXZtQQB4af4QVfYvng8wuaBBiMU3ixXARLoDEUklj2tX6LG1DzCHp5JQ199hMT8I_5uCiYw66jWdP38Y2piJx4689OlCxjt9C6CJzLBjXAibHBvf8epPbHF6XpVic87GLGbKcElXDOcCp9WCP-yhMHPRxBnQ3zqMKdgCWFNMyYQ567SmvlRg665Q2-ov4iSgrRV6kyLPv32aHRw5AwE8GRh_pmFBPHttN8DjI'
        }
    );

    var body =response.body;
    var type = json.decode(body);
    print(type["Checklist"][1]["type"]);
    var visiable = json.decode(body);
    print(visiable['Checklist'][0]["Visable"]);
    final responseJson = jsonDecode(response.body);
    if(response.statusCode == 200){
      print(response.body);
      if(type["Checklist"][0]["type"]==1){
        if(visiable['Checklist'][0]["Visable"]==true){
          if(type["Checklist"][1]["type"]==2){
            if(visiable['Checklist'][1]["Visable"]==true){
              if(type["Checklist"][2]["type"]==3){
                if(visiable['Checklist'][2]["Visable"]==true){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TodaysList()),
                  );
                }
              }
            }
          }
        }
      }
      return ServiceRequestModel.fromJson(responseJson);
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => service_request()),
      );
      print(response.statusCode);
      throw Exception('Failed to load album');
    }
  }

  late Future<ServiceRequestModel> checkServiceRequest;


  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: Colors.grey),
  );

  @override
  void initState(){
    super.initState();
    startTimer();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async{
    await FirebaseAuth.instance.verifyPhoneNumber
      ( phoneNumber: "${widget.dialCodeDigits+widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
          checkServiceRequest = fetchData(context);

          if(value.user != null){
            Navigator.of(context).push(MaterialPageRoute(builder: (c)=> const TodaysList()));
          }
        });
        },
        verificationFailed: (FirebaseAuthException e){
        print(e.message.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message.toString()),
              duration: const Duration(seconds: 3),
            ),
          );
        },
        codeSent: (String vID , int? resentToken){
        setState(() {
          verificationcode = vID;
        });
        },
        codeAutoRetrievalTimeout: (String vID){
        setState(() {
            verificationcode = vID;
        });
        },
        timeout: const Duration(seconds: 60)
    );

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key : _scaffolkey,
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon:const Icon(Icons.arrow_back_ios)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80,),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Enter 6-digit code sent to you" , style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.normal,
                      ),),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left:15),
                      child: Text("at ${widget.dialCodeDigits + widget.phone} " , style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.normal,
                      ),),
                    ),
                    Padding(padding:const EdgeInsets.only(left: 15,right: 15,top: 20), child:
                    PinPut(
                      fieldsCount: 6 ,
                      textStyle: const TextStyle(fontSize: 20 , color: Colors.black),
                      eachFieldWidth: 60,
                      eachFieldHeight: 30,
                      cursorColor: Colors.white,
                      focusNode: _pinOTPCodeFoucus,
                      controller: _pinOTPCodeController,
                      submittedFieldDecoration: pinOTPCodeDecoration,
                      selectedFieldDecoration: pinOTPCodeDecoration,
                      followingFieldDecoration: pinOTPCodeDecoration,
                      pinAnimationType: PinAnimationType.rotation,
                      onSubmit: (pin) async{
                        try{
                          await FirebaseAuth.instance.
                          signInWithCredential(PhoneAuthProvider.
                          credential(verificationId: verificationcode! , smsCode: pin))
                              .then((value) {
                                if(value.user != null){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (c)=> const Dashboard()));
                                }
                          });
                        }
                        catch(e){
                          FocusScope.of(context).unfocus();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Invalid OTP"),
                              duration: Duration(seconds: 3),
                              ),
                          );
                        }
                      },
                    ),),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0 ,top:10),
                      child: Text("00:$_start"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 28),
                      child: GestureDetector(
                        onTap: (){

                        },
                        child: const Text("Edit mobile number" ,
                          style: TextStyle(
                            color: constants.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu' ,
                          ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 20),
                      child: GestureDetector(
                        onTap: (){

                        },
                        child: const Text("I didn’t receive a code" ,
                          style: TextStyle(
                            color: constants.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu' ,
                          ),),
                      ),
                    ),
                    const SizedBox(height: 250,),
                    const Padding(
                      padding: EdgeInsets.only(left: 15 , right: 15),
                      child: Text("By continuing you may receive an SMS for verification. Message & data rates may apply." ,
                        style: TextStyle(
                          fontSize: 14 ,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                        ),),
                    ),
                    const SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15 , right: 15),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                              icon: const Icon(Icons.arrow_back),
                              label: const Text(
                                "Verify",
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
                                checkServiceRequest = fetchData(context);
                              }
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
