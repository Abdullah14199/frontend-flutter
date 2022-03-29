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
  List<dynamic> leatestBookings;
  Map<String, int> chart;

  factory ChartsModels.fromJson(Map<String, dynamic> json) => ChartsModels(
    bookingBalance: json["BookingBalance"],
    weekBalance: json["WeekBalance"],
    monthBalance: json["MonthBalance"],
    bookingCount: json["BookingCount"],
    totalHours: json["Total_hours"],
    todayCashIn: json["TodayCashIn"],
    leatestBookings: List<dynamic>.from(json["leatestBookings"].map((x) => x)),
    chart: Map.from(json["chart"]).map((k, v) => MapEntry<String, int>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "BookingBalance": bookingBalance,
    "WeekBalance": weekBalance,
    "MonthBalance": monthBalance,
    "BookingCount": bookingCount,
    "Total_hours": totalHours,
    "TodayCashIn": todayCashIn,
    "leatestBookings": List<dynamic>.from(leatestBookings.map((x) => x)),
    "chart": Map.from(chart).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
