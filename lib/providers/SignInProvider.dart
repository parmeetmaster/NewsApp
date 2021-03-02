import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';

import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/constantPackage/constStrings.dart';
import 'package:model_architecture/model/LoginResponseModel.dart';
import 'package:model_architecture/model/RefereshAlertModel.dart';
import 'package:model_architecture/screens/HomeScreenGeneral/HomeScreenGeneral.dart';
import 'package:model_architecture/utils/preference.dart';
import 'package:path/path.dart';

class SignInProvider extends ChangeNotifier {
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController passwordcontroller=new TextEditingController();
  GlobalKey<ScaffoldState> scaffoldkeySignIn = new GlobalKey();

  BuildContext context;

  bool performValidation() {
    return true;
  }

  performwork() async {
    if (performValidation() != true) {
      return;
    }

    try {
      Response resp = await Api().login((emailcontroller.text).toLowerCase(), passwordcontroller.text);
      List<LoginResponseModel> list = loginResponseModelFromJson(resp.data);

      Globals.loginResponseModel = list[0];
      Preference.setString(loginjson, jsonEncode(Globals.loginResponseModel.toJson()));
      print("login response${resp.data}");
      scaffoldkeySignIn.currentState
          .showSnackBar(SnackBar(content: Text("Login Successfull")));
      Navigator.pushNamedAndRemoveUntil(context, HomeScreenGeneral.classname, (route) => false,arguments: new RefreshAlertModel(login_perform_refresh_alert: true));
    } catch (e) {
      scaffoldkeySignIn.currentState
          .showSnackBar(SnackBar(content: Text("User not Found")));
    }
  }

  void setBuildContext(BuildContext context) {}

   performSignIn() {
    FutureBuilder<void>(
        future: performwork(),
    builder: (context, snapshot){
    print('In Builder');
    });


  }
}
