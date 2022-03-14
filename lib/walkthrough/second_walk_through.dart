import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/splash_screen/get_started.dart';

import '../routes/routes.dart';

class second_walk_through extends StatelessWidget {
  const second_walk_through({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: constants.yellow,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Image.asset("assets/images/skep_home.png"),
              ),
              const Text("Clean Home",style: TextStyle(
                fontSize: 37,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu'
              ),),
              const Text("Clean Life.",style: TextStyle(
                  fontSize: 37,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu'
              ),),
              const SizedBox(height: 10,),
              const Text("Book Cleaners at the Comfort \n"
              " \t\t           of you home.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal
              ),),
              const SizedBox(height: 0,),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                        bottom:-60 ,
                        left: 0,
                        right: 0,
                        child: Image.asset("assets/images/cleaners.png")),
                    Positioned(
                      bottom:-20,
                        left: 220,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const GetStarted()),
                                  );
                                },
                                child: Container(
                                  width: 191,
                                  height: 74,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50),)
                                  ),
                                  child: const Center(
                                    child: Text("Get Started" ,
                                      style: TextStyle(
                                      color: constants.yellow,
                                      fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Ubuntu' ,
                                      ),),
                                  ),
                        ),
                              ),
                            )
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
