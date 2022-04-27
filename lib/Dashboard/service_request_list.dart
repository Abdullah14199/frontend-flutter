import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/service_request_list_controller.dart';
import 'package:skep_home_pro/routes/routes.dart';

import '../controllers/scheduleDate.dart';

class serviceRequestList extends StatefulWidget {
  const serviceRequestList({Key? key}) : super(key: key);

  @override
  State<serviceRequestList> createState() => _serviceRequestListState();
}

class _serviceRequestListState extends State<serviceRequestList> {
  bool isTextFiledFocus = false;

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
                child: Column(
                  children: [buildTodayList()],
                ),
      )
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

  bool isData = true;


}
