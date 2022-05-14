import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/service_request_list_controller.dart';
import 'package:skep_home_pro/routes/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Back_ground_check/back_ground_check.dart';
import '../controllers/scheduleDate.dart';
import '../models/updateProfileApi.dart';
import 'areaOfWork.dart';

class serviceRequestList extends StatefulWidget {
  const serviceRequestList({Key? key}) : super(key: key);

  @override
  State<serviceRequestList> createState() => _serviceRequestListState();
}

class _serviceRequestListState extends State<serviceRequestList> {
  bool isTextFiledFocus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serviceController.checkService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<ServiceRequestListController>(
          init: ServiceRequestListController(),
          builder: (controller) {
            return Scaffold(
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
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                  iconTheme: const IconThemeData(color: Colors.black),
                  title: Center(
                    child: Text(
                      "Service Request",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                ),
                body: ConditionalBuilder(
                  builder: (BuildContext context) =>  SingleChildScrollView(
                    child: Column(
                      children: [
                        controller.backcheck == false ||  controller.areacheck == false || controller.profilecheck == false ? buildServiceRequest() : buildTodayList()
                      ],
                    ),
                  ) ,
                  condition: controller.isLoadingCheck,
                  fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),
                )
            ) ;
          } ,
        )
    );
  }

  Widget buildTodayList() => GetBuilder<ServiceRequestListController>(
    init: ServiceRequestListController(),
    builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          controller.serviceRequestList.length == 0
              ? Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                Image.asset("assets/images/cleanerone.png"),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "No Cleaning Jobs",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Center(
                  child: Text(
                    "Sorry there are no cleaning requests right now. \n               Try refreshing in a few minutes",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 180,
                    height: 45,
                    decoration: const BoxDecoration(
                        color: constants.yellow,
                        borderRadius:
                        BorderRadius.all(Radius.circular(8))),
                    child: const Center(
                      child: Text(
                        "Refresh",
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
              ],
            ),
          )
              : ListView.builder(
            itemCount: controller.serviceRequestList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Container(
              width: MediaQuery.of(context).size.width,
              padding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 55.0,
                            height: 55.0,
                            child:  CircleAvatar(
                              backgroundImage: NetworkImage( controller.serviceRequestList[index].image != null ?
                              "https://staging.skephome.com/storage/${controller.serviceRequestList[index].image}" : "https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png"),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.serviceRequestList[index].readableDate,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Ubuntu',
                                    color: constants.grey),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Text(
                                    controller.serviceRequestList[index].fullName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 160,
                                  ),
                                  Text(
                                    controller.serviceRequestList[index].salary.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                controller.serviceRequestList[index].placeAddress,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        ImageIcon(AssetImage(
                                            "assets/images/calendar-6.png")),
                                        Text(
                                          controller.serviceRequestList[index].date,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.bold,
                                              fontFamily: 'Ubuntu'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage(
                                            "assets/images/clock.png"),
                                      ),
                                      Text(
                                        controller.serviceRequestList[index].time,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily: 'Ubuntu'),
                                      ),
                                      SizedBox(
                                        width: 110,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 73,
                                    height: 21.94,
                                    decoration: BoxDecoration(
                                      color: constants.lightGrey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        ImageIcon(AssetImage(
                                            "assets/images/refresh.png")),
                                        Text(
                                          controller.serviceRequestList[index].frequency,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Ubuntu'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 73,
                                    height: 21.94,
                                    decoration: BoxDecoration(
                                      color: constants.lightGrey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "(${controller.serviceRequestList[index].rate}/5)",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Ubuntu'),
                                        ),
                                        ImageIcon(
                                          AssetImage(
                                              "assets/images/star.png"),
                                          color: constants.yellow,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Container(
                                  width: 170,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) =>
                                            Container(
                                              width: double.infinity,
                                              height: 150,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(50),
                                                  topRight: Radius.circular(50),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    height: 5,
                                                    decoration: const BoxDecoration(
                                                      color: constants.grey,
                                                      borderRadius: BorderRadius.all(Radius.circular(2)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 15.0),
                                                    child: Text("Reject cleaning service Request" , style: TextStyle(fontSize: 15 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 50, right: 20, top: 15),
                                                    child: Center(
                                                        child: Text(
                                                          "Please confirm that you want to reject this cleaning service request.",
                                                          style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , color: constants.darkgrey),
                                                        )),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20.0, left: 20),
                                                        child: Container(
                                                          width: 170,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 20.0),
                                                            child: ElevatedButton(
                                                                style: ButtonStyle(
                                                                    foregroundColor:
                                                                    MaterialStateProperty.all<
                                                                        Color>(Colors.white),
                                                                    backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                        Color>(constants.red),
                                                                    shape: MaterialStateProperty.all<
                                                                        RoundedRectangleBorder>(
                                                                      RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                    )),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    controller.postReject(controller.serviceRequestList[index].id);
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                                child: Text("Reject")),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20.0, right: 20),
                                                        child: Container(
                                                          width: 170,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 20.0),
                                                            child: ElevatedButton(
                                                                style: ButtonStyle(
                                                                    foregroundColor:
                                                                    MaterialStateProperty.all<
                                                                        Color>(Colors.white),
                                                                    backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                        Color>(constants.grey),
                                                                    shape: MaterialStateProperty.all<
                                                                        RoundedRectangleBorder>(
                                                                      RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                    )),
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Text("Cancel")),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                      );
                                    },
                                    child: Text("Reject"),
                                    style: ButtonStyle(
                                        foregroundColor:
                                        MaterialStateProperty.all<
                                            Color>(Colors.white),
                                        backgroundColor:
                                        MaterialStateProperty.all<
                                            Color>(constants.red),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8)),
                                        )),
                                  )),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Container(
                                width: 170,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) =>
                                          Container(
                                            width: double.infinity,
                                            height: 150,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                topRight: Radius.circular(50),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 150,
                                                  height: 5,
                                                  decoration: const BoxDecoration(
                                                    color: constants.grey,
                                                    borderRadius: BorderRadius.all(Radius.circular(2)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 15.0),
                                                  child: Text("Accept cleaning service Request" , style: TextStyle(fontSize: 15 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold),),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 50, right: 20, top: 15),
                                                  child: Center(
                                                      child: Text(
                                                        "Please confirm that you want to accept this cleaning service request.",
                                                        style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , color: constants.darkgrey),
                                                      )),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 20.0, left: 20),
                                                      child: Container(
                                                        width: 170,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 20.0),
                                                          child: ElevatedButton(
                                                              style: ButtonStyle(
                                                                  foregroundColor:
                                                                  MaterialStateProperty.all<
                                                                      Color>(Colors.white),
                                                                  backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                      Color>(constants.green),
                                                                  shape: MaterialStateProperty.all<
                                                                      RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            8)),
                                                                  )),
                                                              onPressed: () {
                                                                setState(() {
                                                                  controller.postAccept(controller.serviceRequestList[index].id);
                                                                  Navigator.pop(context);
                                                                });
                                                              },
                                                              child: Text("Accept")),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 20.0, right: 20),
                                                      child: Container(
                                                        width: 170,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 20.0),
                                                          child: ElevatedButton(
                                                              style: ButtonStyle(
                                                                  foregroundColor:
                                                                  MaterialStateProperty.all<
                                                                      Color>(Colors.white),
                                                                  backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                      Color>(constants.grey),
                                                                  shape: MaterialStateProperty.all<
                                                                      RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            8)),
                                                                  )),
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: Text("Cancel")),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                    );
                                  },
                                  child: Text("Accept"),
                                  style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all<
                                          Color>(Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<
                                          Color>(constants.green),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8)),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );
    } ,
  );

  Widget buildServiceRequest() => GetBuilder<ServiceRequestListController>(
    init: ServiceRequestListController(),
    builder: (controller) {
      return Column(
            children: [
              Center(child: Image.asset("assets/images/service_request.png")),
              Center(
                child: Text(
                  "Skep Pro Services helps you find the best.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Center(
                child: Text(
                  "cleaning job opportunities near you by",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Center(
                child: Text(
                  "connecting you to local homeowners.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 280,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        _backgroundCheck('Background check', Colors.white),
                        _page('Profile Picture', Colors.white),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 230,
                      left: 350,
                      right: 15,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 2,
                        effect: WormEffect(),
                        onDotClicked: (index) => _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.bounceOut),
                      ))
                ]
              ),
            ],
          );
    } ,
  );

  Future pickCamera() async {
    final myFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 60);
    setState(() {
      _file = File(myFile!.path);
      if (_file == null) return;
      _futureAlbum = serviceController.editUserData(_file);
    });
  }
  final serviceController = Get.put(ServiceRequestListController());


  _page(String s, Color color) {
    return Container(
        color: color,
        child: Stack(children: [
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Text(
              s,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          Positioned(
            top: 15,
            left: 270,
            right: 20,
            child: ElevatedButton(
              child: const Text("Upload Now",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  )),
              onPressed: () {
                setState(() {
                  pickCamera();
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(constants.blue2),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        side: BorderSide(color: constants.blue2))),
              ),
            ),
          ),
          const Positioned(
            top: 36,
            left: 15,
            right: 15,
            child: Text(
              "Take a real profile picture",
              style: TextStyle(
                  color: constants.blue2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          const Positioned(
            top: 70,
            left: 15,
            right: 15,
            child: Text(
              "Your photo will make it easier for homeowners to Recognize you.",
              style: TextStyle(
                  color: constants.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          const Positioned(
              top: 230,
              right: 30,
              left: 320,
              child: Text(
                "2/2",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                ),
              ))
        ]));
  }

  _backgroundCheck(String s, Color color) {
    return Container(
      color: color,
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Text(
              s,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          Positioned(
            top: 15,
            left: 250,
            right: 15,
            child: ElevatedButton(
              child: Text("Complete Now"),
              onPressed: () {
                //createAlbum();
                // postCertn();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(constants.blue2),
                shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        side: BorderSide(color: constants.blue2))),
              ),
            ),
          ),
          const Positioned(
            top: 36,
            left: 15,
            right: 15,
            child: Text(
              "3 steps left",
              style: TextStyle(
                  color: constants.blue2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          Positioned(
            top: 70,
            left: 15,
            right: 15,
            child: Container(
              width: 40,
              height: 10,
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: 0,
                  valueColor: AlwaysStoppedAnimation<Color>(constants.yellow),
                  backgroundColor: constants.grey,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 90,
            left: 15,
            right: 15,
            child: Text(
              "You’ll have to complete this and be approved before starting Receiving new jobs. ",
              style: TextStyle(
                  color: constants.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          Positioned(
              top: 140,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 3,
                color: constants.grey,
              )),
          Positioned(
            top: 160,
            left: 15,
            right: 15,
            child: Text(
              "Area of work",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          Positioned(
              top: 160,
              left: 280,
              right: 15,
              child: ElevatedButton(
                child: Text("Set Now"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AreaOfWork()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(constants.blue2),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          side: BorderSide(color: constants.blue2))),
                ),
              )),
          const Positioned(
            top: 181,
            left: 15,
            right: 15,
            child: Text(
              "Select multiple working areas",
              style: TextStyle(
                  color: constants.blue2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          const Positioned(
            top: 215,
            left: 15,
            right: 15,
            child: Text(
              "We will help you with finding the best working opportunities In your selected working areas",
              style: TextStyle(
                  color: constants.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          const Positioned(
            top: 230,
            right: 30,
            left: 320,
            child: Text(
              "1/2",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PageController _pageController = PageController();

  bool isData = true;

  Future<userProfileModel>? _futureAlbum;

  File? _file;


}
