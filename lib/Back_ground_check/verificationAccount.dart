import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Dashboard/Today\'s_Schedule.dart';
import 'package:skep_home_pro/Dashboard/TodaysList.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/certn_verifyed_controller.dart';

import '../Dashboard/areaOfWork.dart';
import '../Dashboard/service_request.dart';
import '../routes/routes.dart';
import '../shared/cache_helper.dart';
import 'back_ground_check.dart';

class accountVerification extends StatefulWidget {
  const accountVerification({Key? key}) : super(key: key);

  @override
  State<accountVerification> createState() => _accountVerificationState();
}

bool isVerified = true;

class _accountVerificationState extends State<accountVerification> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CertnVerifyedController>(
        init: CertnVerifyedController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
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
                title: Center(
                  child: Text(
                    "Account Verification",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "At Skep Home, we always focus on the best service \n & customer satisfaction. With the account verification \n Requirements below, we aim to insure the comfort & \n Reliability for all users.",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Ubuntu'),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 3, right: 3),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        color: Colors.white,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: constants.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${Phone} - Verified",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: constants.grey,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 3, right: 3),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            border: Border.all(color:controller.EmailVerifiedBool == false ? constants.red : Colors.white)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: controller.EmailVerifiedBool == false ?  constants.red : constants.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Image.asset(
                                  "assets/images/email.png",
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email Address",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  controller.EmailVerifiedBool == false?
                                  "${EmailUser} - Not Verified" : "${EmailUser} - Verified",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: constants.grey,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            // SizedBox( width:  20,),
                            Padding(
                              padding: const EdgeInsets.only(left: 1.0),
                              child: controller.EmailVerifiedBool == false ? ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            constants.red),
                                    fixedSize:
                                        MaterialStateProperty.all<Size?>(
                                            Size(20, 20)),
                                  ),
                                  onPressed: () {
                                    controller.postUpdateEmail();
                                  },
                                  child: Text(
                                    'verify',
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Ubuntu'),
                                  )) : SizedBox(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 3, right: 3),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          controller.certin_status == "Analizing" ?
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Skep Pro.'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Text('If you facing any issues please contact support.'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('CANCEL'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('CONTACT SUPPORT'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }) : print("");
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              border: Border.all(color:  controller.certin_status == "incomplete"
                                  ? constants.red
                                  : controller.certin_status ==
                                  "Analizing"
                                  ? constants.yellow
                                  : constants.green)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color:
                                          controller.certin_status == "incomplete"
                                              ? constants.red
                                              : controller.certin_status ==
                                                      "Analizing"
                                                  ? constants.yellow
                                                  : constants.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Image.asset(
                                    "assets/images/surface1.png",
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Background Check",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${controller.certin_status}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: constants.grey,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}