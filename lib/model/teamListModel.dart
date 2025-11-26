// To parse this JSON data, do
//
//     final teamListModel = teamListModelFromJson(jsonString);

import 'dart:convert';

TeamListModel teamListModelFromJson(String str) => TeamListModel.fromJson(json.decode(str));

String teamListModelToJson(TeamListModel data) => json.encode(data.toJson());

class TeamListModel {
  int? status;
  String? message;
  List<TeamList>? data;

  TeamListModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeamListModel.fromJson(Map<String, dynamic> json) => TeamListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TeamList>.from(json["data"]!.map((x) => TeamList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TeamList {
  int? id;
  int? subDistrictId;
  int? townId;
  String? username;
  String? fullname;
  String? email;
  String? mobile;
  String? emergencyMobile;
  String? dob;
  String? bloodGroup;
  String? gender;
  String? address;
  String? profilePhoto;
  int? isVerified;
  String? rejectionReason;
  String? bankName;
  String? branchName;
  String? accountHolderName;
  String? accountNumber;
  String? ifscCode;
  String? aadharFront;
  String? aadharBack;
  String? bankProof;
  String? panFile;
  List<Assigned>? assignedVillages;
  List<Assigned>? assignedWards;

  TeamList({
    this.id,
    this.subDistrictId,
    this.townId,
    this.username,
    this.fullname,
    this.email,
    this.mobile,
    this.emergencyMobile,
    this.dob,
    this.bloodGroup,
    this.gender,
    this.address,
    this.profilePhoto,
    this.isVerified,
    this.rejectionReason,
    this.bankName,
    this.branchName,
    this.accountHolderName,
    this.accountNumber,
    this.ifscCode,
    this.aadharFront,
    this.aadharBack,
    this.bankProof,
    this.panFile,
    this.assignedVillages,
    this.assignedWards,
  });

  factory TeamList.fromJson(Map<String, dynamic> json) => TeamList(
    id: json["id"],
    subDistrictId: json["sub_district_id"],
    townId: json["town_id"],
    username: json["username"],
    fullname: json["fullname"],
    email: json["email"],
    mobile: json["mobile"],
    emergencyMobile: json["emergency_mobile"],
    dob: json["dob"],
    bloodGroup: json["blood_group"],
    gender: json["gender"],
    address: json["address"],
    profilePhoto: json["profile_photo"],
    isVerified: json["is_verified"],
    rejectionReason: json["rejection_reason"],
    bankName: json["bank_name"],
    branchName: json["branch_name"],
    accountHolderName: json["account_holder_name"],
    accountNumber: json["account_number"],
    ifscCode: json["ifsc_code"],
    aadharFront: json["aadhar_front"],
    aadharBack: json["aadhar_back"],
    bankProof: json["bank_proof"],
    panFile: json["pan_file"],
    assignedVillages: json["assigned_villages"] == null ? [] : List<Assigned>.from(json["assigned_villages"]!.map((x) => Assigned.fromJson(x))),
    assignedWards: json["assigned_wards"] == null ? [] : List<Assigned>.from(json["assigned_wards"]!.map((x) => Assigned.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_district_id": subDistrictId,
    "town_id": townId,
    "username": username,
    "fullname": fullname,
    "email": email,
    "mobile": mobile,
    "emergency_mobile": emergencyMobile,
    "dob": dob,
    "blood_group": bloodGroup,
    "gender": gender,
    "address": address,
    "profile_photo": profilePhoto,
    "is_verified": isVerified,
    "rejection_reason": rejectionReason,
    "bank_name": bankName,
    "branch_name": branchName,
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
    "aadhar_front": aadharFront,
    "aadhar_back": aadharBack,
    "pan_file": panFile,
    "assigned_villages": assignedVillages == null ? [] : List<dynamic>.from(assignedVillages!.map((x) => x.toJson())),
    "assigned_wards": assignedWards == null ? [] : List<dynamic>.from(assignedWards!.map((x) => x.toJson())),
  };
}

class Assigned {
  int? id;
  String? name;
  int? code;

  Assigned({
    this.id,
    this.name,
    this.code,
  });

  factory Assigned.fromJson(Map<String, dynamic> json) => Assigned(
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
