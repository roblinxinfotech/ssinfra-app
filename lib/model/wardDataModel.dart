// To parse this JSON data, do
//
//     final wardListModel = wardListModelFromJson(jsonString);

import 'dart:convert';

WardListModel wardListModelFromJson(String str) => WardListModel.fromJson(json.decode(str));

String wardListModelToJson(WardListModel data) => json.encode(data.toJson());

class WardListModel {
  int? status;
  String? message;
  List<WardList>? data;

  WardListModel({
    this.status,
    this.message,
    this.data,
  });

  factory WardListModel.fromJson(Map<String, dynamic> json) => WardListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<WardList>.from(json["data"]!.map((x) => WardList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WardList {
  int? id;
  String? name;
  int? code;
  bool? assign;

  WardList({
    this.id,
    this.name,
    this.code,
    this.assign,
  });

  factory WardList.fromJson(Map<String, dynamic> json) => WardList(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    assign: json["is_assigned"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
  };
}
