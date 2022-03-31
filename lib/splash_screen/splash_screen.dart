import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/TodaysList.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/splash_screen/get_started.dart';
import '../Dashboard/Dashboard.dart';
import '../models/UserModel.dart';
import '../models/apiSplashScreenModels.dart';
import '../routes/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devlog;
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: SplashScreen(),
  ));

//  runApp(HomePage());
}

Future<User> fetchData(context) async {
  final response = await http.get(
      Uri.parse('https://staging.skephome.com/api/User/MyProfile'),
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1MSIsImp0aSI6IjUxODMzYTE0YmIzMGQ5OWU5NGNiODgyMzk0ZjU3NjgxZDBjYjY4NDRkYTlhYmVkY2Y1MDgyMzc1NDJjNGNmYWE4NTkyNzFkOGY1ZmMwOWU4IiwiaWF0IjoxNjQ3OTU3ODI5LCJuYmYiOjE2NDc5NTc4MjksImV4cCI6MTY3OTQ5MzgyOSwic3ViIjoiODIiLCJzY29wZXMiOltdfQ.o-m4r7LQWsBm8Gdor-R_TMwseCDdhTi6aN72aoLDUOEEQ4OOWu6oLqsKbjAbZl4-aZFoaJmoPna7JI3rSPOgYrjgF52r3j19Oq8gLWWTujTaMd8lEBO1ufS83sdxYtSeMu5GyrgonqnojIrbGbbxFnQVYIXgoReLB_FMOAiYHLSn_gh3QyvWUDQPXbMOrwNyv5zG10jsDzlCsoOOUcIQ3NuPN9jEEJSais2asBYuWq0deWYuwP7pWPQMM8uhiEYZj1RGoxM11mDWq9ny4vqvd9UNzMFyJfd1gX7jNgX0bVrqJcsG8IULylqRYQHBidyMX3UQNAYpV7TQIa9wguXfAvH9Zc2Vb0Jj7Luwkd2GyiBy82283gOkeW7O3YRB8_fxmlQ2gf8ubyUUsHlkXwKi-EZNaDKTRJoxnQD8y4Gd4bL4Oh4oL_s4VP38slynJw7bpauQzXpXZtQQB4af4QVfYvng8wuaBBiMU3ixXARLoDEUklj2tX6LG1DzCHp5JQ199hMT8I_5uCiYw66jWdP38Y2piJx4689OlCxjt9C6CJzLBjXAibHBvf8epPbHF6XpVic87GLGbKcElXDOcCp9WCP-yhMHPRxBnQ3zqMKdgCWFNMyYQ567SmvlRg665Q2-ov4iSgrRV6kyLPv32aHRw5AwE8GRh_pmFBPHttN8DjI'
      });
  final responseJson = jsonDecode(response.body);

  var body = response.body;
  var criminal_free = json.decode(body);
  print(criminal_free['user']['criminal_free']);
  if (response.statusCode == 200) {
    print(response.body);
    if (criminal_free['user']['criminal_free'] != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const backGroundCheck()),
      );
    }
    return User.fromJson(responseJson);
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GetStarted()),
    );
    throw Exception('Failed to load album');
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = const Duration(seconds: 10);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Get.offNamed(Routes.first_walk_through);
  }

  late Future<User> usersModel;

  @override
  void initState() {
    super.initState();
    startTime();
    // getUser();
    // usersModel = fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.blue,
      body: Center(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/skep_pro_base_logo.png",
              ),
              const SizedBox(
                height: 5,
              ),
              Image.asset("assets/images/skep_home_word.png"),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Clean Home, Clean Life.",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu'),
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Container(
              child: Center(
                child: SizedBox(
                    child: Lottie.network(
                        'https://assets9.lottiefiles.com/packages/lf20_B3VdZv.json',
                        width: 120)),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
