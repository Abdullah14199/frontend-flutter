import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/TodaysList.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/splash_screen/get_started.dart';
import '../Dashboard/Dashboard.dart';
import '../Login/login.dart';
import '../controllers/google_map_viow_model.dart';
import '../controllers/verifyed_controller.dart';
import '../models/UserModel.dart';
import '../models/apiSplashScreenModels.dart';
import '../routes/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devlog;
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';

void main()async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  token= pref.get('token').toString();
  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialBinding: Binding(),
    home: SplashScreen(),
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "XXX", // Your apiKey
      appId: "1:389584921781:ios:fa10c18de8288c748b4afc", // Your appId
      messagingSenderId: "XXX", // Your messagingSenderId
      projectId: "skephomecleaner", // Your projectId
    ),
  );

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

//  runApp(HomePage());
}


class Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>GoogleMapViewModel() , fenix: true);
    Get.put<VerifyedController>(VerifyedController());

  }
}
var www ;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = const Duration(seconds: 10);
    return Timer(_duration, navigationPage);
  }



  void navigationPage()async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token3 = pref.get('token3').toString();
    print('FFFFFFFFFFFFFFFFFFFFFFFF${www}');
    print('TTTTTTTTTTTTTTTTTTTTTTTT${token3}');
      if(pref.get('token').toString() == "null" && pref.get('token3').toString() == "null"){
        Get.offNamed(Routes.first_walk_through);
      }else{
        Get.offNamed(Routes.dashboard);
      }
  }


  @override
  void initState() {
    super.initState();
    startTime();
    //fetchData(context);
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
