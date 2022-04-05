import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/MyBooking/requests_details.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/my_booking_controller.dart';
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
                          onPressed: () {},
                          child: Text(
                            "Schedule",
                            style: TextStyle(color: isTextFiledFocus
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
                          onPressed: () {},
                          child: Text(
                            "Complete",
                            style: TextStyle(color: isTextFiledFocus
                                ? constants.yellow
                                : Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 20, right: 7, left: 7),
                child: controller.bookingList.isEmpty
                    ? Column(
                  children: [
                    Image.asset("assets/images/cleanerone.png"),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "No Assigned Cleaning Jobs",
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
                          "Sorry there Is no assigned cleaning Job right now,",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Ubuntu',
                          ),
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(18))),
                        child: const Center(
                          child: Text(
                            "Accept Jobs",
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
                )
                    : ListView.builder(
                  itemCount: controller.bookingList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: EdgeInsets.only(left: 5 , right: 5 , top: 20 , ),
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              padding: EdgeInsets.only(left: 15 , right: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 55.0,
                                    height: 55.0,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.green,
                                      backgroundImage: NetworkImage(
                                          "https://staging.skephome.com/storage/${controller
                                              .bookingList[index].image}"),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${controller.bookingList[index]
                                                .fullName}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Ubuntu',
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          Container(
                                            width: 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 90),
                                            child: Text(
                                              "\$ ${controller.bookingList[index]
                                                  .salary}",
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
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "${controller.bookingList[index]
                                            .readableDate}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontFamily: 'Ubuntu',
                                            fontWeight:
                                            FontWeight.normal),
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
                                                  "${controller
                                                      .bookingList[index]
                                                      .frequency}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Ubuntu'),
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
                                              borderRadius:
                                              BorderRadius.all(
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
                                                  "(${controller
                                                      .bookingList[index]
                                                      .rate}/5)",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Ubuntu'),
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
                        onTap: () =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  RequestsDetails(myBookingModel: controller.bookingList[index],)),
                            ),
                      ),
                ),
              ),
            ],
          ),)
          ,
          )
          );
        });
  }
}
