import 'package:flutter/material.dart';
import 'package:skep_home_pro/Dashboard/Dashboard.dart';
import 'package:skep_home_pro/constatns/constants.dart';

class getBackGround extends StatefulWidget {
  const getBackGround({Key? key}) : super(key: key);

  @override
  State<getBackGround> createState() => _getBackGroundState();
}

class _getBackGroundState extends State<getBackGround> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned(
              top: 15,
              right: 50,
              left: 50,
              child: Center(
                  child: Text(
                "Background Check",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold),
              ))),
          Positioned(
              top: 25,
              left: 30,
              right: 30,
              child: Image.asset(
                "assets/images/background_check.png",
                scale: 4,
              )),
          Positioned(
              top: 350,
              right: 40,
              left: 40,
              child: Center(
                child: Text(
                  " By clicking on get started , we will \nbegin the process of verifying your \nidentity. This process is completely \n                          secure",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu'),
                ),
              )),
          Positioned(
              top: 700,
              right: 40,
              left: 40,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()),
                    );
                  },
                  child: Text(
                    'Skip for Now',
                    style: TextStyle(
                        color: constants.blue2,
                        fontSize: 16,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
          Positioned(
            top: 750,
            right: 15,
            left: 15,
            child: Container(
              width: double.infinity,
              height: 35,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()),
                    );
                  },
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(constants.blue2),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            side: BorderSide(color: constants.blue))),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
