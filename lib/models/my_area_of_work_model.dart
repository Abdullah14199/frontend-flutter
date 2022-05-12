// To parse this JSON data, do
//
//     final myAreaOfWorkModel = myAreaOfWorkModelFromJson(jsonString);

import 'dart:convert';

MyAreaOfWorkModel myAreaOfWorkModelFromJson(String str) => MyAreaOfWorkModel.fromJson(json.decode(str));

String myAreaOfWorkModelToJson(MyAreaOfWorkModel data) => json.encode(data.toJson());

class MyAreaOfWorkModel {
  MyAreaOfWorkModel({
    required this.userCities,
  });

  List<UserCity> userCities;

  factory MyAreaOfWorkModel.fromJson(Map<String, dynamic> json) => MyAreaOfWorkModel(
    userCities: List<UserCity>.from(json["UserCities"].map((x) => UserCity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UserCities": List<dynamic>.from(userCities.map((x) => x.toJson())),
  };
}

class UserCity {
  UserCity({
    required this.id,
    required this.regionId,
    required this.regionName,
    required this.regionLatLng,
    required this.centerPositions,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  int id;
  String regionId;
  String regionName;
  List<CenterPositions> regionLatLng;
  CenterPositions centerPositions;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  factory UserCity.fromJson(Map<String, dynamic> json) => UserCity(
    id: json["id"],
    regionId: json["region_id"],
    regionName: json["region_name"],
    regionLatLng: List<CenterPositions>.from(json["region_lat_lng"].map((x) => CenterPositions.fromJson(x))),
    centerPositions: CenterPositions.fromJson(json["center_positions"]),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "region_id": regionId,
    "region_name": regionName,
    "region_lat_lng": List<dynamic>.from(regionLatLng.map((x) => x.toJson())),
    "center_positions": centerPositions.toJson(),
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class CenterPositions {
  CenterPositions({
    required this.lat,
    required this.lng,
  });

  String lat;
  String lng;

  factory CenterPositions.fromJson(Map<String, dynamic> json) => CenterPositions(
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Pivot {
  Pivot({
    required this.userId,
    required this.cityId,
  });

  int userId;
  int cityId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    userId: json["user_id"],
    cityId: json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "city_id": cityId,
  };
}
