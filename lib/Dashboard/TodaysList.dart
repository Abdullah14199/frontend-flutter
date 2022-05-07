import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Back_ground_check/verificationAccount.dart';
import 'package:skep_home_pro/Dashboard/Today\'s_Schedule.dart';
import 'package:skep_home_pro/Dashboard/areaOfWork.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/routes/routes.dart';
import 'package:skep_home_pro/shared/cache_helper.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../controllers/dashboard.dart';
import '../controllers/scheduleDate.dart';

class TodaysList extends StatefulWidget {
  const TodaysList({Key? key}) : super(key: key);

  @override
  State<TodaysList> createState() => _TodaysListState();
}

bool isData = true;

bool isVerified = true;



class _TodaysListState extends State<TodaysList> {


  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;

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
        body: GetBuilder<ScheduleDate>(
          init: ScheduleDate(),
          builder: (conroller)=>SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                      padding: const EdgeInsets.only(left: 20, right: 40),
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
                              conroller.choose(true);
                            },
                            child: Text(
                              "Today’s Schedule",
                              style: TextStyle(
                                  color: !conroller.chooseScreen
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
                              setState(() {
                                isTextFiledFocus = hasFoucs;
                              });
                            },
                            onPressed: () {
                              conroller.choose(false);
                            },
                            child: Text(
                              "Dashboard",
                              style: TextStyle(
                                  color: conroller.chooseScreen
                              ? Colors.white
                                  : constants.yellow),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                conroller.chooseScreen ? buildTodayList():buildDashboard()
              ],
            ),
          )
        ),

      ),
    );
    
  }


  Widget buildTodayList()=>Padding(
    padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "0",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Bookings",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Container(
              width: 3,
              height: 60,
              color: constants.grey,
            ),
            Column(
              children: [
                Text(
                  "00:00",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Total Hours",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Container(
              width: 3,
              height: 60,
              color: constants.grey,
            ),
            Column(
              children: [
                Text(
                  "\$0,00",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Cash In",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
        isData == true
            ? Padding(
              padding: const EdgeInsets.only(top: 45.0),
              child: Column(
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
                      borderRadius:
                      BorderRadius.all(Radius.circular(18))),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 55.0,
                          height: 55.0,
                          child: const CircleAvatar(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.green,
                            backgroundImage: NetworkImage(
                                "https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png"),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  names[index],
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
                                  "\$43",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold),
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
                                        "Monthly",
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
                                        "(4.3/5)",
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
                            Row(
                              children: [
                                Image.asset("assets/images/Food.png"),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset("assets/images/Freez.png"),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset("assets/images/Table.png"),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset("assets/images/Window.png"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        )
      ],
    ),
  );

  Widget buildDashboard() => GetBuilder<ScheduleDate>(
      init: ScheduleDate(),
      builder: (controller) {
        List<charts.Series<WorldPopulation, String>> series = [
          charts.Series(
            data: controller.hasData ? controller.populationData:controller.populationData2,
            id: "World Population",
            domainFn: (WorldPopulation pops, _) => pops.year,
            measureFn: (WorldPopulation pops, _) => pops.population,
            colorFn: (WorldPopulation pops, _) => controller.hasData
                ? charts.ColorUtil.fromDartColor(constants.yellow)
                : charts.ColorUtil.fromDartColor(constants.lightGrey),
          )
        ];

        return  Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20),
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
              const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
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
                            "${controller.BookingBalance}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "Blance",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
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
                            "${controller.WeekBalance}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "This Week",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
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
                            "${controller.MonthBalance}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
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
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 10, left: 15, right: 15),
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
              const EdgeInsets.only(top: 10, left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "${controller.BookingCount}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Bookings",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Container(
                    width: 3,
                    height: 80,
                    color: constants.grey,
                  ),
                  Column(
                    children: [
                      Text(
                        "${controller.Total_hours}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Total Hours",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Container(
                    width: 3,
                    height: 80,
                    color: constants.grey,
                  ),
                  Column(
                    children: [
                      Text(
                        "\$ ${controller.TodayCashIn}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold),
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
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10),
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
              const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: controller.leatestBooking.isEmpty
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
                itemCount: controller.leatestBooking.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
                                    child: Text(controller.leatestBooking[index].time),
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
                                        controller.leatestBooking[index].fullName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Ubuntu',
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      Text(
                                        "\$ ${controller.leatestBooking[index].salary}",
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
                                    controller.leatestBooking[index].bookingHours.toString(),
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
        );
      });

}

class WorldPopulation {
  final String year;
  final int population;

  WorldPopulation(this.year, this.population);
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