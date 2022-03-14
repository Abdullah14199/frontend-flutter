import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../routes/routes.dart';

class first_walk_through extends StatelessWidget {
  const first_walk_through({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: constants.yellow,
        child: Stack(
          children: [
            Positioned(
              left: 20,
              right: 0 ,
              bottom: -60,
              child: Image.asset("assets/images/cleaner.png"),
            ),
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Image.asset("assets/images/skep_home.png"),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: constants.blue,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(38), topRight: Radius.circular(38),)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 45,),
                    const Text("Cleaning On Demand" ,style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.all(40),
                      child: const Text("Book an appointment in less than 60 seconds and get on the schedule as early as tomorrow.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Skip", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),),
                        ),
                        Row(
                          children: [
                            const Text("Next", style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),),
                            const SizedBox(width: 5,),
                            SizedBox(
                              width: 40,
                              child: RawMaterialButton(
                                shape: const CircleBorder(),
                                elevation: 0.0,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                fillColor: constants.yellow,
                                onPressed: () {
                                  Get.offNamed(Routes.second_walk_through);
                                  },
                              ),
                            ),
                            // FloatingActionButton(
                            //   onPressed: () {
                            //     Get.offNamed(Routes.second_walk_through);
                            //   },
                            //   backgroundColor: constants.yellow,
                            //   child: const Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
