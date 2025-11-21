// To parse this JSON data, do
//
//     final teamMemberCreationModel = teamMemberCreationModelFromJson(jsonString);

import 'dart:convert';

TeamMemberCreationModel teamMemberCreationModelFromJson(String str) => TeamMemberCreationModel.fromJson(json.decode(str));

String teamMemberCreationModelToJson(TeamMemberCreationModel data) => json.encode(data.toJson());

class TeamMemberCreationModel {
  int? status;
  String? message;
  Errors? errors;
  List<dynamic>? data;

  TeamMemberCreationModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  factory TeamMemberCreationModel.fromJson(Map<String, dynamic> json) => TeamMemberCreationModel(
    status: json["status"],
    message: json["message"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "errors": errors?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}

class Errors {
  List<String>? username;
  List<String>? email;

  Errors({
    this.username,
    this.email,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    username: json["username"] == null ? [] : List<String>.from(json["username"]!.map((x) => x)),
    email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "username": username == null ? [] : List<dynamic>.from(username!.map((x) => x)),
    "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
  };
}
