import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/screens/SuccessScreen/SuccessScreen.dart';

class DepartmentCreateProvider extends ChangeNotifier {
  TextEditingController deparmentName=new TextEditingController();
BuildContext context;

submitDepartment() async {
    if(isRedundentClick(DateTime.now())){
      print('hold on, processing');
      return;
    }


    Response response = await Api().addnewDepartment(deparmentName.text);
    print(response.data);

    Navigator.pushNamed(context,SuccessScreen.classname);

  }


  setContext(BuildContext mcontext){
    this.context= mcontext;
  }

  DateTime loginClickTime;

  bool isRedundentClick(DateTime currentTime){
    if(loginClickTime==null){
      loginClickTime = currentTime;
      print("first click");
      return false;
    }
    print('diff is ${currentTime.difference(loginClickTime).inSeconds}');
    if(currentTime.difference(loginClickTime).inSeconds<10){//set this difference time in seconds
      return true;
    }

    loginClickTime = currentTime;
    return false;
  }





}
