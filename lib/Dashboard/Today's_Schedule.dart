import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/Dashboard.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TodaysSchedule extends StatefulWidget {
  const TodaysSchedule({Key? key}) : super(key: key);

  @override
  State<TodaysSchedule> createState() => _TodaysSchedule();
}

class _TodaysSchedule extends State<TodaysSchedule> {
  int currentIndex = 0;

  bool isTextFiledFocus = false;

  static final List<WorldPopulation> populationData = [
    WorldPopulation('2016', 54, Colors.pink),
    WorldPopulation('2017', 57, Colors.purple),
    WorldPopulation('2018', 62, Colors.yellow),
    WorldPopulation('2019', 77, Colors.amber),
    WorldPopulation('2020', 80, Colors.green),
    WorldPopulation('2021', 99, Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<WorldPopulation, String>> series = [
      charts.Series(
        data: populationData,
        id: "World Population",
        domainFn: (WorldPopulation pops, _) => pops.year,
        measureFn: (WorldPopulation pops, _) => pops.population,
        colorFn:  (WorldPopulation pops, _) => charts.ColorUtil.fromDartColor(pops.barColor),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()),
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
              padding: const EdgeInsets.only(top: 140, left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "0.00",
                    style: TextStyle(
                        color: constants.grey,
                        fontSize: 21,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "0.00",
                    style: TextStyle(
                        color: constants.grey,
                        fontSize: 21,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "0,00",
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
              padding: const EdgeInsets.only(top: 140, left: 30, right: 83),
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
                children: [
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
                    "July 2021",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            Padding(padding: const EdgeInsets.only(top: 200, left: 15, right: 15),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: charts.BarChart(series),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 450, left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "0",
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
                    "00:00",
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
                    "\$0,00",
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
              padding: EdgeInsets.only(top: 520, left: 30, right: 20),
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
              padding: EdgeInsets.only(top: 550, left: 30, right: 20),
              child: Row(
                children: [
                  Text(
                    "Latest Requests",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
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

class WorldPopulation {
  final String year;
  final int population;
  final Color barColor;

  WorldPopulation(this.year, this.population, this.barColor);
}
