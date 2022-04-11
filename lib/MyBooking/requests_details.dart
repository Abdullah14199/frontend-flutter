import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:skep_home_pro/MyBooking/check_list.dart';
import 'package:skep_home_pro/MyBooking/support_center.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/request_details_controller.dart';
import 'package:skep_home_pro/models/my_booking_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class RequestsDetails extends StatelessWidget {
  RequestsDetails({Key? key, required this.scheduleBooking}) : super(key: key);

  ScheduleBooking scheduleBooking;

  @override
  Widget build(BuildContext context) {
    print("CCC${scheduleBooking.id}");
    return GetBuilder<RequestDetailsController>(
      init: RequestDetailsController(),
      builder: (controller) {
        controller.getRequestDetails(scheduleBooking.id);
        print(controller.log);
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
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 230,
                                    child: Stack(
                                      children: [
                                        GoogleMap(
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
                                          onMapCreated: (GoogleMapController
                                              controller) {},
                                        ),
                                        Center(
                                          child: Container(
                                            height: 70,
                                            child: Lottie.asset(
                                                "assets/images/map.json"),
                                          ),
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
                                            onPressed: () {},
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
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 55.0,
                                      height: 55.0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.green,
                                        backgroundImage: NetworkImage(controller
                                                    .requestDetailsModel!
                                                    .serviceRequest
                                                    .image !=
                                                null
                                            ? "https://staging.skephome.com/storage/${controller.requestDetailsModel!.serviceRequest.image}"
                                            : "https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png"),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 280,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Text(
                                                  controller
                                                      .requestDetailsModel!
                                                      .serviceRequest
                                                      .fullName,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Row(
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
                                                  width: 110,
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
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Row(
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
                                                  SizedBox(width: 100)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),



                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 280,
                                child: controller.booking_statues == "upcoming"
                                    ? ElevatedButton(
                                        onPressed: () {
                                          controller.postMarkAsStartRequest(
                                              scheduleBooking.id, context);
                                        },
                                        child: Text("Start job"),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  constants.green),
                                        ),
                                      )
                                    : controller.booking_statues == "canceled"
                                        ? ElevatedButton(
                                            onPressed: () {},
                                            child: Text("Canceld"),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      constants.darkred),
                                            ),
                                          )
                                        : controller.booking_statues ==
                                                "pending"
                                            ? ElevatedButton(
                                                onPressed: () {},
                                                child: Text("Pending"),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          constants.yellow),
                                                ),
                                              )
                                            : controller.booking_statues ==
                                                    "under_review"
                                                ? ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text("Under review"),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(constants
                                                                  .darkred),
                                                    ),
                                                  )
                                                : controller.booking_statues ==
                                                        "scheduled"
                                                    ? ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text("Schedule"),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(constants
                                                                      .blue4),
                                                        ),
                                                      )
                                                    : controller.booking_statues ==
                                                            "completed"
                                                        ? ElevatedButton(
                                                            onPressed: () {},
                                                            child: Text(
                                                                "Completed"),
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(constants
                                                                          .darkgrey),
                                                            ),
                                                          )
                                                        : controller.booking_statues ==
                                                                "inprogress"
                                                            ? ElevatedButton(
                                                                onPressed: () {
                                                                  controller.postMarkAsCompleteRequest(
                                                                      scheduleBooking
                                                                          .id,
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    "Complete Job"),
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          constants
                                                                              .red),
                                                                ),
                                                              )
                                                            : const SizedBox()),
                            Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: constants.yellow),
                                child: controller.booking_statues ==
                                        "inprogress"
                                    ? IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => CheckList()),
                                          );
                                        },
                                        icon: Image.asset(
                                          "assets/images/ic_check_list_icon.PNG",
                                          color: Colors.white,
                                        ),
                                      )
                                    : controller.booking_statues == "completed"
                                        ? IconButton(
                                            onPressed: () { Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => CheckList()),
                                            );},
                                            icon: Image.asset(
                                              "assets/images/ic_check_list_icon.PNG",
                                              color: Colors.white,
                                            ),
                                          )
                                        : controller.booking_statues ==
                                                "scheduled"
                                            ? IconButton(
                                                onPressed: () { Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => CheckList()),
                                                );},
                                                icon: Image.asset(
                                                  "assets/images/ic_check_list_icon.PNG",
                                                  color: Colors.white,
                                                ),
                                              )
                                            : controller.booking_statues ==
                                                    "under_review"
                                                ? IconButton(
                                                    onPressed: () { Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => CheckList()),
                                                    );},
                                                    icon: Image.asset(
                                                      "assets/images/ic_check_list_icon.PNG",
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : controller.booking_statues ==
                                                        "pending"
                                                    ? IconButton(
                                                        onPressed: () { Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => CheckList()),
                                                        );},
                                                        icon: Image.asset(
                                                          "assets/images/ic_check_list_icon.PNG",
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : controller.booking_statues ==
                                                            "canceled"
                                                        ? IconButton(
                                                            onPressed: () { Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => CheckList()),
                                                            );},
                                                            icon: Image.asset(
                                                              "assets/images/ic_check_list_icon.PNG",
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : controller.booking_statues ==
                                                                "upcoming"
                                                            ? IconButton(
                                                                onPressed:
                                                                    () { Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(builder: (context) => CheckList()),
                                                                    );},
                                                                icon:
                                                                    Image.asset(
                                                                  "assets/images/ic_check_list_icon.PNG",
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            : const SizedBox())
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
                                Text(
                                  scheduleBooking.placeInstructions != null
                                      ? "${scheduleBooking.placeInstructions}"
                                      : "",
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
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          width: 30,
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
                                            style:
                                                TextStyle(color: Colors.white),
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
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          width: 30,
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
                                            style:
                                                TextStyle(color: Colors.white),
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
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          width: 30,
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
                                            style:
                                                TextStyle(color: Colors.white),
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
                                    scheduleBooking.pets == 0 ? "No" : "Yes",
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
                                    ),
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
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Card(
                        elevation: 5,
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SupportCenter(
                                          jobId: controller.jobId,
                                        )),
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




                    controller.booking_statues == "canceled"
                        ? SizedBox()
                        : controller.booking_statues == "completed"
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 5),
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

                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Center(child: const Text('Skep Pro')),
                                                    content: SingleChildScrollView(
                                                      child: ListBody(
                                                        children: const <Widget>[
                                                          Center(child: Text('Are you sure you want to cancel this booking ?')),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('Yes'),
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  title: Center(child: const Text('Skep Pro')),
                                                                  content: SingleChildScrollView(
                                                                    child: ListBody(
                                                                      children: const <Widget>[
                                                                        Center(child: Text('WARNING, if you proceed with cancelling this job your rating will drop by 0.2')),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: const Text('Proceed'),
                                                                      onPressed: () {
                                                                        controller.postMarkAsCancelRequest(scheduleBooking.id, context);
                                                                      },
                                                                    ),
                                                                    TextButton(
                                                                      child: const Text('No'),
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              ImageIcon(
                                                AssetImage(
                                                    "assets/images/cancel.png"),
                                                color: constants.grey,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Cancel Job",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Ubuntu',
                                                    fontWeight:
                                                        FontWeight.bold),
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
