// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skep_home_pro/routes/routes.dart';
import 'package:skep_home_pro/shared/cache_helper.dart';

import 'Back_ground_check/back_ground_check.dart';
import 'controllers/google_map_viow_model.dart';
import 'controllers/verifyed_controller.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "XXX", // Your apiKey
      appId: "1:389584921781:ios:fa10c18de8288c748b4afc", // Your appId
      messagingSenderId: "XXX", // Your messagingSenderId
      projectId: "skephomecleaner", // Your projectId
    ),
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Skep Home',
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.routes,
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

