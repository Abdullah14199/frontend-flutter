import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/MyBooking/complete_details.dart';
import 'package:skep_home_pro/MyBooking/requests_details.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/complete_controller.dart';
import 'package:skep_home_pro/controllers/my_booking_controller.dart';
import 'package:skep_home_pro/controllers/request_details_controller.dart';
import 'package:skep_home_pro/models/my_booking_model.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  bool isData = true;

  bool isTextFiledFocus = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MYBookingController>(
        init: MYBookingController(),
        builder: (controller) {
          return SafeArea(
              child: Scaffold(
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
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Center(
                child: Text(
                  "My Bookings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      width: 380,
                      height: 48,
                      decoration: BoxDecoration(
                        color: constants.blue2,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60, right: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onFocusChange: (hasFoucs) {
                                setState(() {});
                              },
                              onPressed: () {
                                controller.choose(true);
                              },
                              child: Text(
                                "Schedule",
                                style: TextStyle(
                                    color: !controller.chooseScreen
                                        ? Colors.white
                                        : constants.yellow),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: constants.grey,
                            ),
                            TextButton(
                              onFocusChange: (hasFoucs) {
                                setState(() {});
                              },
                              onPressed: () {
                                controller.choose(false);
                              },
                              child: Text(
                                "Complete",
                                style: TextStyle(
                                    color: controller.chooseScreen
                                        ? Colors.white
                                        : constants.yellow),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  controller.chooseScreen ? buildSchedule():buildComplete()
                ],
              ),
            ),
          ));
        });
  }

  Widget buildSchedule() => GetBuilder<MYBookingController>(
        init: MYBookingController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.only(top: 20, right: 7, left: 7),
          child: controller.bookingList.isEmpty
              ? Padding(
                padding: const EdgeInsets.only(top: 55.0),
                child: Column(
                    children: [
                      Image.asset("assets/images/cleanerone.png"),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "No Available Bookings",
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
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Sorry there Is no available cleaning requests right now.",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: constants.grey,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              )
              : ListView.builder(
                  itemCount: controller.bookingList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            padding: EdgeInsets.only(
                              left: 3,
                              right: 0,
                              top: 2,
                            ),
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0 , top: 4.0),
                                      child: Container(
                                        width: 55.0,
                                        height: 55.0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.green,
                                          backgroundImage: NetworkImage(
                                              controller.bookingList[index].image == null ?
                                          "https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png"  : "https://staging.skephome.com/storage/${controller.bookingList[index].image}" ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 290,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  "${controller.bookingList[index].fullName}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'Ubuntu',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, right: 18),
                                                child: Text(
                                                  "\$ ${controller.bookingList[index].salary}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'Ubuntu',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          "${controller.bookingList[index].readableDate}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                              fontFamily: 'Ubuntu',
                                              fontWeight: FontWeight.normal),
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
                                                    "${controller.bookingList[index].frequency}",
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "(${controller.bookingList[index].rate}/5)",
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
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RequestsDetails(
                                        scheduleBooking:
                                            controller.bookingList[index],
                                      )),
                            );
                          }),
                ),
        ),
      );

  //Rambo El Batal
  //Tayson

  Widget buildComplete() =>
      GetBuilder<MYCompleteBookingController>(
        init: MYCompleteBookingController(),
        builder: (controller) => ConditionalBuilder(
          condition: controller.isLoading,
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 20, right: 7, left: 7),
            child: controller.completeList.isEmpty
                ? Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Image.asset("assets/images/cleanerone.png"),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0 , right: 15.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Sorry there Is no available cleaning History right now, try Accept Some",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "No History Found",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                ),
              ],
            )
                : ListView.builder(
              itemCount: controller.completeList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 0,
                          top: 2,
                        ),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0 , top: 10),
                                child: Container(
                                  width: 55.0,
                                  height: 55.0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.green,
                                    backgroundImage:  NetworkImage(
                                        "https://staging.skephome.com/storage/${controller.completeList[index].image}"),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 290,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0),
                                          child: Text(
                                            "${controller.completeList[index].fullName}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Ubuntu',
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, right: 20),
                                          child: Text(
                                            "\$ ${controller.completeList[index].salary}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Ubuntu',
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "${controller.completeList[index].readableDate}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.normal),
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
                                              "${controller.completeList[index].frequency}",
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
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "(${controller.completeList[index].rate}/5)",
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
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompleteDetails(
                              historyBooking:   controller.completeList[index],
                              )),
                        );
                      }),
            ),
          ),
          fallback: (context) => CircularProgressIndicator(),
        ),
      );
}
