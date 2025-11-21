// To parse this JSON data, do
//
//     final assignedVillageListModel = assignedVillageListModelFromJson(jsonString);

import 'dart:convert';

AssignedVillageListModel assignedVillageListModelFromJson(String str) =>
    AssignedVillageListModel.fromJson(json.decode(str));

String assignedVillageListModelToJson(AssignedVillageListModel data) =>
    json.encode(data.toJson());

class AssignedVillageListModel {
  int? status;
  String? message;
  List<AssignedVillage>? data;

  AssignedVillageListModel({this.status, this.message, this.data});

  factory AssignedVillageListModel.fromJson(Map<String, dynamic> json) =>
      AssignedVillageListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AssignedVillage>.from(
                json["data"]!.map((x) => AssignedVillage.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AssignedVillage {
  int? id;
  String? name;
  int? code;

  AssignedVillage({this.id, this.name, this.code});

  factory AssignedVillage.fromJson(Map<String, dynamic> json) =>
      AssignedVillage(id: json["id"], name: json["name"], code: json["code"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "code": code};
}
