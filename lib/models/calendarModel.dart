// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    required  this.booking,
  });

  Map<String, List<Booking>> booking;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    booking: Map.from(json["Booking"]).map((k, v) => MapEntry<String, List<Booking>>(k, List<Booking>.from(v.map((x) => Booking.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "Booking": Map.from(booking).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
  };
}

class Booking {
  Booking({
    required   this.id,
    required  this.image,
    required  this.fullName,
    required   this.homeownerPhone,
    required   this.rate,
    required  this.firebaseUid,
    required  this.fcmToken,
    required  this.bookingStatus,
    required   this.bookingDate,
    required   this.date,
    required   this.time,
    required  this.frequency,
    required  this.bookingHours,
    required  this.extraServ,
    required  this.placeId,
    required  this.placeName,
    required  this.placeAddress,
    this.placeInstructions,
    required  this.dens,
    required this.pets,
    required   this.bedrooms,
    required  this.bathrooms,
    required   this.lat,
    required  this.lng,
    required   this.jobId,
    required   this.readableDate,
    required  this.openRateing,
    required  this.hasBankAccount,
    required   this.cleanerPenalty,
    required   this.salary,
  });

  int id;
  String image;
  String fullName;
  String homeownerPhone;
  String rate;
  String firebaseUid;
  String fcmToken;
  String bookingStatus;
  DateTime bookingDate;
  String date;
  String time;
  String frequency;
  double bookingHours;
  List<ExtraServ> extraServ;
  int placeId;
  String placeName;
  String placeAddress;
  dynamic placeInstructions;
  int dens;
  int pets;
  int bedrooms;
  int bathrooms;
  String lat;
  String lng;
  String jobId;
  String readableDate;
  bool openRateing;
  bool hasBankAccount;
  String cleanerPenalty;
  double salary;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    image: json["image"],
    fullName: json["FullName"],
    homeownerPhone: json["homeowner_phone"],
    rate: json["rate"],
    firebaseUid: json["firebase_uid"],
    fcmToken: json["fcm_token"]==null?"":json["fcm_token"],
    bookingStatus: json["booking_status"],
    bookingDate: DateTime.parse(json["booking_date"]),
    date: json["date"],
    time: json["time"],
    frequency: json["frequency"],
    bookingHours: json["booking_hours"].toDouble(),
    extraServ: List<ExtraServ>.from(json["extra_serv"].map((x) => ExtraServ.fromJson(x))),
    placeId: json["place_id"],
    placeName: json["place_name"],
    placeAddress: json["place_address"],
    placeInstructions: json["place_instructions"],
    dens: json["dens"],
    pets: json["pets"],
    bedrooms: json["bedrooms"],
    bathrooms: json["bathrooms"],
    lat: json["lat"],
    lng: json["lng"],
    jobId: json["job_id"],
    readableDate: json["readable_date"],
    openRateing: json["open_rateing"],
    hasBankAccount: json["has_bank_account"],
    cleanerPenalty: json["cleaner_penalty"],
    salary: json["salary"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "FullName": fullName,
    "homeowner_phone": homeownerPhone,
    "rate": rate,
    "firebase_uid": firebaseUid,
    "fcm_token": fcmToken == null ? null : fcmToken,
    "booking_status": bookingStatus,
    "booking_date": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
    "date": date,
    "time": time,
    "frequency": frequency,
    "booking_hours": bookingHours,
    "extra_serv": List<dynamic>.from(extraServ.map((x) => x.toJson())),
    "place_id": placeId,
    "place_name": placeName,
    "place_address": placeAddress,
    "place_instructions": placeInstructions,
    "dens": dens,
    "pets": pets,
    "bedrooms": bedrooms,
    "bathrooms": bathrooms,
    "lat": lat,
    "lng": lng,
    "job_id": jobId,
    "readable_date": readableDate,
    "open_rateing": openRateing,
    "has_bank_account": hasBankAccount,
    "cleaner_penalty": cleanerPenalty,
    "salary": salary,
  };
}

class ExtraServ {
  ExtraServ({
    required this.id,
    required this.name,
    required  this.price,
    required this.minutes,
    required  this.pivot,
  });

  int id;
  String name;
  String price;
  String minutes;
  Pivot pivot;

  factory ExtraServ.fromJson(Map<String, dynamic> json) => ExtraServ(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    minutes: json["minutes"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "minutes": minutes,
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  Pivot({
   required this.bookingId,
    required this.extraServiceId,
  });

  int bookingId;
  int extraServiceId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    bookingId: json["booking_id"],
    extraServiceId: json["extra_service_id"],
  );

  Map<String, dynamic> toJson() => {
    "booking_id": bookingId,
    "extra_service_id": extraServiceId,
  };
}
