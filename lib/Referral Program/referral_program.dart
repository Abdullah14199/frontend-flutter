import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/referralProgramController.dart';

class ReferralProgram extends StatefulWidget {
  const ReferralProgram({Key? key}) : super(key: key);

  @override
  State<ReferralProgram> createState() => _ReferralProgramState();
}

class _ReferralProgramState extends State<ReferralProgram> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<RefeeralProgramController>(
      init: RefeeralProgramController(),
      builder: (controller) => Scaffold(
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
          title: const Center(
            child: Text(
              "Referral Program",
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Balance" , style: TextStyle(fontSize: 16 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , ),),
            ) ,
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                  controller.ReferalBalance == null ? "\$ 0" : "\$ ${controller.ReferalBalance}" ,
                  style: TextStyle(fontSize: 18 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , )),
            ) ,
            Container(
                width: 300,
                height: 250,
                child: Image.asset("assets/images/ic_referral_gift.PNG")),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Refer & Earn" , style: TextStyle(fontSize: 16 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , )),
            ) ,
            Padding(
              padding: const EdgeInsets.only(top: 8.0 , left: 25 , right: 25),
              child: Text("Share this code with a friend and you both get \$20 credit added to your account when they complete thier first booking"  , style: TextStyle(fontSize: 14 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.normal , )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0 , right: 25.0 , top: 30),
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                    color: constants.blue4,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Text( controller.ReferalCode , style: TextStyle(fontSize: 40 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.white )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 80.0 , right: 80 , top: 12),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: constants.yellow,
                          ),
                          onPressed: () async{
                            Share.share("Get 20\$ off on your new booking from Skep Pro.You will love their services \n\n Use this code during registration : ${controller.ReferalCode} \n\n Download the app : http://onelink.to/${controller.ReferalCode}");
                          },
                          child: Text("Share Code"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }


}
