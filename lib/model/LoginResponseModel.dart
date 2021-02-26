// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

List<LoginResponseModel> loginResponseModelFromJson(String str) => List<LoginResponseModel>.from(json.decode(str).map((x) => LoginResponseModel.fromJson(x)));

String loginResponseModelToJson(List<LoginResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginResponseModel {
  LoginResponseModel({
    this.sno,
    this.name,
    this.email,
    this.password,
    this.authlvl,
    this.departmentnumber,
  });

  String sno;
  String name;
  String email;
  String password;
  String authlvl;
  String departmentnumber;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    sno: json["sno"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    authlvl: json["authlvl"],
    departmentnumber: json["departmentnumber"],
  );

  Map<String, dynamic> toJson() => {
    "sno": sno,
    "name": name,
    "email": email,
    "password": password,
    "authlvl": authlvl,
    "departmentnumber": departmentnumber,
  };
}
