// To parse this JSON data, do
//
//     final chartsModels = chartsModelsFromJson(jsonString);

import 'dart:convert';

ChartsModels chartsModelsFromJson(String str) => ChartsModels.fromJson(json.decode(str));

String chartsModelsToJson(ChartsModels data) => json.encode(data.toJson());

class ChartsModels {
  ChartsModels({
    required this.bookingBalance,
    required this.weekBalance,
    required this.monthBalance,
    required this.bookingCount,
    required this.totalHours,
    required this.todayCashIn,
    required this.leatestBookings,
    required this.chart,
  });

  String bookingBalance;
  String weekBalance;
  String monthBalance;
  int bookingCount;
  String totalHours;
  String todayCashIn;
  List<LeatestBooking> leatestBookings;
  Map<String, int> chart;

  factory ChartsModels.fromJson(Map<String, dynamic> json) => ChartsModels(
    bookingBalance: json["BookingBalance"],
    weekBalance: json["WeekBalance"],
    monthBalance: json["MonthBalance"],
    bookingCount: json["BookingCount"],
    totalHours: json["Total_hours"],
    todayCashIn: json["TodayCashIn"],
    leatestBookings: List<LeatestBooking>.from(json["leatestBookings"].map((x) => LeatestBooking.fromJson(x))),
    chart: Map.from(json["chart"]).map((k, v) => MapEntry<String, int>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "BookingBalance": bookingBalance,
    "WeekBalance": weekBalance,
    "MonthBalance": monthBalance,
    "BookingCount": bookingCount,
    "Total_hours": totalHours,
    "TodayCashIn": todayCashIn,
    "leatestBookings": List<dynamic>.from(leatestBookings.map((x) => x.toJson())),
    "chart": Map.from(chart).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class LeatestBooking {
  LeatestBooking({
    required this.id,
    required this.salary,
    required this.bookingHours,
    required this.fullName,
    required this.time,
  });

  int id;
  int salary;
  int bookingHours;
  String fullName;
  String time;

  factory LeatestBooking.fromJson(Map<String, dynamic> json) => LeatestBooking(
    id: json["id"],
    salary: json["salary"],
    bookingHours: json["booking_hours"],
    fullName: json["FullName"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "salary": salary,
    "booking_hours": bookingHours,
    "FullName": fullName,
    "time": time,
  };
}
