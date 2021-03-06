import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/splash_screen/splash_screen.dart';
import '../Back_ground_check/back_ground_check.dart';
import '../Dashboard/Today\'s_Schedule.dart';
import '../Dashboard/TodaysList.dart';
import '../models/chartsModel.dart';


class ScheduleDate extends GetxController{


  ScheduleDate(){
    postCharts();
  }

  bool hasData = true;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formatted = DateFormat('yyyy-MM-dd').format(DateTime.now());

  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  bool chooseScreen = true;

  var BookingBalance;
  var WeekBalance;
  var MonthBalance;
  var BookingCount;
  var Total_hours;
  var TodayCashIn;
  var leatestBookings;
  var chart;



  ChartsModels? chartsModels;
  List<LeatestBooking> leatestBooking = [];


  void choose(bool screen){
    chooseScreen = screen;
    update();
  }

  List<WorldPopulation> populationData2 =[
    WorldPopulation("M", 40),
    WorldPopulation("T", 20),
    WorldPopulation("W", 30),
    WorldPopulation("T", 80),
    WorldPopulation("F", 10),
    WorldPopulation("S", 50),
    WorldPopulation("S ", 90),
  ];

  List<WorldPopulation> populationData =[];

  void getDatePlus(){
    day = int.parse(formatted.substring(8,10))+7;
    print(formatted.substring(8,10));
    month = int.parse(formatted.substring(5,7));
    print(month);

    DateTime nextMonth = DateTime(year,month,day);
    formatted = formatter.format(nextMonth);

    update();
  }
  void getDateMenus(){
    day = int.parse(formatted.substring(8,10))-7;
    month = int.parse(formatted.substring(5,7));
    DateTime nextMonth = DateTime(year,month,day);
    formatted = formatter.format(nextMonth);

    update();
  }





  Future<void> postCharts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('https://staging.skephome.com/api/Cleaner/CleanerDasboard'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer ${pref.get('token3').toString()}'
      },
      body: {
        'date': formatted,
      },
    );
    var respSt = response.statusCode;

    var body = response.body;
    var read = jsonDecode(body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // then parse the JSON.
      var bookingBalance = jsonDecode(body);
      BookingBalance = bookingBalance['BookingBalance'];
      WeekBalance = bookingBalance['WeekBalance'];
      MonthBalance = bookingBalance['MonthBalance'];
      BookingCount = bookingBalance['BookingCount'];
      Total_hours = bookingBalance['Total_hours'];
      TodayCashIn = bookingBalance['TodayCashIn'];
      chart = bookingBalance['chart'];
      print(body);


      chartsModels =  ChartsModels.fromJson(read);

      chartsModels!.leatestBookings.forEach((element) {
        leatestBooking.add(element);
      });



      print(chart);
      if(populationData2.isNotEmpty){
        hasData = false ;
      }else{
        hasData = true ;
        for(int i=0;i<6;i++) {
          chart.forEach((key,value) => populationData.add(WorldPopulation(week[i], value)));
        }
      }

      print("Succeed");

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
    update();
  }


}