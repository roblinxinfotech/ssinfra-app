// To parse this JSON data, do
//
//     final formsListModel = formsListModelFromJson(jsonString);

import 'dart:convert';

FormsListModel formsListModelFromJson(String str) => FormsListModel.fromJson(json.decode(str));

String formsListModelToJson(FormsListModel data) => json.encode(data.toJson());

class FormsListModel {
  int? status;
  String? message;
  Data? data;

  FormsListModel({
    this.status,
    this.message,
    this.data,
  });

  factory FormsListModel.fromJson(Map<String, dynamic> json) => FormsListModel(
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
  String? name;
  String? yojnaName;
  List<Form>? forms;

  Data({
    this.name,
    this.yojnaName,
    this.forms,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    yojnaName: json["yojna_name"],
    forms: json["forms"] == null ? [] : List<Form>.from(json["forms"]!.map((x) => Form.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "yojna_name": yojnaName,
    "forms": forms == null ? [] : List<dynamic>.from(forms!.map((x) => x.toJson())),
  };
}

class Form {
  int? id;
  String? code;
  String? title;

  Form({
    this.id,
    this.code,
    this.title,
  });

  factory Form.fromJson(Map<String, dynamic> json) => Form(
    id: json["id"],
    code: json["code"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "title": title,
  };
}
