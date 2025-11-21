// To parse this JSON data, do
//
//     final villageToTalukaListModel = villageToTalukaListModelFromJson(jsonString);

import 'dart:convert';

VillageToTalukaListModel villageToTalukaListModelFromJson(String str) => VillageToTalukaListModel.fromJson(json.decode(str));

String villageToTalukaListModelToJson(VillageToTalukaListModel data) => json.encode(data.toJson());

class VillageToTalukaListModel {
  int? status;
  String? message;
  List<Datum>? data;

  VillageToTalukaListModel({
    this.status,
    this.message,
    this.data,
  });

  factory VillageToTalukaListModel.fromJson(Map<String, dynamic> json) => VillageToTalukaListModel(
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
