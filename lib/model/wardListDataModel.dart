// To parse this JSON data, do
//
//     final wardListDataModel = wardListDataModelFromJson(jsonString);

import 'dart:convert';

WardListDataModel wardListDataModelFromJson(String str) => WardListDataModel.fromJson(json.decode(str));

String wardListDataModelToJson(WardListDataModel data) => json.encode(data.toJson());

class WardListDataModel {
  int? status;
  String? message;
  Data? data;

  WardListDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory WardListDataModel.fromJson(Map<String, dynamic> json) => WardListDataModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] is Map<String, dynamic>
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
  District? town;
  List<Ward>? wards;

  Data({
    this.state,
    this.district,
    this.town,
    this.wards,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    state: json["state"] == null ? null : District.fromJson(json["state"]),
    district: json["district"] == null ? null : District.fromJson(json["district"]),
    town: json["town"] == null ? null : District.fromJson(json["town"]),
    wards: json["wards"] == null ? [] : List<Ward>.from(json["wards"]!.map((x) => Ward.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "state": state?.toJson(),
    "district": district?.toJson(),
    "town": town?.toJson(),
    "wards": wards == null ? [] : List<dynamic>.from(wards!.map((x) => x.toJson())),
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

class Ward {
  int? id;
  dynamic name;
  dynamic code;
  DateTime? assignDate;
  int? assignedBy;
  int? progress;

  Ward({
    this.id,
    this.name,
    this.code,
    this.assignDate,
    this.assignedBy,
    this.progress,
  });

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
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
