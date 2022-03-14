import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Dashboard/Dashboard.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/splash_screen/get_started.dart';
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

  // Future<userModel> fetchData(context) async{
  //   final response =await http
  //       .get(Uri.parse('https://staging.skephome.com/api/User/MyProfile'),
  //       headers: {
  //         HttpHeaders.authorizationHeader : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1MSIsImp0aSI6IjYzOGQ4Y2RmZmQzMGQ0MTQ4MDI3OTc0OGMyZDJiMmVmZTU4MmU5ODYxZDhhZTEwOTlmOWI3YzQ0OWRmNmIwYTk5ZmU1M2E3MDBkYWI1ZjQ4IiwiaWF0IjoxNjQ2NzM4MzM5LCJuYmYiOjE2NDY3MzgzMzksImV4cCI6MTY3ODI3NDMzOSwic3ViIjoiMjkiLCJzY29wZXMiOltdfQ.ZXO_CzXIBw6l2y64sl7waxlEfDqektgi_FZPqRGpCsNUmXVlVlM97YMDrmdXziD-VTrPAKwVi8dkWLnqx94Ov9PuAVLyO-s8xK2rRs8FExllhfa1u-LzXVdiJOjECZ1yutyICnWl4RYaROPGcUuojAkZR5xOYh-Q182YgFwlZlgZwH3WDAv8y2SixojnJ6oRlA4MSUCkpyfTiNuuhJ3NTf_MuUt-Md48thvkdpe5Jynags2CmpsacjHY6einZbvp74F_FdDHqA7ZDgn6HKrPdTyaBE2PiWQS5ujR54odwAZXzQfZ_zbioyGgmmjm-kkf2NeURNqvwha64nxg1TbmkH6v6xrjfghPOiOYMmWhOr2fQ6RKHS0Ck4CNtlwNDDywS1I0qR0mR2cmQgMrBth70LCSbG9PwtFrECRm2d6Vd2hxCxg8wHN3QHmDD6fApDzgqAVE1KSvFBcWO1qo9ZVCdBQ_9-C7GaiwMzb09hfW8QEd1RbABoqHgQzW97uzV7-_1bPCm5kUJcAAlPwpucUXqmU-iuBRf8BzTKS_8Lmp4-TNEEZx_VgeHLuTVoMEcV7I_DXswhjmY4leZrAefMIDparZbUhgTC5Aai1SDpX7qjTq1odQMi3fI3W_UgQT24GdxllKwg4gYJ0d92MBzLDOPAYSIgMVGKtT4Vo2SvFNUeE'
  //       }
  //   );
  //   final responseJson = jsonDecode(response.body);
  //   if(response.statusCode == 200){
  //     print(response.body);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const Dashboard()),
  //     );
  //     return userModel.fromJson(responseJson);
  //   }else{
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const GetStarted()),
  //     );
  //     throw Exception('Failed to load album');
  //   }
  // }

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {





  // void getUser() async{
  //   var accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1MSIsImp0aSI6IjYzOGQ4Y2RmZmQzMGQ0MTQ4MDI3OTc0OGMyZDJiMmVmZTU4MmU5ODYxZDhhZTEwOTlmOWI3YzQ0OWRmNmIwYTk5ZmU1M2E3MDBkYWI1ZjQ4IiwiaWF0IjoxNjQ2NzM4MzM5LCJuYmYiOjE2NDY3MzgzMzksImV4cCI6MTY3ODI3NDMzOSwic3ViIjoiMjkiLCJzY29wZXMiOltdfQ.ZXO_CzXIBw6l2y64sl7waxlEfDqektgi_FZPqRGpCsNUmXVlVlM97YMDrmdXziD-VTrPAKwVi8dkWLnqx94Ov9PuAVLyO-s8xK2rRs8FExllhfa1u-LzXVdiJOjECZ1yutyICnWl4RYaROPGcUuojAkZR5xOYh-Q182YgFwlZlgZwH3WDAv8y2SixojnJ6oRlA4MSUCkpyfTiNuuhJ3NTf_MuUt-Md48thvkdpe5Jynags2CmpsacjHY6einZbvp74F_FdDHqA7ZDgn6HKrPdTyaBE2PiWQS5ujR54odwAZXzQfZ_zbioyGgmmjm-kkf2NeURNqvwha64nxg1TbmkH6v6xrjfghPOiOYMmWhOr2fQ6RKHS0Ck4CNtlwNDDywS1I0qR0mR2cmQgMrBth70LCSbG9PwtFrECRm2d6Vd2hxCxg8wHN3QHmDD6fApDzgqAVE1KSvFBcWO1qo9ZVCdBQ_9-C7GaiwMzb09hfW8QEd1RbABoqHgQzW97uzV7-_1bPCm5kUJcAAlPwpucUXqmU-iuBRf8BzTKS_8Lmp4-TNEEZx_VgeHLuTVoMEcV7I_DXswhjmY4leZrAefMIDparZbUhgTC5Aai1SDpX7qjTq1odQMi3fI3W_UgQT24GdxllKwg4gYJ0d92MBzLDOPAYSIgMVGKtT4Vo2SvFNUeE";
  //   Dio dio = new Dio();
  //   dio.options.headers['content-Type'] = 'application/json';
  //   dio.options.headers["authorization"] = "Bearer $accessToken";
  //   var response = await dio.get("https://staging.skephome.com/api/User/MyProfile");
  //
  //   print(response);
  // }

  startTime() async {
    var _duration = const Duration(seconds: 10);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Get.offNamed(Routes.first_walk_through);
  }

  late Future<userModelSplash> usersModel;

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
          children: [ Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/skep_pro_base_logo.png",),
              const SizedBox(height: 5,),
              Image.asset("assets/images/skep_home_word.png"),
              const SizedBox(height: 5,),
              const Text("Clean Home, Clean Life.",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu'
                ),
              ),
            ],
          ),
            Positioned(bottom: 50, left: 20, right: 20,
              child: Container(
                child: Center(
                  child: SizedBox(
                      child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_B3VdZv.json',width: 120)
                ),
                ),
              ),
          ),

          ],
        )
      ),
    );
  }
}
