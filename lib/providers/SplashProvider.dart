import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/constantPackage/constStrings.dart';
import 'package:model_architecture/model/DepartmentItemModel.dart';
import 'package:model_architecture/model/LoginResponseModel.dart';
import 'package:model_architecture/utils/preference.dart';
import 'dart:io';

class SplashProvider extends ChangeNotifier {

  bool load_once=false;
  bool isinternetworking=true;
  loadDepartements() async {
    try{
      Response resp = await Api().getDepartmentApi();
      Globals.list_of_department = departmentItemModelFromJson(resp.data);
      print(Globals.list_of_department[0].departmentname);

    }catch(e){


    }

  }

  void loadCredentials() async {
    try {
      var userString = await Preference.getString(loginjson);
      if (userString != null) {
        Globals.loginResponseModel =
            LoginResponseModel.fromJson(jsonDecode(userString));
        print("splash Response ${Globals.loginResponseModel.email}");
      }
    } catch (e) {}
  }

  Future<void> checkInternetConnection() async {

    try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    print('connected');
    }
    } on SocketException catch (_) {
      isinternetworking=false;
    print('not connected');

    }

  }


}
