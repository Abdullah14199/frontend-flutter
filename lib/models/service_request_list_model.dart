// To parse this JSON data, do
//
//     final serviceRequestListModel = serviceRequestListModelFromJson(jsonString);

import 'dart:convert';

ServiceRequestListModel serviceRequestListModelFromJson(String str) => ServiceRequestListModel.fromJson(json.decode(str));

String serviceRequestListModelToJson(ServiceRequestListModel data) => json.encode(data.toJson());

class ServiceRequestListModel {
  ServiceRequestListModel({
   required this.serviceRequest,
  });

  List<ServiceRequestList> serviceRequest;

  factory ServiceRequestListModel.fromJson(Map<String, dynamic> json) => ServiceRequestListModel(
    serviceRequest: List<ServiceRequestList>.from(json["ServiceRequest"].map((x) => ServiceRequestList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ServiceRequest": List<dynamic>.from(serviceRequest.map((x) => x.toJson())),
  };
}

class ServiceRequestList {
  ServiceRequestList({
    required this.id,
    required this.image,
    required this.fullName,
    required this.rate,
    required this.bookingDate,
    required this.readableDate,
    required this.date,
    required this.time,
    required this.frequency,
    required this.extraServ,
    required this.placeAddress,
    required this.salary,
  });

  int id;
  dynamic image;
  String fullName;
  String rate;
  DateTime bookingDate;
  String readableDate;
  String date;
  String time;
  String frequency;
  List<dynamic> extraServ;
  String placeAddress;
  double salary;

  factory ServiceRequestList.fromJson(Map<String, dynamic> json) => ServiceRequestList(
    id: json["id"],
    image: json["image"],
    fullName: json["FullName"],
    rate: json["rate"],
    bookingDate: DateTime.parse(json["booking_date"]),
    readableDate: json["readable_date"],
    date: json["date"],
    time: json["time"],
    frequency: json["frequency"],
    extraServ: List<dynamic>.from(json["extra_serv"].map((x) => x)),
    placeAddress: json["place_address"],
    salary: json["salary"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "FullName": fullName,
    "rate": rate,
    "booking_date": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
    "readable_date": readableDate,
    "date": date,
    "time": time,
    "frequency": frequency,
    "extra_serv": List<dynamic>.from(extraServ.map((x) => x)),
    "place_address": placeAddress,
    "salary": salary,
  };
}
