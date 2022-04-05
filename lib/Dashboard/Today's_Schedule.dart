import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

import '../controllers/scheduleDate.dart';
import 'TodaysList.dart';

class TodaysSchedule extends StatefulWidget {
  const TodaysSchedule({Key? key}) : super(key: key);

  @override
  State<TodaysSchedule> createState() => _TodaysSchedule();
}

bool isData = true;


class _TodaysSchedule extends State<TodaysSchedule> {
  int currentIndex = 0;


  bool isTextFiledFocus = false;

  List names = [
    "Abdullah Mohy",
    "Abdullah Mohy",
    "Abdullah Mohy",
    "Abdullah Mohy",
    "Abdullah Mohy",
    "Abdullah Mohy",
    "Abdullah Mohy",
    "Abdullah Mohy",
    "Abdullah Mohy",
    "Abdullah Mohy"
  ];
  List des = [
    "starts at 60 mins",
    "starts at 3:00pm",
    "starts at 3:00pm",
    "starts at 3:00pm",
    "starts at 3:00pm",
    "starts at 3:00pm",
    "starts at 3:00pm",
    "starts at 3:00pm",
    "starts at 3:00pm",
    "starts at 3:00pm"
  ];

  @override
  void initState() {
    super.initState();
    level();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleDate>(
        init: ScheduleDate(),
        builder: (controller) {
          controller.postCharts();
          List<charts.Series<WorldPopulation, String>> series = [
            charts.Series(
              data: controller.hasData
                  ? controller.populationData
                  : controller.populationData2,
              id: "World Population",
              domainFn: (WorldPopulation pops, _) => pops.year,
              measureFn: (WorldPopulation pops, _) => pops.population,
              colorFn: (WorldPopulation pops, _) => controller.hasData
                  ? charts.ColorUtil.fromDartColor(constants.yellow)
                  : charts.ColorUtil.fromDartColor(constants.lightGrey),
            )
          ];

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
                title: Center(
                  child: Text(
                    "Cleaner Hub",
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
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 10),
                      child: Container(
                        width: 380,
                        height: 48,
                        decoration: BoxDecoration(
                            color: constants.blue2,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onFocusChange: (hasFoucs) {
                                  setState(() {
                                    isTextFiledFocus = hasFoucs;
                                  });
                                },
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TodaysList()),
                                  );
                                },
                                child: Text(
                                  "Today’s Schedule",
                                  style: TextStyle(
                                      color: isTextFiledFocus
                                          ? constants.yellow
                                          : Colors.white),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: constants.grey,
                              ),
                              TextButton(
                                onFocusChange: (hasFoucs) {
                                  setState(() {
                                    isTextFiledFocus = hasFoucs;
                                  });
                                },
                                onPressed: () {},
                                child: Text(
                                  "Dashboard",
                                  style: TextStyle(
                                      color: isTextFiledFocus
                                          ? Colors.white
                                          : constants.yellow),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 70, left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: constants.lightGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: double.infinity,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.getDateMenus();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${controller.formatted}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.getDatePlus();
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 140, left: 40, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${controller.BookingBalance}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${controller.WeekBalance}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${controller.MonthBalance}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 140, left: 30, right: 83),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$",
                            style: TextStyle(
                                color: constants.yellow,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$",
                            style: TextStyle(
                                color: constants.yellow,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$",
                            style: TextStyle(
                                color: constants.yellow,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 180, left: 40, right: 28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Blance",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "This Week",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "This month",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 200, left: 15, right: 15),
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: charts.BarChart(series),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 450, left: 40, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${controller.BookingCount}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 3,
                            height: 80,
                            color: constants.grey,
                          ),
                          Text(
                            "${controller.Total_hours}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 3,
                            height: 80,
                            color: constants.grey,
                          ),
                          Text(
                            "\$ ${controller.TodayCashIn}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 520, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Bookings",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "Total Hours",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "Today Cash In",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 550, left: 10, right: 10),
                      child: Row(
                        children: const [
                          Text(
                            "Latest Requests",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 580, left: 10, right: 10),
                      child: isData == false
                          ? Center(
                              child: Text(
                                "No data to show",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.normal,
                                    color: constants.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 55.0,
                                              height: 55.0,
                                              child: Text("3:32"),
                                            ),
                                            Container(
                                              width: 35,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                color: constants.lightGrey,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "PM",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Ubuntu'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  names[index],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'Ubuntu',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 160,
                                                ),
                                                Text(
                                                  "\$43",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'Ubuntu',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              des[index],
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10,
                                                  fontFamily: 'Ubuntu',
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              // bottomNavigationBar: BottomNavigationBar(
              //   backgroundColor: Colors.white,
              //   elevation: 0,
              //   items: const <BottomNavigationBarItem>[
              //     BottomNavigationBarItem(
              //       icon: ImageIcon(AssetImage("assets/images/home.png")),
              //       label: '',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: ImageIcon(
              //           AssetImage("assets/images/nosBottomNavigationBar.png")),
              //       label: '',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: ImageIcon(AssetImage("assets/images/dashboard.png")),
              //       label: '',
              //     ),
              //   ],
              //   // currentIndex: _selectedIndex,
              //   selectedItemColor: constants.blue2,
              //   onTap: (index) => setState(() {
              //     currentIndex = index;
              //   }),
              //   currentIndex: currentIndex,
              //   type: BottomNavigationBarType.fixed,
              //   showUnselectedLabels: false,
              // ),
            ),
          );
        });
  }
}

class WorldPopulation {
  final String year;
  final int population;

  WorldPopulation(this.year, this.population);
}

const week = [
  "M",
  "T",
  "W",
  "T",
  "F",
  "S",
  "S",
];

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