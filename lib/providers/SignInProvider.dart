import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';

import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/constantPackage/constStrings.dart';
import 'package:model_architecture/model/LoginResponseModel.dart';
import 'package:model_architecture/utils/preference.dart';

class SignInProvider extends ChangeNotifier {
  TextEditingController emailcontroller;
  TextEditingController passwordcontroller;
  GlobalKey<ScaffoldState> scaffoldkeySignIn = new GlobalKey();

  bool performValidation() {
    return true;
  }

  onSubmit() async {
    if (performValidation() != true) {
      return;
    }

    try {
      Response resp =
          await Api().login(emailcontroller.text, passwordcontroller.text);
      List<LoginResponseModel> list = loginResponseModelFromJson(resp.data);
      Globals.loginResponseModel = list[0];
      Preference.setString(loginjson, resp.data);
      print("login response${resp.data}");
    } catch (e) {
      scaffoldkeySignIn.currentState
          .showSnackBar(SnackBar(content: Text("User not Found")));
    }
  }
}
