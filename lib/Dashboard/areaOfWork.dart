import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Future<List> fetchPosts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final response = await http.get(
        Uri.parse('https://staging.skephome.com/api/AreaOfWork/AllCitys'),
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer ${pref.get('token3').toString()}'
        });
    var responseJson = json.decode(response.body);
    print(responseJson);
    var body = response.body;
    var read = jsonDecode(body);
    // print(responseJson['AllCitys'][0]['region_lat_lng']);
    return (responseJson['AllCitys'] as List)
        .map((p) => AllCity.fromJson(p))
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

  List<AllCity>? posts;

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
                  Container(
                    child: ListView(
                      children: <Widget>[
                        FutureBuilder<List>(
                          future: fetchPosts(),
                          builder: (context, snapshot) {
                            print(snapshot.hasData);
                            if (snapshot.hasData) {
                              posts = snapshot.data as List<AllCity>?;
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 100, top: 93),
                    child: RoundCheckBox(
                      onTap: (value) {
                        controller.Etobicoke.value = value!;
                        EtobickoeVal = 0;
                        print(EtobickoeVal);
                        controller.myPolygon();
                      },
                      size: 30,
                      isChecked: controller.Etobicoke.value,
                      checkedColor: Colors.green,
                      uncheckedColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 100, top: 150),
                    child: RoundCheckBox(
                      onTap: (value) {
                        controller.Mississauga.value = value!;
                        MississaugaVal = 1 ;
                        controller.myPolygon();
                      },
                      size: 30,
                      isChecked: controller.Mississauga.value,
                      checkedColor: Colors.green,
                      uncheckedColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 100, top: 210),
                    child: RoundCheckBox(
                      onTap: (value) {
                        controller.Toronto.value = value!;
                        TorontoVal = 2 ;
                        controller.myPolygon();
                      },
                      size: 30,
                      isChecked: controller.Toronto.value,
                      checkedColor: Colors.green,
                      uncheckedColor: Colors.white,
                    ),
                  ),
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


var EtobickoeVal ;
var MississaugaVal ;
var TorontoVal ;

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
