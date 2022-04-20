import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/TodaysList.dart';
import 'package:skep_home_pro/chatPage/chat.dart';
import 'package:skep_home_pro/chatPage/messages.dart';
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

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  token = pref.get('token').toString();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  Stripe.publishableKey = 'pk_test_51KqbfwGDR1ZdiamSz86HTHDjzviSxYqAz97ZaHhYfV9FaNJ3uOvhk8CaFubGmcUS9CJTdTsux2Gp9RI67p6tvQu6000mrhbiTk';


  runApp(GetMaterialApp(
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

//  runApp(HomePage());
}

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoogleMapViewModel(), fenix: true);
    Get.put<VerifyedController>(VerifyedController());
  }
}

var www;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = const Duration(seconds: 10);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token3 = pref.get('token3').toString();
    print('TTTTTTTTTTTTTTTTTTTTTTTT${token3}');
    if (pref.get('token').toString() == "null" &&
        pref.get('token3').toString() == "null") {
      Get.offNamed(Routes.first_walk_through);
    } else {
      Get.offNamed(Routes.dashboard);
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      Map<String, dynamic> dataValue = message.data;
      String screen = dataValue['screen'].toString();
      print("sss $screen");

      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.yellow,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
            payload: screen);
      }
    });

    var initializationAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelect);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
      }
    });

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

  Future<dynamic> onSelect(payload) async {

    print("aaaaaaaaaaaaaaaaasssssssss $payload");
    if (payload == '/chat') {
      Get.offNamed(Routes.chat);
    }
  }
}
