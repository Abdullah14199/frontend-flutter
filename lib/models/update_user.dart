// To parse this JSON data, do
//
//     final updateUser = updateUserFromJson(jsonString);

import 'dart:convert';

UpdateUser updateUserFromJson(String str) => UpdateUser.fromJson(json.decode(str));

String updateUserToJson(UpdateUser data) => json.encode(data.toJson());

class UpdateUser {
  UpdateUser({
   required this.user,
  });

  User user;

  factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.dateOfBirth,
    required this.lat,
    required this.lng,
    required this.fcmToken,
    required this.firebaseUid,
    required  this.deviceId,
    required  this.registrationType,
    required this.userType,
    required this.isVerfied,
    required this.selfie,
    required this.gender,
    required this.countryInti,
    required this.status,
    required this.hasPlaces,
    required this.rate,
    required this.criminalFree,
    required this.createdAt,
    required this.updatedAt,
    required this.emailVerified,
    required this.cleanerCity,
    required this.address,
    required  this.certnWizerd,
    required  this.level,
    required  this.levelStatus,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String countryCode;
  String dateOfBirth;
  String lat;
  String lng;
  String fcmToken;
  String firebaseUid;
  String deviceId;
  dynamic registrationType;
  String userType;
  bool isVerfied;
  String selfie;
  String gender;
  String countryInti;
  int status;
  bool hasPlaces;
  String rate;
  DateTime criminalFree;
  DateTime createdAt;
  DateTime updatedAt;
  bool emailVerified;
  dynamic cleanerCity;
  String address;
  bool certnWizerd;
  String level;
  String levelStatus;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    countryCode: json["country_code"],
    dateOfBirth: json["date_of_birth"],
    lat: json["lat"],
    lng: json["lng"],
    fcmToken: json["fcm_token"],
    firebaseUid: json["firebase_uid"],
    deviceId: json["device_id"],
    registrationType: json["registration_type"],
    userType: json["user_type"],
    isVerfied: json["is_verfied"],
    selfie: json["selfie"],
    gender: json["gender"],
    countryInti: json["country_inti"],
    status: json["status"],
    hasPlaces: json["has_places"],
    rate: json["rate"],
    criminalFree: DateTime.parse(json["criminal_free"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    emailVerified: json["email_verified"],
    cleanerCity: json["cleaner_city"],
    address: json["address"],
    certnWizerd: json["certn_wizerd"],
    level: json["level"],
    levelStatus: json["level_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "country_code": countryCode,
    "date_of_birth": dateOfBirth,
    "lat": lat,
    "lng": lng,
    "fcm_token": fcmToken,
    "firebase_uid": firebaseUid,
    "device_id": deviceId,
    "registration_type": registrationType,
    "user_type": userType,
    "is_verfied": isVerfied,
    "selfie": selfie,
    "gender": gender,
    "country_inti": countryInti,
    "status": status,
    "has_places": hasPlaces,
    "rate": rate,
    "criminal_free": criminalFree.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "email_verified": emailVerified,
    "cleaner_city": cleanerCity,
    "address": address,
    "certn_wizerd": certnWizerd,
    "level": level,
    "level_status": levelStatus,
  };
}
