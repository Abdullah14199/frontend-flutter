import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:skep_home_pro/Dashboard/Dashboard.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/Login/OtpController.dart';
import 'package:skep_home_pro/Login/registration.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/splash_screen/get_started.dart';
import '../models/apiSplashScreenModels.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _controller = TextEditingController();
  String dialCodeDigits = "+00";
  String phone = "";

  Future<userModelSplash> fetchData(context) async{
    final response =await http
        .get(Uri.parse('https://staging.skephome.com/api/Auth/ExistingUser/0${_controller.text}'),
        headers: {
          HttpHeaders.authorizationHeader : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1MSIsImp0aSI6IjUxODMzYTE0YmIzMGQ5OWU5NGNiODgyMzk0ZjU3NjgxZDBjYjY4NDRkYTlhYmVkY2Y1MDgyMzc1NDJjNGNmYWE4NTkyNzFkOGY1ZmMwOWU4IiwiaWF0IjoxNjQ3OTU3ODI5LCJuYmYiOjE2NDc5NTc4MjksImV4cCI6MTY3OTQ5MzgyOSwic3ViIjoiODIiLCJzY29wZXMiOltdfQ.o-m4r7LQWsBm8Gdor-R_TMwseCDdhTi6aN72aoLDUOEEQ4OOWu6oLqsKbjAbZl4-aZFoaJmoPna7JI3rSPOgYrjgF52r3j19Oq8gLWWTujTaMd8lEBO1ufS83sdxYtSeMu5GyrgonqnojIrbGbbxFnQVYIXgoReLB_FMOAiYHLSn_gh3QyvWUDQPXbMOrwNyv5zG10jsDzlCsoOOUcIQ3NuPN9jEEJSais2asBYuWq0deWYuwP7pWPQMM8uhiEYZj1RGoxM11mDWq9ny4vqvd9UNzMFyJfd1gX7jNgX0bVrqJcsG8IULylqRYQHBidyMX3UQNAYpV7TQIa9wguXfAvH9Zc2Vb0Jj7Luwkd2GyiBy82283gOkeW7O3YRB8_fxmlQ2gf8ubyUUsHlkXwKi-EZNaDKTRJoxnQD8y4Gd4bL4Oh4oL_s4VP38slynJw7bpauQzXpXZtQQB4af4QVfYvng8wuaBBiMU3ixXARLoDEUklj2tX6LG1DzCHp5JQ199hMT8I_5uCiYw66jWdP38Y2piJx4689OlCxjt9C6CJzLBjXAibHBvf8epPbHF6XpVic87GLGbKcElXDOcCp9WCP-yhMHPRxBnQ3zqMKdgCWFNMyYQ567SmvlRg665Q2-ov4iSgrRV6kyLPv32aHRw5AwE8GRh_pmFBPHttN8DjI'
        }
    );

    final responseJson = jsonDecode(response.body);
    var body =response.body;
    var message = json.decode(body);
    print(message['message']);
    var userType = json.decode(body);
    print(userType['user_type']);

    if(response.statusCode == 200){
      print(response.body);
      if(userType['user_type']=="cleaner"){
        if(message['message'] == true){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Registration()),
          );
        }
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpControllerScreen(phone: _controller.text, dialCodeDigits: dialCodeDigits)),
        );
      }
      return userModelSplash.fromJson(responseJson);
    }
    else{
      print(response.statusCode);
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
    // getUser();

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
          body: Stack(
              children:[
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("Enter you mobile number.",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Ubuntu'
                    ),
                  ),
                ), // const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15,top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: constants.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2,color: constants.grey),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 0,right: 5, top: 0),
                      child: CountryCodePicker(
                          onChanged: (country){
                            setState(() {
                              dialCodeDigits = country.dialCode!;
                              // _controller.text = phone;
                            });
                          },
                        initialSelection: "CA",
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        favorite: const ["+1","US","+92","PAK"],
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              ),
                const SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text("Please confirm your country code & enter your mobile number to create an account or login.",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.normal
                  ),),
                ),
                const SizedBox(height: 490,),
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
                            "Get Started",
                            style: TextStyle(fontSize: 14,),
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(constants.blue2),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                                    side: BorderSide(color: constants.blue2)
                                )
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (c) =>  Registration()));
                            // Navigator.of(context).push(MaterialPageRoute(builder: (c) =>OtpControllerScreen(
                            //   phone: _controller.text,
                            //   dialCodeDigits: dialCodeDigits,
                            // ),),
                            // );
                            // print(phone);
                           //checkUser = fetchData(context);
                          }
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    ));
  }
}
