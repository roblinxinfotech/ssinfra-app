// To parse this JSON data, do
//
//     final assignedTownModel = assignedTownModelFromJson(jsonString);

import 'dart:convert';

AssignedTownModel assignedTownModelFromJson(String str) => AssignedTownModel.fromJson(json.decode(str));

String assignedTownModelToJson(AssignedTownModel data) => json.encode(data.toJson());

class AssignedTownModel {
  int? status;
  String? message;
  List<AssignedTown>? data;

  AssignedTownModel({
    this.status,
    this.message,
    this.data,
  });

  factory AssignedTownModel.fromJson(Map<String, dynamic> json) => AssignedTownModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AssignedTown>.from(json["data"]!.map((x) => AssignedTown.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AssignedTown {
  int? id;
  int? townId;
  String? name;
  int? code;
  DateTime? assignDate;
  int? assignedBy;
  int? wardsCount;
  int? teamsCount;

  AssignedTown({
    this.id,
    this.townId,
    this.name,
    this.code,
    this.assignDate,
    this.assignedBy,
    this.wardsCount,
    this.teamsCount,
  });

  factory AssignedTown.fromJson(Map<String, dynamic> json) => AssignedTown(
    id: json["id"],
    townId: json["town_id"],
    name: json["name"],
    code: json["code"],
    assignDate: json["assign_date"] == null ? null : DateTime.parse(json["assign_date"]),
    assignedBy: json["assigned_by"],
    wardsCount: json["wards_count"],
    teamsCount: json["teams_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "town_id": townId,
    "name": name,
    "code": code,
    "assign_date": "${assignDate!.year.toString().padLeft(4, '0')}-${assignDate!.month.toString().padLeft(2, '0')}-${assignDate!.day.toString().padLeft(2, '0')}",
    "assigned_by": assignedBy,
    "wards_count": wardsCount,
    "teams_count": teamsCount,
  };
}
