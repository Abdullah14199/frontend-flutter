import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/Today\'s_Schedule.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/routes/routes.dart';

class TodaysList extends StatefulWidget {
  const TodaysList({Key? key}) : super(key: key);

  @override
  State<TodaysList> createState() => _TodaysListState();
}

bool isData = true;

class _TodaysListState extends State<TodaysList> {
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
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
                        onPressed: () {},
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
              padding: EdgeInsets.only(top: 140, left: 25, right: 45),
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
              padding: const EdgeInsets.only(top: 180, right: 17, left: 17),
              child: isData ? Column(
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
              ) : ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                                  SizedBox(width: 160,),
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
                              SizedBox(height: 7,),
                              Text(
                                des[index],
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 7,),
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
                                        ImageIcon(AssetImage("assets/images/refresh.png")),
                                        Text("Monthly" , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.bold , fontFamily: 'Ubuntu'),),
                                      ],
                                    ),
                                  ),
                                  SizedBox( width:  10,),
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 5,),
                                        Text("(4.3/5)" , style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold , fontFamily: 'Ubuntu'),),
                                        ImageIcon(AssetImage("assets/images/star.png") , color: constants.yellow,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7,),
                              Row(
                                children: [
                                  Image.asset("assets/images/Food.png"),
                                  SizedBox(width: 5,),
                                  Image.asset("assets/images/Freez.png"),
                                  SizedBox(width: 5,),
                                  Image.asset("assets/images/Table.png"),
                                  SizedBox(width: 5,),
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
