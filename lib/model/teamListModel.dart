// To parse this JSON data, do
//
//     final teamListModel = teamListModelFromJson(jsonString);

import 'dart:convert';

TeamListModel teamListModelFromJson(String str) =>
    TeamListModel.fromJson(json.decode(str));

String teamListModelToJson(TeamListModel data) => json.encode(data.toJson());

class TeamListModel {
  int? status;
  String? message;
  List<TeamList>? data;

  TeamListModel({this.status, this.message, this.data});

  factory TeamListModel.fromJson(Map<String, dynamic> json) => TeamListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null
        ? []
        : List<TeamList>.from(json["data"]!.map((x) => TeamList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TeamList {
  int? id;
  int? subDistrictId;
  int? townId;
  String? username;
  String? fullname;
  String? profilePhoto;
  int? isVerified;
  dynamic rejectionReason;
  List<AssignedVillage>? assignedVillages;
  List<AssignedWard>? assignedWards;

  TeamList({
    this.id,
    this.subDistrictId,
    this.townId,
    this.username,
    this.fullname,
    this.profilePhoto,
    this.isVerified,
    this.rejectionReason,
    this.assignedVillages,
    this.assignedWards,
  });

  factory TeamList.fromJson(Map<String, dynamic> json) => TeamList(
    id: json["id"],
    subDistrictId: json["sub_district_id"],
    townId: json["town_id"],
    username: json["username"],
    fullname: json["fullname"],
    profilePhoto: json["profile_photo"],
    isVerified: json["is_verified"],
    rejectionReason: json["rejection_reason"],
    assignedVillages: json["assigned_villages"] == null
        ? []
        : List<AssignedVillage>.from(
            json["assigned_villages"]!.map((x) => AssignedVillage.fromJson(x)),
          ),
    assignedWards: json["assigned_wards"] == null
        ? []
        : List<AssignedWard>.from(
            json["assigned_wards"]!.map((x) => AssignedWard.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_district_id": subDistrictId,
    "username": username,
    "fullname": fullname,
    "profile_photo": profilePhoto,
    "is_verified": isVerified,
    "rejection_reason": rejectionReason,
    "assigned_villages": assignedVillages == null
        ? []
        : List<dynamic>.from(assignedVillages!.map((x) => x.toJson())),
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

class AssignedWard {
  int? id;
  String? name;
  int? code;

  AssignedWard({this.id, this.name, this.code});

  factory AssignedWard.fromJson(Map<String, dynamic> json) =>
      AssignedWard(id: json["id"], name: json["name"], code: json["code"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "code": code};
}
