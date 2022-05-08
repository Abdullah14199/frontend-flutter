import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:skep_home_pro/MyBooking/support_center.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/complete_request_controller.dart';
import 'package:skep_home_pro/models/complete_booking.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../Back_ground_check/back_ground_check.dart';
import '../chatPage/chat.dart';

var idBooking ;
var homeOwnerPhone;
var homeOwnerUid;
var FcmTokenOwner;


class CompleteDetails extends StatefulWidget {
  CompleteDetails({Key? key, required this.historyBooking}) : super(key: key);
  HistoryBooking historyBooking;

  @override
  State<CompleteDetails> createState() => _CompleteDetailsState();
}

class _CompleteDetailsState extends State<CompleteDetails> {
  GoogleMapController ? _googleMapController;

  bool mapScreen = false ;

  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController!.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    print("CCC${widget.historyBooking.id}");
    idBooking = widget.historyBooking.id;
    homeOwnerPhone = widget.historyBooking.homeownerPhone;
    homeOwnerUid = widget.historyBooking.firebaseUid;
    FcmTokenOwner = widget.historyBooking.fcmToken;





    return GetBuilder<CompleteRequestController>(
      init: CompleteRequestController(),
      builder: (controller) {
        controller.getRequestDetails(widget.historyBooking.id);

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
              title: const Center(
                child: Text(
                  "Requests Details",
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
              builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: mapScreen == false ? MediaQuery.of(context).size.height * 0.45 : MediaQuery.of(context).size.height * 1.05,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height:mapScreen == false ? 230 : 650,
                                    child: Stack(
                                      children: [
                                        GoogleMap(
                                          onTap: (LatLng latLng){
                                            setState(() {
                                              mapScreen != mapScreen ;
                                            });
                                          },
                                          mapType: MapType.normal,
                                          zoomControlsEnabled: false,
                                          scrollGesturesEnabled: false,
                                          zoomGesturesEnabled: false,
                                          tiltGesturesEnabled: false,
                                          rotateGesturesEnabled: false,
                                          myLocationButtonEnabled: false,
                                          initialCameraPosition: CameraPosition(
                                              target: LatLng(controller.lat,
                                                  controller.log),
                                              zoom: 14),
                                          onMapCreated: (controller) {
                                          },
                                        ),
                                        Center(
                                          child: Container(
                                            height: 70,
                                            child: Lottie.asset("assets/images/map.json"),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 270,
                                    right: 4,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: constants.yellow,
                                          child: IconButton(
                                              onPressed: () {
                                                launch(
                                                    "tel://${controller.requestDetailsModel!.serviceRequest.homeownerPhone}");
                                              },
                                              icon: Icon(
                                                Icons.phone,
                                                color: Colors.white,
                                              )),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: constants.blue2,
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => chatpage(email: "$EmailUser")),);
                                            },
                                            icon: Icon(Icons.chat,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 55.0,
                                        height: 55.0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.green,
                                          backgroundImage: NetworkImage(
                                              controller.requestDetailsModel!.serviceRequest.image == "" ?
                                              "https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png"  :
                                              "https://staging.skephome.com/storage/${controller.requestDetailsModel!.serviceRequest.image}"),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: 280,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15.0),
                                                  child: Text(
                                                    controller.requestDetailsModel!
                                                        .serviceRequest.fullName,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily: 'Ubuntu',
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                  "\$ ${controller.requestDetailsModel!.serviceRequest.salary}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'Ubuntu',
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  ImageIcon(AssetImage(
                                                      "assets/images/calendar-6.png")),
                                                  Text(
                                                    controller
                                                        .requestDetailsModel!
                                                        .serviceRequest
                                                        .date,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily: 'Ubuntu'),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  ImageIcon(
                                                    AssetImage(
                                                        "assets/images/clock.png"),
                                                  ),
                                                  Text(
                                                    controller
                                                        .requestDetailsModel!
                                                        .serviceRequest
                                                        .time,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily: 'Ubuntu'),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 73,
                                                height: 21.94,
                                                decoration: BoxDecoration(
                                                  color: constants.lightGrey,
                                                  borderRadius:
                                                  BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    ImageIcon(AssetImage(
                                                        "assets/images/refresh.png")),
                                                    Text(
                                                      controller
                                                          .requestDetailsModel!
                                                          .serviceRequest
                                                          .frequency,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontFamily: 'Ubuntu'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "(${controller.requestDetailsModel!.serviceRequest.rate}/5)",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily: 'Ubuntu'),
                                                  ),
                                                  ImageIcon(
                                                    AssetImage(
                                                        "assets/images/star.png"),
                                                    color: constants.yellow,
                                                  ),
                                                  SizedBox(
                                                    width: 110,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
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
                        const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 280,
                                child:  ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                      "Complete"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty
                                        .all(constants
                                        .darkgrey),
                                  ),
                                )),
                          ],
                        )),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 273,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Special Instructions",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(widget.historyBooking.placeInstructions != null ?
                                "${widget.historyBooking.placeInstructions}" : "" ,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Ubuntu',
                                    color: constants.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Place Size",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [


                                    Row(
                                      children: [
                                        Text(
                                          "Bedrooms",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: constants.yellow,
                                              borderRadius:
                                              BorderRadius.circular(50)),
                                          child: Center(
                                              child: Text(
                                                controller.requestDetailsModel!
                                                    .serviceRequest.bedrooms
                                                    .toString(),
                                                style: TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          "Bathrooms",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: constants.yellow,
                                              borderRadius:
                                              BorderRadius.circular(50)),
                                          child: Center(
                                              child: Text(
                                                controller.requestDetailsModel!
                                                    .serviceRequest.bathrooms
                                                    .toString(),
                                                style: TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          "Den",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: constants.yellow,
                                              borderRadius:
                                              BorderRadius.circular(50)),
                                          child: Center(
                                              child: Text(
                                                controller.requestDetailsModel!
                                                    .serviceRequest.dens
                                                    .toString(),
                                                style: TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Pets",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Ubuntu',
                                      fontSize: 14),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    widget.historyBooking.pets == 0 ? "No" : "Yes",
                                    style: TextStyle(
                                        color: constants.grey,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Ubuntu',
                                        fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Selected Extras",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Ubuntu',
                                      fontSize: 14),
                                ),
                                // Container(
                                //   height: 100,
                                //   child: Row(
                                //     children: [
                                //       Container(
                                //         alignment: Alignment.center, // This is needed
                                //         child: Column(
                                //           crossAxisAlignment: CrossAxisAlignment.center,
                                //           children: [
                                //             Image.asset(
                                //               "assets/images/Food.png",
                                //               fit: BoxFit.cover,
                                //               width: 70,
                                //             ),
                                //             Text("Food")
                                //           ],
                                //         ),
                                //       ),
                                //       Container(
                                //         alignment: Alignment.center, // This is needed
                                //         child: Column(
                                //           crossAxisAlignment: CrossAxisAlignment.center,
                                //           children: [
                                //             Image.asset(
                                //               "assets/images/Food.png",
                                //               fit: BoxFit.cover,
                                //               width: 70,
                                //             ),
                                //             Text("Food")
                                //           ],
                                //         ),
                                //       ),
                                //       Container(
                                //         alignment: Alignment.center, // This is needed
                                //         child: Column(
                                //           crossAxisAlignment: CrossAxisAlignment.center,
                                //           children: [
                                //             Image.asset(
                                //               "assets/images/Food.png",
                                //               fit: BoxFit.cover,
                                //               width: 70,
                                //             ),
                                //             Text("Food")
                                //           ],
                                //         ),
                                //       ),
                                //       SizedBox(
                                //         width: 5,
                                //       ),
                                //       Image.asset("assets/images/Freez.png"),
                                //       SizedBox(
                                //         width: 5,
                                //       ),
                                //       Image.asset("assets/images/Table.png"),
                                //       SizedBox(
                                //         width: 5,
                                //       ),
                                //       Image.asset("assets/images/Window.png"),
                                //     ],
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        color: constants.yellow,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Total Hours",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Ubuntu',
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text(
                                                  controller
                                                      .requestDetailsModel!
                                                      .serviceRequest
                                                      .bookingHours
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily: 'Ubuntu',
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Total Cost",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Ubuntu',
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "\$ ${controller.requestDetailsModel!.serviceRequest.salary}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily: 'Ubuntu',
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SupportCenter(jobId: controller.jobId )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    ImageIcon(
                                      AssetImage("assets/images/XMLID_2_.png"),
                                      color: constants.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Support",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              condition: controller.isLoading,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
