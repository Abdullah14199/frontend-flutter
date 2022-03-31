import 'package:flutter/material.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Back_ground_check/back_ground_check.dart';
import '../controllers/scheduleDate.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    level();
  }

  bool isData = true;


  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  DateTime foucsedDay = DateTime.now();

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
          drawer: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(35),
                bottomRight: Radius.circular(35)),
            child: Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35)),
                      color: constants.blue,
                    ),
                    child: Stack(children: [
                      Positioned(
                        child:
                            Image.asset("assets/images/profile_decore_img.png"),
                        top: 30,
                        bottom: 20,
                        left: -13,
                      ),
                      Positioned(
                        top: 100,
                        left: 90,
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
                      Column(
                        children: [
                          Image.asset("assets/images/skeplogomenu.png"),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               CircleAvatar(
                                backgroundImage: NetworkImage("https://staging.skephome.com/storage/${Selfie}"),
                                radius: 35,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hi ${FirstName} , ",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Ubuntu '),
                                    ),
                                    const Text(
                                      "Welcome Back",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Ubuntu '),
                                    ),
                                    Row(
                                      children: [
                                        Positioned(
                                          top: 2,
                                          left: 20,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Silver == true
                                                ? Image.asset(
                                                    "assets/images/silver_badge_img.png",
                                                  )
                                                : Gold == true
                                                    ? Image.asset(
                                                        "assets/images/gold_shield_img.png",
                                                      )
                                                    : Image.asset(
                                                        "assets/images/bronz_badge_img.png",
                                                      ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: AssetImage(
                                              "assets/images/ic_colored_great.PNG"),
                                          radius: 10,
                                        ),
                                        Container(
                                          width: 40,
                                          height: 15,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: const Text(
                                            "Great",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ]),
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    selected: true,
                    leading: Image.asset(
                      "assets/images/homeMenu.png",
                      color: constants.blue,
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
                      color: constants.blue,
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
                      color: constants.blue,
                    ),
                    title:
                        const Text('History', style: TextStyle(color: Colors.black)),
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
                      color: constants.blue,
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
                      color: constants.blue,
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
                      color: constants.blue,
                    ),
                    title:
                        const Text('Settings', style: TextStyle(color: Colors.black)),
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
                      color: constants.blue,
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
                      color: constants.blue,
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TableCalendar(
                    headerVisible: true,
                    sixWeekMonthsEnforced: false,
                    daysOfWeekVisible: true,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      decoration: BoxDecoration(
                        color: constants.blue,

                      ),
                      weekendStyle: TextStyle(
                        color: Colors.white
                      ),
                      weekdayStyle: TextStyle(
                        color: Colors.white
                      ),
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

                    headerStyle: const HeaderStyle(
                        titleTextStyle: TextStyle(fontSize: 18),
                        formatButtonVisible: false,
                        titleCentered: true,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: constants.lightGrey
                        ),
                    ),
                    calendarStyle: const CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.white),
                      withinRangeTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.white),
                      rangeStartTextStyle: TextStyle(color: Colors.white),
                      todayTextStyle: TextStyle(color: Colors.white),
                      disabledTextStyle: TextStyle(color: Colors.white),
                      outsideTextStyle: TextStyle(color: Colors.white),
                      isTodayHighlighted: true,
                      rowDecoration: BoxDecoration(
                        color: constants.purple,
                      ),
                      todayDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                          color: constants.yellow,
                          shape: BoxShape.circle),
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
                  padding: const EdgeInsets.only(top: 20, right: 17, left: 17),
                  child: isData
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
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
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
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            names[index],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Ubuntu',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 160,
                                          ),
                                          const Text(
                                            "\$43",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Ubuntu',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        des[index],
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 73,
                                            height: 21.94,
                                            decoration: const BoxDecoration(
                                              color: constants.lightGrey,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                const ImageIcon(AssetImage(
                                                    "assets/images/refresh.png")),
                                                const Text(
                                                  "Monthly",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Ubuntu'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 73,
                                            height: 21.94,
                                            decoration: const BoxDecoration(
                                              color: constants.lightGrey,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const Text(
                                                  "(4.3/5)",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Ubuntu'),
                                                ),
                                                const ImageIcon(
                                                  AssetImage(
                                                      "assets/images/star.png"),
                                                  color: constants.yellow,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset("assets/images/Food.png"),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset("assets/images/Freez.png"),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset("assets/images/Table.png"),
                                          const SizedBox(
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

bool Silver = false;

bool Gold = false;

bool Platinum = false;

void level() {
  if (Level == 'one') {
    Image.asset("assets/images/bronz_badge_img.png");
    Silver = true;
  } else if (Level == 'two') {
    Image.asset("assets/images/bronz_badge_img.png");
    Gold = true;
  } else if (Level == 'three') {
    Image.asset("assets/images/bronz_badge_img.png");
    Platinum = true;
  }
}
