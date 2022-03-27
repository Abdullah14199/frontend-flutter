import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/Today\'s_Schedule.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/routes/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;

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
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  accountName: Text("${FirstName} ${LastName}"),
                  accountEmail: Text("${EmailUser}"))
            ],
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: Container(
                width: 380,
                height: 48,
                decoration: BoxDecoration(
                    color: constants.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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

                        },
                        child: Text(
                          "Today’s Schedule",
                          style: TextStyle(
                              color: isTextFiledFocus
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TodaysSchedule()),
                            );
                            },
                          child: Text(
                            "Dashboard",
                            style: TextStyle(
                                color: isTextFiledFocus
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
              padding: const EdgeInsets.only(top: 80, left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "0",
                    style: TextStyle(
                        color: constants.grey,
                        fontSize: 21,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 3,
                    height: 60,
                    color: constants.grey,
                  ),
                  Text(
                    "00:00",
                    style: TextStyle(
                        color: constants.grey,
                        fontSize: 21,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 3,
                    height: 60,
                    color: constants.grey,
                  ),
                  Text(
                    "\$0,00",
                    style: TextStyle(
                        color: constants.grey,
                        fontSize: 21,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 140, left: 30, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order",
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
                    "Cash In",
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
              padding: const EdgeInsets.only(top: 220, right: 52.6, left: 52.6),
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
                        "Sorry there Is no assigned cleaning Job right now, \n                              try Accept Some.",
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
                    onTap: () {

                    },
                    child: Container(
                      width: 180,
                      height: 45,
                      decoration: const BoxDecoration(
                          color: constants.yellow,
                          borderRadius: BorderRadius.all(Radius.circular(18))),
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
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/home.png")),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                  AssetImage("assets/images/nosBottomNavigationBar.png")),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/dashboard.png")),
              label: '',
            ),
          ],
          // currentIndex: _selectedIndex,
          selectedItemColor: constants.blue2,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
