// To parse this JSON data, do
//
//     final ratingUserModel = ratingUserModelFromJson(jsonString);

import 'dart:convert';

RatingUserModel ratingUserModelFromJson(String str) => RatingUserModel.fromJson(json.decode(str));

String ratingUserModelToJson(RatingUserModel data) => json.encode(data.toJson());

class RatingUserModel {
  RatingUserModel({
    required this.data,
  });

  Data data;

  factory RatingUserModel.fromJson(Map<String, dynamic> json) => RatingUserModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.fullName,
    required this.image,
    required this.rate,
  });

  int id;
  String fullName;
  String image;
  String rate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullName: json["FullName"],
    image: json["image"]==""?"":json["image"] ,
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "FullName": fullName,
    "image": image,
    "rate": rate,
  };
}
