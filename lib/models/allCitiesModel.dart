// To parse this JSON data, do
//
//     final allCitiesModel = allCitiesModelFromJson(jsonString);

import 'dart:convert';

AllCitiesModel allCitiesModelFromJson(String str) => AllCitiesModel.fromJson(json.decode(str));

String allCitiesModelToJson(AllCitiesModel data) => json.encode(data.toJson());

class AllCitiesModel {
  AllCitiesModel({
    required this.allCitys,
  });

  List<AllCity> allCitys;

  factory AllCitiesModel.fromJson(Map<String, dynamic> json) => AllCitiesModel(
    allCitys: List<AllCity>.from(json["AllCitys"].map((x) => AllCity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "AllCitys": List<dynamic>.from(allCitys.map((x) => x.toJson())),
  };
}

class AllCity {
  AllCity({
    required this.id,
    required this.regionId,
    required this.regionName,
    required this.regionLatLng,
    required this.centerPositions,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String regionId;
  String regionName;
  List<CenterPositions> regionLatLng;
  CenterPositions centerPositions;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory AllCity.fromJson(Map<String, dynamic> json) => AllCity(
    id: json["id"],
    regionId: json["region_id"],
    regionName: json["region_name"],
    regionLatLng: List<CenterPositions>.from(json["region_lat_lng"].map((x) => CenterPositions.fromJson(x))),
    centerPositions: CenterPositions.fromJson(json["center_positions"]),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
