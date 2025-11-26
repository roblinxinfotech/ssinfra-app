// To parse this JSON data, do
//
//     final assignedVillageWardModel = assignedVillageWardModelFromJson(jsonString);

import 'dart:convert';

AssignedVillageWardModel assignedVillageWardModelFromJson(String str) => AssignedVillageWardModel.fromJson(json.decode(str));

String assignedVillageWardModelToJson(AssignedVillageWardModel data) => json.encode(data.toJson());

class AssignedVillageWardModel {
  int? status;
  String? message;
  Data? data;

  AssignedVillageWardModel({
    this.status,
    this.message,
    this.data,
  });

  factory AssignedVillageWardModel.fromJson(Map<String, dynamic> json) => AssignedVillageWardModel(
    status: json["status"],
    message: json["message"],
    data:  json["data"] is Map<String, dynamic>
        ? Data.fromJson(json["data"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  District? state;
  District? district;
  District? subdistrict;
  List<Village>? villages;

  Data({
    this.state,
    this.district,
    this.subdistrict,
    this.villages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    state: json["state"] == null ? null : District.fromJson(json["state"]),
    district: json["district"] == null ? null : District.fromJson(json["district"]),
    subdistrict: json["subdistrict"] == null ? null : District.fromJson(json["subdistrict"]),
    villages: json["villages"] == null ? [] : List<Village>.from(json["villages"]!.map((x) => Village.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "state": state?.toJson(),
    "district": district?.toJson(),
    "subdistrict": subdistrict?.toJson(),
    "villages": villages == null ? [] : List<dynamic>.from(villages!.map((x) => x.toJson())),
  };
}

class District {
  int? id;
  String? name;
  int? code;

  District({
    this.id,
    this.name,
    this.code,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json["id"],
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
  };
}

class Village {
  int? id;
  String? name;
  int? code;
  DateTime? assignDate;
  int? assignedBy;
  int? progress;

  Village({
    this.id,
    this.name,
    this.code,
    this.assignDate,
    this.assignedBy,
    this.progress,
  });

  factory Village.fromJson(Map<String, dynamic> json) => Village(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    assignDate: json["assign_date"] == null ? null : DateTime.parse(json["assign_date"]),
    assignedBy: json["assigned_by"],
    progress: json["progress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "assign_date": "${assignDate!.year.toString().padLeft(4, '0')}-${assignDate!.month.toString().padLeft(2, '0')}-${assignDate!.day.toString().padLeft(2, '0')}",
    "assigned_by": assignedBy,
    "progress": progress,
  };
}
