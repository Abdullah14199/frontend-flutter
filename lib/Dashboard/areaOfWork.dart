import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:http/http.dart' as http;
import 'package:skep_home_pro/models/allCitiesModel.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../Back_ground_check/back_ground_check.dart';
import '../controllers/google_map_viow_model.dart';

class AreaOfWork extends StatefulWidget {
  const AreaOfWork({Key? key}) : super(key: key);

  @override
  State<AreaOfWork> createState() => _AreaOfWorkState();
}

class _AreaOfWorkState extends State<AreaOfWork> {
  final Completer<GoogleMapController> _controller = Completer();

  final controller = Get.find<GoogleMapViewModel>();

  // AreaOfWork/AllCitys
  Future<List<AllCitys>> fetchPosts() async {
    final response = await http.get(
        Uri.parse('https://staging.skephome.com/api/AreaOfWork/AllCitys'),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer $token'
        });
    var responseJson = json.decode(response.body);
    print(responseJson);
    // print(responseJson['AllCitys'][0]['region_lat_lng']);
    return (responseJson['AllCitys'] as List)
        .map((p) => AllCitys.fromJson(p))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    level();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
        title: const Padding(
          padding: EdgeInsets.only(left: 90),
          child: Text(
            "Area of work",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      ),
      drawer:  ClipRRect(
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
                      top: 10,
                      bottom: 30,
                    ),
                    Positioned(
                      top: 70,
                      left: 145,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Text(
                              "Edit Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {},
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
                      top: 15,
                      left: 13,
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
                          icon: Silver == true
                              ? Image.asset(
                            "assets/images/silver_badge_img.png",
                            width: 200,
                            height: 69,
                          )
                              : Gold == true
                              ? Image.asset(
                              "assets/images/gold_shield_img.png",
                              width: 200,
                              height: 69)
                              : Image.asset(
                              "assets/images/bronz_badge_img.png",
                              width: 200,
                              height: 69),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 73,
                      left: 160,
                      child: Container(
                        width: 50,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Text(
                          "    Great",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 150,
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                        AssetImage("assets/images/ic_colored_great.PNG"),
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
                leading: Image.asset(
                  "assets/images/homeMenu.png",
                  color: constants.blue2,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: constants.grey,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                selected: true,
                leading: Image.asset(
                  "assets/images/shield.png",
                  color: constants.blue2,
                ),
                title: const Text('Account verification',
                    style: TextStyle(color: Colors.black)),
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: constants.grey,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                selected: true,
                leading: Image.asset(
                  "assets/images/calendar-4.png",
                  color: constants.blue2,
                ),
                title: const Text('My Bookings',
                    style: TextStyle(color: Colors.black)),
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: constants.grey,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                selected: true,
                leading: Image.asset(
                  "assets/images/credit-card.png",
                  color: constants.blue2,
                ),
                title: const Text('Payment Options',
                    style: TextStyle(color: Colors.black)),
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: constants.grey,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                selected: true,
                leading: Image.asset(
                  "assets/images/address.png",
                  color: constants.blue2,
                ),
                title: const Text('Area Of Work',
                    style: TextStyle(color: Colors.black)),
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: constants.grey,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                selected: true,
                leading: Image.asset(
                  "assets/images/settings.png",
                  color: constants.blue2,
                ),
                title: const Text('Settings',
                    style: TextStyle(color: Colors.black)),
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: constants.grey,
              ),
              ListTile(

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                selected: true,
                leading: Image.asset(
                  "assets/images/group.png",
                  color: constants.blue2,
                ),
                title: const Text('Referral Program',
                    style: TextStyle(color: Colors.black)),
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: constants.grey,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                selected: true,
                leading: Image.asset(
                  "assets/images/support.png",
                  color: constants.blue2,
                ),
                title: const Text('Support Center',
                    style: TextStyle(color: Colors.black)),
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: constants.grey,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Obx(()=> Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  "Province",
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: "Ontario",
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: constants.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: constants.grey),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  readOnly: true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  "City",
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 8),
                child: Text(
                  "You can select more than one area",
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: constants.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        _modalBottomSheetMenu(context, controller);
                      },
                      icon: Icon(Icons.keyboard_arrow_down),
                    ),
                    fillColor: constants.grey,
                    labelText: "Multiple Area Selection",
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: constants.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: constants.grey),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 20, bottom: 20),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: GoogleMap(
                      polygons: controller.myPolygon(),
                      mapType: MapType.normal,
                      zoomControlsEnabled: false,
                      scrollGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(43.68471379096746, -79.50960394822533),
                          zoom: 9.5),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    fetchPosts();
                  },
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: constants.blue2,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Center(
                        child: Text(
                          "Save Changes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    ));
  }

  List<AllCitys>? posts;

  void _modalBottomSheetMenu(
    context,
    GoogleMapViewModel controller,
  ) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              width: double.infinity,
              height: 420,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 40,
                    left: 10,
                    child: Text(
                      "Select City",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                          FutureBuilder<List<AllCitys>>(
                            future: fetchPosts(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                posts = snapshot.data;
                                return Padding(
                                  padding:
                                  const EdgeInsets.only(left: 70, top: 60),
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: posts!
                                          .map((post) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: 40),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              post.regionName,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontFamily: 'Ubuntu',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                          .toList()),
                                );
                              }
                              return Center(
                                child: Column(
                                  children: const <Widget>[
                                    Padding(padding: EdgeInsets.all(50.0)),
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 82,
                      left: -20,
                      right: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 380, top: 8),
                        child: RoundCheckBox(
                          onTap: (value) {
                            controller.Etobicoke.value = value!;
                            controller.myPolygon();
                          },
                          size: 40,
                          isChecked: controller.Etobicoke.value,
                          checkedColor: Colors.green,
                          uncheckedColor: Colors.white,
                        ),
                      )),
                  Positioned(
                      top: 142,
                      left: -20,
                      right: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 380, top: 8),
                        child: RoundCheckBox(
                          onTap: (value) {
                            controller.Mississauga.value = value!;
                            controller.myPolygon();
                          },
                          size: 40,
                          isChecked: controller.Mississauga.value,
                          checkedColor: Colors.green,
                          uncheckedColor: Colors.white,
                        ),
                      )),
                  Positioned(
                      top: 202,
                      left: -20,
                      right: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 380, top: 8),
                        child: RoundCheckBox(
                          onTap: (value) {
                            controller.Toronto.value = value!;
                            controller.myPolygon();
                          },
                          size: 40,
                          isChecked: controller.Toronto.value,
                          checkedColor: Colors.green,
                          uncheckedColor: Colors.white,
                        ),
                      )),
                  Positioned(
                    top: 340,
                    left: 40,
                    right: 40,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: constants.blue2,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: const Center(
                          child: Text(
                            "Select Area",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
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