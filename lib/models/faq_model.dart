// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    required this.faq,
  });

  List<Faq> faq;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    faq: List<Faq>.from(json["FAQ"].map((x) => Faq.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "FAQ": List<dynamic>.from(faq.map((x) => x.toJson())),
  };
}

class Faq {
  Faq({
  required  this.id,
    required this.questions,
    required this.answers,
    required this.userType,
    required this.url,
    required this.testUrl,
    this.typeId,
    required  this.createdAt,
    required  this.updatedAt,
  });

  int id;
  String questions;
  String answers;
  String userType;
  String url;
  String testUrl;
  dynamic typeId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    id: json["id"],
    questions: json["questions"],
    answers: json["answers"],
    userType: json["user_type"],
    url: json["url"] == null ? "" : json["url"],
    testUrl: json["test_url"] == null ? "" : json["test_url"],
    typeId: json["type_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questions": questions,
    "answers": answers,
    "user_type": userType,
    "url": url == null ? null : url,
    "test_url": testUrl == null ? null : testUrl,
    "type_id": typeId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
