import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:skep_home_pro/MyBooking/check_list.dart';
import 'package:skep_home_pro/MyBooking/support_center.dart';
import 'package:skep_home_pro/chatPage/chat.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/request_details_controller.dart';
import 'package:skep_home_pro/models/my_booking_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../Back_ground_check/back_ground_check.dart';

var id;
var homeOwnerPhoneReq;
var homeOwnerUidReq;
var value;

class RequestsDetails extends StatefulWidget {
  RequestsDetails({Key? key, required this.scheduleBooking}) : super(key: key);
  ScheduleBooking scheduleBooking;

  @override
  State<RequestsDetails> createState() => _RequestsDetailsState();
}

class _RequestsDetailsState extends State<RequestsDetails> {
  late TextEditingController _controllerComment = TextEditingController();

  bool isButtonActive = false;

  bool isColorActiveBad = true;

  bool isColorActiveMeh = true;

  bool isColorActiveGood = true;

  bool isColorActiveGreat = true;

  bool isColorActiveAwesome = true;

  @override
  void initState() {
    super.initState();

    _controllerComment = TextEditingController();

    _controllerComment.addListener(() {
      final isButtonActive = _controllerComment.text.isNotEmpty;

      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    _controllerComment.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    id = widget.scheduleBooking.id;
    print("CCC${widget.scheduleBooking.id}");
    homeOwnerPhoneReq = widget.scheduleBooking.homeownerPhone;
    homeOwnerUidReq = widget.scheduleBooking.firebaseUid;

    return GetBuilder<RequestDetailsController>(
      init: RequestDetailsController(),
      builder: (controller) {
        controller.getRequestDetails(widget.scheduleBooking.id);
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
                        height: MediaQuery.of(context).size.height * 0.45,
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
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        chatpage(
                                                            email:
                                                                "$EmailUser")),
                                              );
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
                                                    .image ==
                                                ""
                                            ? "https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png"
                                            : "https://staging.skephome.com/storage/${controller.requestDetailsModel!.serviceRequest.image}"),
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
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Center(
                                                      child: const Text(
                                                          'Skep Pro.')),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: const <Widget>[
                                                        Center(
                                                            child: Text(
                                                                'Job Started! Make Sure To Review & Complete The Cleaning Checklist.')),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('Ok'),
                                                      onPressed: () {
                                                        controller
                                                            .postMarkAsStartRequest(
                                                                widget
                                                                    .scheduleBooking
                                                                    .id,
                                                                context);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
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
                                                        onPressed: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            isScrollControlled:
                                                                true,
                                                            builder: (context) => Padding(padding: EdgeInsets.only(
                                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                                              child:
                                                                  ConditionalBuilder(
                                                                      builder:
                                                                          (context) =>
                                                                              StatefulBuilder(
                                                                                builder: (BuildContext context, StateSetter setState) {
                                                                                  return Container(
                                                                                    width: double.infinity,
                                                                                    height: 400,
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Colors.white,
                                                                                      borderRadius: BorderRadius.only(
                                                                                        topLeft: Radius.circular(50),
                                                                                        topRight: Radius.circular(50),
                                                                                      ),
                                                                                    ),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Center(
                                                                                          child: Container(
                                                                                            width: 150,
                                                                                            height: 5,
                                                                                            decoration: const BoxDecoration(
                                                                                              color: constants.grey,
                                                                                              borderRadius: BorderRadius.all(Radius.circular(2)),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 55.0,
                                                                                                height: 55.0,
                                                                                                child: CircleAvatar(
                                                                                                  backgroundColor: Colors.green,
                                                                                                  foregroundColor: Colors.green,
                                                                                                  backgroundImage: NetworkImage(controller.ratingUserModel!.data.image == null ? "https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png" : "https://staging.skephome.com/storage/${controller.ratingUserModel!.data.image}"),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(left: 8.0),
                                                                                                child: Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      "Completed",
                                                                                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Ubuntu', color: constants.yellow),
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 3,
                                                                                                    ),
                                                                                                    Text("Skep Pro", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, fontFamily: 'Ubuntu', color: Colors.black)),
                                                                                                    SizedBox(
                                                                                                      height: 3,
                                                                                                    ),
                                                                                                    Text("${controller.ratingUserModel!.data.fullName}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Ubuntu', color: Colors.grey)),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 15,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                                                                          child: Text(
                                                                                            "Rate Your Home Owner",
                                                                                            style: TextStyle(fontSize: 16, fontFamily: "Ubuntu", fontWeight: FontWeight.bold, color: Colors.black),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 14),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Column(
                                                                                                children: [
                                                                                                  GestureDetector(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        if (isColorActiveBad == true) {
                                                                                                          isColorActiveBad = false;
                                                                                                          isColorActiveMeh = true;
                                                                                                          isColorActiveGood = true;
                                                                                                          isColorActiveGreat = true;
                                                                                                          isColorActiveAwesome = true;
                                                                                                          print(isColorActiveBad);
                                                                                                        } else {
                                                                                                          isColorActiveBad = true;
                                                                                                        }
                                                                                                      });
                                                                                                      value = isColorActiveGood ? 0 : 1;
                                                                                                      print("aaaaa $value");
                                                                                                    },
                                                                                                    child: CircleAvatar(
                                                                                                      radius: 25.0,
                                                                                                      child: Container(width: 30, height: 40, child: Image.asset("assets/images/ic_bad_rate.PNG")),
                                                                                                      backgroundColor: isColorActiveBad ? constants.grey : constants.yellow,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text("bad")
                                                                                                ],
                                                                                              ),
                                                                                              Column(
                                                                                                children: [
                                                                                                  GestureDetector(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        if (isColorActiveMeh == true) {
                                                                                                          isColorActiveMeh = false;
                                                                                                          isColorActiveBad = true;
                                                                                                          isColorActiveGood = true;
                                                                                                          isColorActiveGreat = true;
                                                                                                          isColorActiveAwesome = true;
                                                                                                          print(isColorActiveMeh);
                                                                                                        } else {
                                                                                                          isColorActiveMeh = true;
                                                                                                        }
                                                                                                      });
                                                                                                      value = isColorActiveGood ? 0 : 2;
                                                                                                      print("aaaaa $value");
                                                                                                    },
                                                                                                    child: CircleAvatar(
                                                                                                      radius: 25.0,
                                                                                                      child: Container(width: 30, height: 40, child: Image.asset("assets/images/ic_meh_rate.PNG")),
                                                                                                      backgroundColor: isColorActiveMeh ? constants.grey : constants.yellow,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text("meh")
                                                                                                ],
                                                                                              ),
                                                                                              Column(
                                                                                                children: [
                                                                                                  GestureDetector(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        if (isColorActiveGood == true) {
                                                                                                          isColorActiveGood = false;
                                                                                                          isColorActiveMeh = true;
                                                                                                          isColorActiveBad = true;
                                                                                                          isColorActiveGreat = true;
                                                                                                          isColorActiveAwesome = true;
                                                                                                          print(isColorActiveGood);
                                                                                                        } else {
                                                                                                          isColorActiveGood = true;
                                                                                                        }
                                                                                                      });
                                                                                                      value = isColorActiveGood ? 0 : 3;
                                                                                                      print("aaaaa $value");
                                                                                                    },
                                                                                                    child: CircleAvatar(
                                                                                                      radius: 25.0,
                                                                                                      child: Container(width: 30, height: 40, child: Image.asset("assets/images/ic_good_rate.PNG")),
                                                                                                      backgroundColor: isColorActiveGood ? constants.grey : constants.yellow,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text("good")
                                                                                                ],
                                                                                              ),
                                                                                              Column(
                                                                                                children: [
                                                                                                  GestureDetector(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        if (isColorActiveGreat == true) {
                                                                                                          isColorActiveGreat = false;
                                                                                                          isColorActiveBad = true;
                                                                                                          isColorActiveGood = true;
                                                                                                          isColorActiveMeh = true;
                                                                                                          isColorActiveAwesome = true;
                                                                                                          print(isColorActiveGreat);
                                                                                                        } else {
                                                                                                          isColorActiveGreat = true;
                                                                                                        }
                                                                                                      });
                                                                                                      value = isColorActiveGood ? 0 : 4;
                                                                                                      print("aaaaa $value");
                                                                                                    },
                                                                                                    child: CircleAvatar(
                                                                                                      radius: 25.0,
                                                                                                      child: Container(width: 30, height: 40, child: Image.asset("assets/images/ic_great_rate.PNG")),
                                                                                                      backgroundColor: isColorActiveGreat ? constants.grey : constants.yellow,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text("great")
                                                                                                ],
                                                                                              ),
                                                                                              Column(
                                                                                                children: [
                                                                                                  GestureDetector(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        if (isColorActiveAwesome == true) {
                                                                                                          isColorActiveAwesome = false;
                                                                                                          isColorActiveBad = true;
                                                                                                          isColorActiveGood = true;
                                                                                                          isColorActiveGreat = true;
                                                                                                          isColorActiveMeh = true;
                                                                                                          print(isColorActiveAwesome);
                                                                                                        } else {
                                                                                                          isColorActiveAwesome = true;
                                                                                                        }
                                                                                                      });
                                                                                                      value = isColorActiveGood ? 0 : 5;
                                                                                                      print("aaaaa $value");
                                                                                                    },
                                                                                                    child: CircleAvatar(
                                                                                                      radius: 25.0,
                                                                                                      child: Container(width: 30, height: 40, child: Image.asset("assets/images/ic_awesome_icon.PNG")),
                                                                                                      backgroundColor: isColorActiveAwesome ? constants.grey : constants.yellow,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text("awesome")
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                                                                          child: Text(
                                                                                            "Comment :",
                                                                                            style: TextStyle(fontSize: 16),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: TextFormField(
                                                                                              controller: _controllerComment,
                                                                                              maxLines: 5,
                                                                                              minLines: 5,
                                                                                              decoration: InputDecoration(
                                                                                                  filled: true,
                                                                                                  enabled: true,
                                                                                                  contentPadding: EdgeInsets.only(left: 14, top: 4),
                                                                                                  hintText: 'Please give us any feedback you have.',
                                                                                                  hintStyle: TextStyle(fontSize: 14, color: constants.grey),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(width: 1, color: Colors.black),
                                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                                  ),
                                                                                                  errorBorder: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Colors.red),
                                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                                  ),
                                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Colors.red),
                                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black), borderRadius: BorderRadius.circular(8))),
                                                                                              onEditingComplete: () {
                                                                                                setState(() {
                                                                                                  FocusScope.of(context).nextFocus();
                                                                                                });
                                                                                              }),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            height: 40,
                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                            child: ElevatedButton(
                                                                                                onPressed: isColorActiveBad == false || isColorActiveAwesome == false|| isColorActiveGreat== false || isColorActiveGood== false || isColorActiveMeh== false ? () {
                                                                                                        setState(() {
                                                                                                          isButtonActive = true;
                                                                                                          isButtonActive = true;
                                                                                                          isButtonActive = true;
                                                                                                          isButtonActive = true;
                                                                                                          isButtonActive = true;
                                                                                                        });
                                                                                                        controller.postRating(widget.scheduleBooking.id, _controllerComment.text, value);
                                                                                                        _controllerComment.clear();
                                                                                                        //Navigator.of(context).pop();
                                                                                                      }
                                                                                                    : null,
                                                                                                child: Text("Submit")),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                      condition:
                                                                          controller
                                                                              .isLoading,
                                                                      fallback:
                                                                          (context) =>
                                                                              Center(child: CircularProgressIndicator())),
                                                            ),
                                                          );
                                                        },
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
                                                                      widget
                                                                          .scheduleBooking
                                                                          .id,
                                                                      context);
                                                                  showModalBottomSheet(
                                                                    context:
                                                                        context,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    builder:
                                                                        (context) =>
                                                                            Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          350,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(50),
                                                                          topRight:
                                                                              Radius.circular(50),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                150,
                                                                            height:
                                                                                5,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: constants.grey,
                                                                              borderRadius: BorderRadius.all(Radius.circular(2)),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15.0),
                                                                            child:
                                                                                Image.asset("assets/images/correction.png"),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 50,
                                                                                right: 50,
                                                                                top: 15),
                                                                            child:
                                                                                Center(child: Text("Booking Complete")),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                top: 20.0,
                                                                                right: 10,
                                                                                left: 10),
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                              child: ElevatedButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: Text("Close")),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
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
                                            MaterialPageRoute(
                                                builder: (context) => CheckList(
                                                      scheduleBooking: widget
                                                          .scheduleBooking.id,
                                                    )),
                                          );
                                        },
                                        icon: Image.asset(
                                          "assets/images/ic_check_list_icon.PNG",
                                          color: Colors.white,
                                        ),
                                      )
                                    : controller.booking_statues == "completed"
                                        ? SizedBox()
                                        : controller.booking_statues ==
                                                "scheduled"
                                            ? IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CheckList(
                                                                scheduleBooking:
                                                                    widget
                                                                        .scheduleBooking
                                                                        .id)),
                                                  );
                                                },
                                                icon: Image.asset(
                                                  "assets/images/ic_check_list_icon.PNG",
                                                  color: Colors.white,
                                                ),
                                              )
                                            : controller.booking_statues ==
                                                    "under_review"
                                                ? IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CheckList(
                                                                    scheduleBooking:
                                                                        widget
                                                                            .scheduleBooking
                                                                            .id)),
                                                      );
                                                    },
                                                    icon: Image.asset(
                                                      "assets/images/ic_check_list_icon.PNG",
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : controller.booking_statues ==
                                                        "pending"
                                                    ? IconButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => CheckList(
                                                                    scheduleBooking:
                                                                        widget
                                                                            .scheduleBooking
                                                                            .id)),
                                                          );
                                                        },
                                                        icon: Image.asset(
                                                          "assets/images/ic_check_list_icon.PNG",
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : controller.booking_statues ==
                                                            "canceled"
                                                        ? IconButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => CheckList(
                                                                        scheduleBooking: widget
                                                                            .scheduleBooking
                                                                            .id)),
                                                              );
                                                            },
                                                            icon: Image.asset(
                                                              "assets/images/ic_check_list_icon.PNG",
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : controller.booking_statues ==
                                                                "upcoming"
                                                            ? IconButton(
                                                                onPressed: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                CheckList(scheduleBooking: widget.scheduleBooking.id)),
                                                                  );
                                                                },
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
                                  widget.scheduleBooking.placeInstructions !=
                                          null
                                      ? "${widget.scheduleBooking.placeInstructions}"
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
                                    widget.scheduleBooking.pets == 0
                                        ? "No"
                                        : "Yes",
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
                                                    title: Center(
                                                        child: const Text(
                                                            'Skep Pro')),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: const <
                                                            Widget>[
                                                          Center(
                                                              child: Text(
                                                                  'Are you sure you want to cancel this booking ?')),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child:
                                                            const Text('Yes'),
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: Center(
                                                                      child: const Text(
                                                                          'Skep Pro')),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        ListBody(
                                                                      children: const <
                                                                          Widget>[
                                                                        Center(
                                                                            child:
                                                                                Text('WARNING, if you proceed with cancelling this job your rating will drop by 0.2')),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      child: const Text(
                                                                          'Proceed'),
                                                                      onPressed:
                                                                          () {
                                                                        controller.postMarkAsCancelRequest(
                                                                            widget.scheduleBooking.id,
                                                                            context);
                                                                      },
                                                                    ),
                                                                    TextButton(
                                                                      child: const Text(
                                                                          'No'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
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
                                                          Navigator.of(context)
                                                              .pop();
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
