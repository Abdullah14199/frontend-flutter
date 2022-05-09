// To parse this JSON data, do
//
//     final ratingModel = ratingModelFromJson(jsonString);

import 'dart:convert';

RatingModel ratingModelFromJson(String str) => RatingModel.fromJson(json.decode(str));

String ratingModelToJson(RatingModel data) => json.encode(data.toJson());

class RatingModel {
  RatingModel({
    required this.cleanerRatings,
    required this.ratingCount,
  });

  List<CleanerRating> cleanerRatings;
  RatingCount ratingCount;

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
    cleanerRatings: List<CleanerRating>.from(json["CleanerRatings"].map((x) => CleanerRating.fromJson(x))),
    ratingCount: RatingCount.fromJson(json["RatingCount"]),
  );

  Map<String, dynamic> toJson() => {
    "CleanerRatings": List<dynamic>.from(cleanerRatings.map((x) => x.toJson())),
    "RatingCount": ratingCount.toJson(),
  };
}

class CleanerRating {
  CleanerRating({
    required  this.comment,
    required  this.rate,
    required  this.date,
  });

  String comment;
  int rate;
  String date;

  factory CleanerRating.fromJson(Map<String, dynamic> json) => CleanerRating(
    comment: json["comment"],
    rate: json["rate"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "comment": comment,
    "rate": rate,
    "date": date,
  };
}

class RatingCount {
  RatingCount({
    required this.bad,
    required this.meh,
    required this.good,
    required this.great,
    required this.awesome,
  });

  int bad;
  int meh;
  int good;
  int great;
  int awesome;

  factory RatingCount.fromJson(Map<String, dynamic> json) => RatingCount(
    bad: json["Bad"],
    meh: json["Meh"],
    good: json["Good"],
    great: json["Great"],
    awesome: json["Awesome"],
  );

  Map<String, dynamic> toJson() => {
    "Bad": bad,
    "Meh": meh,
    "Good": good,
    "Great": great,
    "Awesome": awesome,
  };
}
