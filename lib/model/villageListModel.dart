// To parse this JSON data, do
//
//     final villageListModel = villageListModelFromJson(jsonString);

import 'dart:convert';

VillageListModel villageListModelFromJson(String str) => VillageListModel.fromJson(json.decode(str));

String villageListModelToJson(VillageListModel data) => json.encode(data.toJson());

class VillageListModel {
  int? status;
  String? message;
  Data? data;

  VillageListModel({
    this.status,
    this.message,
    this.data,
  });

  factory VillageListModel.fromJson(Map<String, dynamic> json) => VillageListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  int? code;
  String? name;
  List<Village>? villages;

  Data({
    this.id,
    this.code,
    this.name,
    this.villages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    villages: json["villages"] == null ? [] : List<Village>.from(json["villages"]!.map((x) => Village.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "villages": villages == null ? [] : List<dynamic>.from(villages!.map((x) => x.toJson())),
  };
}

class Village {
  int? id;
  String? name;
  int? code;
  String? category;
  DateTime? assignDate;
  dynamic assignedBy;
  int? progress;

  Village({
    this.id,
    this.name,
    this.code,
    this.category,
    this.assignDate,
    this.assignedBy,
    this.progress,
  });

  factory Village.fromJson(Map<String, dynamic> json) => Village(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    category: json["category"],
    assignDate: json["assign_date"] == null ? null : DateTime.parse(json["assign_date"]),
    assignedBy: json["assigned_by"],
    progress: json["progress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "category": category,
    "assign_date": "${assignDate!.year.toString().padLeft(4, '0')}-${assignDate!.month.toString().padLeft(2, '0')}-${assignDate!.day.toString().padLeft(2, '0')}",
    "assigned_by": assignedBy,
    "progress": progress,
  };
}
