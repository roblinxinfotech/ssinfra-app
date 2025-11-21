// To parse this JSON data, do
//
//     final villageToTalukaListModel = villageToTalukaListModelFromJson(jsonString);

import 'dart:convert';

VillageListAssignModel villageToTalukaListModelFromJson(String str) => VillageListAssignModel.fromJson(json.decode(str));

String villageListAssignModelToJson(VillageListAssignModel data) => json.encode(data.toJson());

class VillageListAssignModel {
  int? status;
  String? message;
  List<Datum>? data;

  VillageListAssignModel({
    this.status,
    this.message,
    this.data,
  });

  factory VillageListAssignModel.fromJson(Map<String, dynamic> json) => VillageListAssignModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;
  int? code;
  bool? isAssigned;

  Datum({
    this.id,
    this.name,
    this.code,
    this.isAssigned,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    isAssigned: json["is_assigned"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "is_assigned": isAssigned,
  };
}
