// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skep_home_pro/routes/routes.dart';
import 'package:skep_home_pro/shared/cache_helper.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'Back_ground_check/back_ground_check.dart';
import 'controllers/google_map_viow_model.dart';
import 'controllers/verifyed_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51KqbfwGDR1ZdiamSz86HTHDjzviSxYqAz97ZaHhYfV9FaNJ3uOvhk8CaFubGmcUS9CJTdTsux2Gp9RI67p6tvQu6000mrhbiTk';

  await GetStorage.init();
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //   apiKey: "XXX", // Your apiKey
    //   appId: "1:455546414239:ios:6b626376dc82aa82166eaa", // Your appId
    //   messagingSenderId: "XXX", // Your messagingSenderId
    //   projectId: "skephomecleaner", // Your projectId
    // ),
  );



  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {





  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414 , 895),
      child: GetMaterialApp(
        title: 'Skep Home',
        initialBinding: Binding(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.welcome,
        getPages: AppRoutes.routes,
      ),
    );
  }
}

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>GoogleMapViewModel() , fenix: true);
    Get.put<VerifyedController>(VerifyedController());

  }
}

