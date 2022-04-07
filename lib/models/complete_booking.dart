// To parse this JSON data, do
//
//     final myBookingModel = myBookingModelFromJson(jsonString);

import 'dart:convert';

CompleteBooking myBookingModelFromJson(String str) => CompleteBooking.fromJson(json.decode(str));

String myBookingModelToJson(CompleteBooking data) => json.encode(data.toJson());

class CompleteBooking {
  CompleteBooking({
    required this.history,
    required this.schedule,
  });

  List<dynamic> schedule;
  List<HistoryBooking> history;

  factory CompleteBooking.fromJson(Map<String, dynamic> json) => CompleteBooking(
    schedule  : List<dynamic>.from(json["schedule"].map((x) => x)),
    history : List<HistoryBooking>.from(json["history"].map((x) => HistoryBooking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "schedule": List<dynamic>.from(schedule.map((x) => x)),
    "history": List<dynamic>.from(history.map((x) => x.toJson())),
  };
}

class HistoryBooking {
  HistoryBooking({
    required  this.id,
    required  this.bookingStatus,
    required  this.bookingDate,
    required  this.date,
    required this.time,
    required this.frequency,
    required this.bookingHours,
    required  this.extraServ,
    required  this.placeId,
    required  this.placeName,
    required this.placeAddress,
    this.placeInstructions,
    required this.dens,
    required  this.pets,
    required  this.bedrooms,
    required  this.bathrooms,
    required this.lat,
    required this.lng,
    required  this.homwowner,
    required  this.readableDate,
    required this.image,
    required this.fullName,
    required this.homeownerPhone,
    required this.rate,
    required this.firebaseUid,
    required  this.fcmToken,
    required this.salary,
    required this.homwownerPenalty,
  });

  int id;
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
  dynamic homwowner;
  String readableDate;
  String image;
  String fullName;
  String homeownerPhone;
  String rate;
  String firebaseUid;
  String fcmToken;
  double salary;
  String homwownerPenalty;

  factory HistoryBooking.fromJson(Map<String, dynamic> json) => HistoryBooking(
    id: json["id"],
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
    homwowner: json["homwowner"],
    readableDate: json["readable_date"],
    image: json["image"],
    fullName: json["FullName"],
    homeownerPhone: json["homeowner_phone"],
    rate: json["rate"],
    firebaseUid: json["firebase_uid"],
    fcmToken:  json["fcm_token"]==null?"":json["fcm_token"],
    salary: json["salary"].toDouble(),
    homwownerPenalty: json["homwowner_penalty"]==null?"":json["homwowner_penalty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
    "homwowner": homwowner,
    "readable_date": readableDate,
    "image": image,
    "FullName": fullName,
    "homeowner_phone": homeownerPhone,
    "rate": rate,
    "firebase_uid": firebaseUid,
    "fcm_token": fcmToken == null ? null : fcmToken,
    "salary": salary,
    "homwowner_penalty": homwownerPenalty,
  };
}

class ExtraServ {
  ExtraServ({
    required this.id,
    required this.name,
    required this.price,
    required this.minutes,
    required this.pivot,
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
    required  this.bookingId,
    required  this.extraServiceId,
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

// class History {
//   History({
//     required  this.id,
//     required  this.bookingStatus,
//     required  this.bookingDate,
//     required  this.date,
//     required this.time,
//     required this.frequency,
//     required this.bookingHours,
//     required  this.extraServ,
//     required  this.placeId,
//     required  this.placeName,
//     required this.placeAddress,
//     this.placeInstructions,
//     required this.dens,
//     required  this.pets,
//     required  this.bedrooms,
//     required  this.bathrooms,
//     required this.lat,
//     required this.lng,
//     this.homwowner,
//     required  this.readableDate,
//     required this.image,
//     required this.fullName,
//     required this.homeownerPhone,
//     required this.rate,
//     required this.firebaseUid,
//     required  this.fcmToken,
//     required this.salary,
//     required this.homwownerPenalty,
//   });
//
//   int id;
//   String bookingStatus;
//   DateTime bookingDate;
//   String date;
//   String time;
//   String frequency;
//   double bookingHours;
//   List<ExtraServ> extraServ;
//   int placeId;
//   String placeName;
//   String placeAddress;
//   dynamic placeInstructions;
//   int dens;
//   int pets;
//   int bedrooms;
//   int bathrooms;
//   String lat;
//   String lng;
//   dynamic homwowner;
//   String readableDate;
//   String image;
//   String fullName;
//   String homeownerPhone;
//   String rate;
//   String firebaseUid;
//   String fcmToken;
//   double salary;
//   String homwownerPenalty;
//
//   factory History.fromJson(Map<String, dynamic> json) => History(
//     id: json["id"],
//     bookingStatus: json["booking_status"],
//     bookingDate: DateTime.parse(json["booking_date"]),
//     date: json["date"],
//     time: json["time"],
//     frequency: json["frequency"],
//     bookingHours: json["booking_hours"].toDouble(),
//     extraServ: List<ExtraServ>.from(json["extra_serv"].map((x) => ExtraServ.fromJson(x))),
//     placeId: json["place_id"],
//     placeName: json["place_name"],
//     placeAddress: json["place_address"],
//     placeInstructions: json["place_instructions"],
//     dens: json["dens"],
//     pets: json["pets"],
//     bedrooms: json["bedrooms"],
//     bathrooms: json["bathrooms"],
//     lat: json["lat"],
//     lng: json["lng"],
//     homwowner: json["homwowner"],
//     readableDate: json["readable_date"],
//     image: json["image"],
//     fullName: json["FullName"],
//     homeownerPhone: json["homeowner_phone"],
//     rate: json["rate"],
//     firebaseUid: json["firebase_uid"],
//     fcmToken:  json["fcm_token"]==null?"":json["fcm_token"],
//     salary: json["salary"].toDouble(),
//     homwownerPenalty: json["homwowner_penalty"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "booking_status": bookingStatus,
//     "booking_date": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
//     "date": date,
//     "time": time,
//     "frequency": frequency,
//     "booking_hours": bookingHours,
//     "extra_serv": List<dynamic>.from(extraServ.map((x) => x.toJson())),
//     "place_id": placeId,
//     "place_name": placeName,
//     "place_address": placeAddress,
//     "place_instructions": placeInstructions,
//     "dens": dens,
//     "pets": pets,
//     "bedrooms": bedrooms,
//     "bathrooms": bathrooms,
//     "lat": lat,
//     "lng": lng,
//     "homwowner": homwowner,
//     "readable_date": readableDate,
//     "image": image,
//     "FullName": fullName,
//     "homeowner_phone": homeownerPhone,
//     "rate": rate,
//     "firebase_uid": firebaseUid,
//     "fcm_token": fcmToken == null ? null : fcmToken,
//     "salary": salary,
//     "homwowner_penalty": homwownerPenalty,
//   };
// }


