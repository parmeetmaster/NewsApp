// To parse this JSON data, do
//
//     final departmentItemModel = departmentItemModelFromJson(jsonString);

import 'dart:convert';

List<DepartmentItemModel> departmentItemModelFromJson(String str) => List<DepartmentItemModel>.from(json.decode(str).map((x) => DepartmentItemModel.fromJson(x)));

String departmentItemModelToJson(List<DepartmentItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentItemModel {
  DepartmentItemModel({
    this.sno,
    this.departmentname,
  });

  String sno;
  String departmentname;

  factory DepartmentItemModel.fromJson(Map<String, dynamic> json) => DepartmentItemModel(
    sno: json["sno"],
    departmentname: json["departmentname"],
  );

  Map<String, dynamic> toJson() => {
    "sno": sno,
    "departmentname": departmentname,
  };
}
