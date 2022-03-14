import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Login/login.dart';
import 'package:skep_home_pro/constatns/constants.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: constants.blue,
          child: Center(
            child: Stack(
              children:[
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image.asset("assets/images/large_logo.png"),
                const SizedBox(height: 25 ,),
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
                  Image.asset("assets/images/cleanersgetstart.png"),
                  const SizedBox(height: 80),

                ],
              ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    width: double.infinity,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_back),
                          label: const Text(
                            "Get Started",
                            style: TextStyle(fontSize: 14,),
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(constants.yellow),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                                    side: BorderSide(color: constants.yellow)
                                )
                            ),
                          ),
                          onPressed: () {
                            _modalBottomSheetMenu(context);
                          }
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(context){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          width: double.infinity,
          height: 150,
          decoration: const BoxDecoration(color: Colors.white ,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
            ),
          ),
          child: Stack(
            children:[
              const Positioned(
                top: 40,
                left: 10,
                child:  Text("Choose Account" , style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold
                ),),
              ),
              Column(
                children: [
                  const SizedBox(height:20,),
                  Container(
                    width: 150,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: constants.grey,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children:[
                      const Center(
                        child: CircleAvatar(
                          backgroundColor: constants.blue,
                          radius: 30,
                          backgroundImage: NetworkImage("https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png"),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      GestureDetector(
                        child: const Text("Use Another Account",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.normal
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ] ,
          ),
        ),
    );
  }
}
