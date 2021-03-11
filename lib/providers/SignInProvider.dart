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
  GlobalKey<ScaffoldState> scaffoldkeySignIn = new GlobalKey<ScaffoldState>();

  BuildContext context;


  bool performBasicValidation() {
    bool iserror = false;


    if (emailcontroller.text.isEmpty) {
      scaffoldkeySignIn.currentState
          .showSnackBar(new SnackBar(content: Text("Email is Undefined")));
      iserror = true;
    }

    if (passwordcontroller.text.isEmpty) {
      scaffoldkeySignIn.currentState
          .showSnackBar(new SnackBar(content: Text("Password is Undefined")));
      iserror = true;
    }

    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailcontroller.text);

    if (emailValid == false) {
      scaffoldkeySignIn.currentState
          .showSnackBar(new SnackBar(content: Text("Email Format Incorrect")));
      iserror = true;
    }
    return iserror;
  }

  performLogin() async {
    bool signresult= await performBasicValidation();
    if ( signresult != false) {return;}

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
        future: performLogin(),
    builder: (context, snapshot){
    print('In Builder');
    });


  }
}
