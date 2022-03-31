import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/Calendar.dart';
import 'package:skep_home_pro/Dashboard/Today\'s_Schedule.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/routes/routes.dart';

import 'TodaysList.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  final List _pages = [
    TodaysList(),
    CalendarScreen(),
    service_request(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _pages.elementAt(currentIndex),
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
