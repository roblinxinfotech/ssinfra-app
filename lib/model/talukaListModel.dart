// To parse this JSON data, do
//
//     final talukaListModel = talukaListModelFromJson(jsonString);

import 'dart:convert';

TalukaListModel talukaListModelFromJson(String str) => TalukaListModel.fromJson(json.decode(str));

String talukaListModelToJson(TalukaListModel data) => json.encode(data.toJson());

class TalukaListModel {
  int? status;
  String? message;
  List<Datum>? data;

  TalukaListModel({
    this.status,
    this.message,
    this.data,
  });

  factory TalukaListModel.fromJson(Map<String, dynamic> json) => TalukaListModel(
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
  int? subDistrictId;
  String? name;
  int? code;
  dynamic assignDate;
  dynamic assignedBy;
  int? villagesCount;
  int? teamsCount;

  Datum({
    this.id,
    this.subDistrictId,
    this.name,
    this.code,
    this.assignDate,
    this.assignedBy,
    this.villagesCount,
    this.teamsCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    subDistrictId: json["sub_district_id"],
    name: json["name"],
    code: json["code"],
    assignDate: json["assign_date"],
    assignedBy: json["assigned_by"],
    villagesCount: json["villages_count"],
    teamsCount: json["teams_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_district_id": subDistrictId,
    "name": name,
    "code": code,
    "assign_date": assignDate,
    "assigned_by": assignedBy,
    "villages_count": villagesCount,
    "teams_count": teamsCount,
  };
}
