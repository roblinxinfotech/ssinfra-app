// To parse this JSON data, do
//
//     final userAssignedWard = userAssignedWardFromJson(jsonString);

import 'dart:convert';

UserAssignedWard userAssignedWardFromJson(String str) => UserAssignedWard.fromJson(json.decode(str));

String userAssignedWardToJson(UserAssignedWard data) => json.encode(data.toJson());

class UserAssignedWard {
  int? status;
  String? message;
  List<UserAssignedWardLIst>? data;

  UserAssignedWard({
    this.status,
    this.message,
    this.data,
  });

  factory UserAssignedWard.fromJson(Map<String, dynamic> json) => UserAssignedWard(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<UserAssignedWardLIst>.from(json["data"]!.map((x) => UserAssignedWardLIst.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UserAssignedWardLIst {
  int? id;
  String? name;
  int? code;

  UserAssignedWardLIst({
    this.id,
    this.name,
    this.code,
  });

  factory UserAssignedWardLIst.fromJson(Map<String, dynamic> json) => UserAssignedWardLIst(
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
