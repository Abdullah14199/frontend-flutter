import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/Calendar.dart';
import 'package:skep_home_pro/Dashboard/Today\'s_Schedule.dart';
import 'package:skep_home_pro/Dashboard/rating_screen.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/Dashboard/service_request_list.dart';
import 'package:skep_home_pro/Login/login.dart';
import 'package:skep_home_pro/MyBooking/schedule.dart';
import 'package:skep_home_pro/Referral%20Program/referral_program.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/routes/routes.dart';
import 'package:http/http.dart' as http;

import '../Back_ground_check/verificationAccount.dart';
import '../Login/edit_profile.dart';
import '../Payment_Stripe/payment_stripe.dart';
import '../Settings/settings.dart';
import '../Support Center/support_center_menu.dart';
import '../controllers/verifyed_controller.dart';
import '../models/UserModel.dart';
import '../models/userModelSignUp.dart';
import '../models/verifyed_model.dart';
import '../shared/cache_helper.dart';
import '../splash_screen/splash_screen.dart';
import 'TodaysList.dart';
import 'areaOfWork.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}
var idCleaner ;
var idCleaner2 ;

Future<UserModel> fetchData(context) async {

  SharedPreferences pref = await SharedPreferences.getInstance();
  final response = await http.get(
    Uri.parse('http://staging.skephome.com/api/User/MyProfile'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${pref.get('token3').toString()}'
    },
  );
  final responseJson = jsonDecode(response.body);

  if (response.statusCode == 200) {
    print(responseJson);

    var body = response.body;

    var email = jsonDecode(body);
    EmailUser = email['user']['email'] ;
    print(EmailUser);

    var firstName = jsonDecode(body);
    FirstName = firstName['user']['first_name'];

    var phone = jsonDecode(body);
    Phone = phone['user']['phone'];
    print(Phone);


    var lastName = jsonDecode(body);
    LastName = lastName['user']['last_name'];

    var level = jsonDecode(body);
    Level = level['user']['level'];
    print(Level);

    var level_statues = jsonDecode(body);
    Level_statues = level_statues['user']['level_status'];
    print(Level_statues);

    var selfie = jsonDecode(body);
    Selfie = selfie['user']['selfie'];

    var id_cleaner = jsonDecode(body);
    idCleaner = id_cleaner['user']['id'];
    SharedPreferences pref = await SharedPreferences.getInstance();
    idCleaner2 = pref.setInt('idCleaner', idCleaner);

    return UserModel.fromJson(responseJson);
  } else {
    print(response.statusCode);
    print(responseJson);

    throw Exception('Failed to load album');
  }
}

var FCMToken ;
var userID ;
var userIDFirebase ;

class _DashboardState extends State<Dashboard> {
  @override
  void initState(){
    super.initState();
     fetchData(context);

    FirebaseMessaging.instance.getToken().then((newToken) async{
      print("FCM Token");
      print(newToken);

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('FCMToken', newToken!);

      FCMToken = pref.get('FCMToken').toString();

      User? user ;
      User? userData = FirebaseAuth.instance.currentUser;
      user = userData;
      print("CCCCCCCCCC${userData?.uid}");
      userIDFirebase = userData?.uid;
      print("HAHAHAHAHAHAHAHA ${userIDFirebase}");
      pref.setString('userID', userIDFirebase);
      userID = pref.get('userID').toString();


    });
  }

  int currentIndex = 0;
  final List _pages = [
    TodaysList(),
    CalendarScreen(),
    serviceRequestList(),
  ];

  @override
  Widget build(BuildContext context) {
    print("sadasd ${token3}");
    return GetBuilder<VerifyedController>(
      init: VerifyedController(),
      builder:(controller){
        // controller.getVerifyed();

        return SafeArea(
          child: Scaffold(
            body: Center(
              child: _pages.elementAt(currentIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 0,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/home.png")),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage("assets/images/nosBottomNavigationBar.png")),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/dashboard.png")),
                  label: '',
                ),
              ],
              // currentIndex: _selectedIndex,
              selectedItemColor: constants.blue2,
              onTap: (index) => setState(() {
                currentIndex = index;
              }),
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              // showUnselectedLabels: false,
            ),
            drawer: ClipRRect(
              child: Drawer(
                backgroundColor: Colors.white,
                child: ListView(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 150,
                      child: DrawerHeader(
                        decoration: const BoxDecoration(
                          color: constants.blue2,
                        ),
                        child: Stack(children: [
                          Positioned(
                            child:
                            Image.asset("assets/images/profile_decore_img.png"),
                            top: 17,
                            left: 2,
                            bottom: 24,
                          ),
                          Positioned(
                            top: 70,
                            left: 145,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  EditProfile()),
                                );
                              },
                              child: Row(
                                children: [
                                  const Text(
                                    "Edit Profile",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                    },
                                    icon: Image.asset(
                                      "assets/images/edit.png",
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 22,
                            left: 16,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://staging.skephome.com/storage/${Selfie}"),
                              radius: 30,
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 100,
                            right: 40,
                            child: Text(
                              "Hi ${FirstName} , ",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Ubuntu '),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 100,
                            right: 40,
                            child: Text(
                              "Welcome Back",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Ubuntu '),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 95,
                            child: Container(
                              width: 60,
                              height: 100,
                              child: IconButton(
                                onPressed: () {},
                                icon: Level == "one"
                                    ? Image.asset(
                                  "assets/images/silver_badge_img.png",
                                  width: 200,
                                  height: 100,
                                )
                                    : Level == "two"
                                    ? Image.asset(
                                    "assets/images/gold_shield_img.png",
                                    width: 200,
                                    height: 69)
                                    : Level == "three" ? Image.asset(
                                    "assets/images/bronz_badge_img.png",
                                    width: 200,
                                    height: 69
                                ) : Image.asset(
                                    "assets/images/bronz_badge_img.png"),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 73,
                            left: 160,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ratingScreen()),
                                );
                                },
                              child: Container(
                                width: 50,
                                height: 15,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child:  Text(
                                  "   $Level_statues",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 70,
                            left: 150,
                            child:  CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: Level_statues == "Awesome" ? AssetImage("assets/images/ic_colored_awesome.PNG") :
                              Level_statues == "Great" ? AssetImage("assets/images/ic_colored_great.PNG") :
                              Level_statues == "Good" ? AssetImage("assets/images/ic_colored_good.PNG") :
                              Level_statues == "Meh" ? AssetImage("assets/images/ic_colored_meh.PNG") :
                              Level_statues == "Bad" ? AssetImage("assets/images/ic_colored_bad.PNG") : AssetImage("assets/images/ic_colored_great.PNG"),
                              radius: 10,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      selected: true,
                      leading: Container(
                        width: 20,
                        height: 30,
                        child: Image.asset(
                          "assets/images/homeMenu.png",
                          color: constants.blue2,
                        ),
                      ),
                      title: const Text(
                        'Home',
                        style: TextStyle(color: Colors.black , fontSize: 12),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: constants.grey,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      selected: true,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const accountVerification()),
                        );
                      },
                      trailing: controller.verifyed != false ? SizedBox() : Container( width : 7 , height: 20 ,child: Image.asset("assets/images/Ellipse 539.png")),
                      leading: Container(
                        width: 20,
                        height: 30,
                        child: Image.asset(
                          "assets/images/shield.png",
                          color: controller.verifyed !=false ? constants.blue2 : Colors.red,
                        ),
                      ),
                      title:  Text('Account verification',
                          style: TextStyle(color: controller.verifyed != false ?  Colors.black : Colors.red , fontSize: 12)),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: constants.grey,
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Schedule()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      selected: true,
                      leading: Container(
                        width: 20,
                        height: 30,
                        child: Image.asset(
                          "assets/images/calendar-4.png",
                          color: constants.blue2 ,
                        ),
                      ),
                      title: Text('My Bookings',
                          style: TextStyle(color: Colors.black  , fontSize: 12)),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: constants.grey,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      selected: true,
                      leading: Container(
                        width: 20,
                        height: 30,
                        child: Image.asset(
                          "assets/images/credit-card.png",
                          color: constants.blue2,
                        ),
                      ),
                      title: const Text('Payment Options',
                          style: TextStyle(color: Colors.black , fontSize: 12)),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PaymentStripe()),
                        );
                      },
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: constants.grey,
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AreaOfWork()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      selected: true,
                      leading: Container(
                        width: 20,
                        height: 30,
                        child: Image.asset(
                          "assets/images/address.png",
                          color: constants.blue2,
                        ),
                      ),
                      title: const Text('Area Of Work',
                          style: TextStyle(color: Colors.black , fontSize: 12)),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: constants.grey,
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const settingsScreen()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      selected: true,
                      leading: Container(
                        width: 20,
                        height: 30,
                        child: Image.asset(
                          "assets/images/settings.png",
                          color: constants.blue2,
                        ),
                      ),
                      title: const Text('Settings',
                          style: TextStyle(color: Colors.black , fontSize: 12)),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: constants.grey,
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ReferralProgram()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      selected: true,
                      leading: Container(
                        width: 20,
                        height: 30,
                        child: Image.asset(
                          "assets/images/group.png",
                          color: constants.blue2,
                        ),
                      ),
                      title: const Text('Referral Program',
                          style: TextStyle(color: Colors.black , fontSize: 12)),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: constants.grey,
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  SupportCenterMenu()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      selected: true,
                      leading: Container(
                        width: 20,
                        height: 30,
                        child: Image.asset(
                          "assets/images/support.png",
                          color: constants.blue2,
                        ),
                      ),
                      title: const Text('Support Center',
                          style: TextStyle(color: Colors.black , fontSize: 12)),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: constants.grey,
                    ),
                    SizedBox(height: 70,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text('Version 2.0.14.1' , style: TextStyle(color: constants.blue2),),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
bool Silver = false ;
bool Gold = false ;
bool Platinum = false ;

void level(){
  if(Level == 'one'){
    Image.asset("assets/images/bronz_badge_img.png");
    Silver = true;
  }else if(Level == 'two'){
    Image.asset("assets/images/bronz_badge_img.png");
    Gold = true;
  }else if(Level == 'three'){
    Image.asset("assets/images/bronz_badge_img.png");
    Platinum = true;
  }
}