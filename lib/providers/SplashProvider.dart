

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/model/DepartmentItemModel.dart';

class SplashProvider extends ChangeNotifier{

  loadDepartements() async {
    Response resp=await Api().getDepartmentApi();
    Globals.list_of_department=departmentItemModelFromJson(resp.data);
print( Globals.list_of_department[0].departmentname);
  }

}