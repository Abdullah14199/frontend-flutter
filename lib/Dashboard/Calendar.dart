import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/models/calendarModel.dart';
import 'package:skep_home_pro/splash_screen/splash_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Back_ground_check/back_ground_check.dart';
import '../Login/login.dart';
import '../controllers/scheduleDate.dart';
import 'package:http/http.dart' as http;

import 'Dashboard.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();

}


var ImageCal;
var Fullname;
var Rate;
var Time;

class _CalendarScreenState extends State<CalendarScreen> {


  @override
  void initState() {
    super.initState();
    postCharts();

  }

  ProductsModel? productsModel;
  List<Booking> bookList = [];

  List<DateTime> dataEvent = [];




  var isData = true;
  var isData2 = true;

  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  DateTime foucsedDay = DateTime.now();

  String dateFormatted = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<ProductsModel> postCharts() async {
    final response = await http.post(
      Uri.parse('https://staging.skephome.com/api/Cleaner/CleanerCalendar'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token3'
      },
      body: {
        'date': "2021-12-12",
      },
    );
    var body = response.body;
    var respSt = response.statusCode;

    var booking = jsonDecode(body);
    // print(booking['Booking']);
    // print(booking);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // then parse the JSON.
      // print(body);
      print("Succeed");
      productsModel = ProductsModel.fromJson(booking);

      productsModel!.booking.forEach((key, value) {
        print(key);
        print(key.split('').reversed.join());
       // dataEvent.add(DateTime.parse(key));
        print(dataEvent);

        // dataEvent.add(DateTime.parse(key));
        value.forEach((element) {
          bookList.add(element);
        });
      });
      setState(() {
        if (booking['Booking'] == "{Booking: {}}") {
          isData2 == true;
          print(isData2);
        } else {
          isData2 == false;
        }
      });
      return ProductsModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.statusCode);
      print(response.body);

      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return Text(body + respSt.toString());
      //     });
      print("Hohohohoh");
      throw Exception('Failed to create album.');
    }
  }



  @override
  Widget build(BuildContext context) {

    return GetBuilder<ScheduleDate>(
      init: ScheduleDate(),
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
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Center(
              child: Text(
                "Calendar",
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
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TableCalendar(
                    eventLoader: (day) => dataEvent,
                    headerVisible: true,
                    sixWeekMonthsEnforced: false,
                    daysOfWeekVisible: true,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      decoration: BoxDecoration(
                        color: constants.blue3,
                      ),
                      weekendStyle: TextStyle(color: Colors.white),
                      weekdayStyle: TextStyle(color: Colors.white),
                    ),
                    calendarFormat: format,
                    onFormatChanged: (CalendarFormat _format) {
                      setState(() {
                        format = _format;
                      });
                    },
                    onDaySelected: (DateTime selectDay, DateTime foucsDay) {
                      setState(() {
                        selectedDay = selectDay;
                        foucsedDay = foucsDay;
                      });
                    },
                    onPageChanged: (foucsWeek) => {print(foucsWeek)},
                    headerStyle: HeaderStyle(
                      titleTextStyle: const TextStyle(fontSize: 12),
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextFormatter: (date , locale) =>
                        DateFormat.yMMMMEEEEd(locale).format(date),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: constants.lightGrey),
                    ),
                      calendarStyle:  const CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.white),
                      withinRangeTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.white),
                      rangeStartTextStyle: TextStyle(color: Colors.white),
                      todayTextStyle: TextStyle(color: Colors.white),
                      disabledTextStyle: TextStyle(color: Colors.white),
                      outsideTextStyle: TextStyle(color: Colors.white),
                      isTodayHighlighted: true,
                      rowDecoration: BoxDecoration(
                        color: constants.blue2,
                      ),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                          color: constants.yellow, shape: BoxShape.circle),
                      selectedTextStyle: TextStyle(color: Colors.white),
                    ),
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, right: 17, left: 17),
                  child: bookList.isEmpty
                      ? Column(
                          children: [
                            Image.asset("assets/images/cleanerone.png"),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "No Bookings Today",
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
                                  "Sorry there Is no available cleaning right now,",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: bookList.length,
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
                                      child:  CircleAvatar(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.green,
                                        backgroundImage: NetworkImage(
                                            "https://staging.skephome.com/storage/${bookList[index].image}"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                             bookList[index].fullName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Ubuntu',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 130,
                                            ),
                                            Text(
                                             "${ bookList[index].salary}",
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
                                          "${ bookList[index].date} at ${bookList[index].time}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
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
                                                    "(${bookList[index].rate}/5)",
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
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/Food.png"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset(
                                                "assets/images/Freez.png"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset(
                                                "assets/images/Table.png"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset(
                                                "assets/images/Window.png"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ));
      },
    );
  }
}

