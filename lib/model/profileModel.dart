// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int? status;
  String? message;
  Data? data;

  ProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  String? username;
  String? email;
  String? fullname;
  dynamic gender;
  String? mobile;
  DateTime? dob;
  dynamic bloodGroup;
  String? profilePhoto;
  String? role;

  Data({
    this.id,
    this.username,
    this.email,
    this.fullname,
    this.gender,
    this.mobile,
    this.dob,
    this.bloodGroup,
    this.profilePhoto,
    this.role,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    fullname: json["fullname"],
    gender: json["gender"],
    mobile: json["mobile"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    bloodGroup: json["blood_group"],
    profilePhoto: json["profile_photo"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "fullname": fullname,
    "gender": gender,
    "mobile": mobile,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "blood_group": bloodGroup,
    "profile_photo": profilePhoto,
    "role": role,
  };
}
