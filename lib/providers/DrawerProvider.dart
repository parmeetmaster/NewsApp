

import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/constantPackage/constStrings.dart';
import 'package:model_architecture/model/RefereshAlertModel.dart';
import 'package:model_architecture/screens/HomeScreenGeneral/HomeScreenGeneral.dart';
import 'package:model_architecture/utils/preference.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerProvider extends ChangeNotifier{

  BuildContext context;

performLogOut()async{
  Globals.loginResponseModel=null;
  Preference.setString(loginjson, null);
  Navigator.pushNamedAndRemoveUntil(context, HomeScreenGeneral.classname, (route) => false,arguments: new RefreshAlertModel(login_perform_refresh_alert:false,log_out_perform_refresh_alert: true));


}



  void createPost() {

    _launchURL();
  }
  _launchURL() async {
  String url=baseurl+"/outside/form.php?email="+Globals.loginResponseModel.email+"&password="+Globals.loginResponseModel.password;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}