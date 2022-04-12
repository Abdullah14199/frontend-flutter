// To parse this JSON data, do
//
//     final checkListModel = checkListModelFromJson(jsonString);

import 'dart:convert';

ExtraServiceListModel checkListModelFromJson(String str) => ExtraServiceListModel.fromJson(json.decode(str));

String checkListModelToJson(ExtraServiceListModel data) => json.encode(data.toJson());

class ExtraServiceListModel {
  ExtraServiceListModel({
    required this.mainServices,
    required this.extraServices,
  });

  List<dynamic> mainServices;
  List<ExtraService> extraServices;

  factory ExtraServiceListModel.fromJson(Map<String, dynamic> json) => ExtraServiceListModel(
    mainServices: List<dynamic>.from(json["Main_Services"].map((x) => x)),
    extraServices: List<ExtraService>.from(json["Extra_Services"].map((x) => ExtraService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Main_Services": List<dynamic>.from(mainServices.map((x) => x.toJson())),
    "Extra_Services": List<dynamic>.from(extraServices.map((x) => x.toJson())),
  };
}

class ExtraService {
  ExtraService({
    required this.id,
    required this.bookingChecklistItems,
    required this.itemId,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  int id;
  int bookingChecklistItems;
  int itemId;
  String type;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  Items items;

  factory ExtraService.fromJson(Map<String, dynamic> json) => ExtraService(
    id: json["id"],
    bookingChecklistItems: json["booking_checklist_items"],
    itemId: json["item_id"],
    type: json["type"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    items: Items.fromJson(json["items"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_checklist_items": bookingChecklistItems,
    "item_id": itemId,
    "type": type,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "items": items.toJson(),
  };
}

class Items {
  Items({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String description;
  int type;
  DateTime createdAt;
  DateTime updatedAt;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_At"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "type": type,
    "created_at": createdAt.toIso8601String(),
    "updated_At": updatedAt.toIso8601String(),
  };
}
