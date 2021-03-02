import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/Globals/Widgets/commonDrawer.dart';
import 'package:model_architecture/Globals/Widgets/adminDrawer.dart';
import 'package:model_architecture/Globals/Widgets/employeeDrawer.dart';
import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/constantPackage/constStrings.dart';
import 'package:model_architecture/model/RefereshAlertModel.dart';
import 'package:model_architecture/model/post_from_server.dart';
import 'package:model_architecture/model/uploadFileDetailsModel.dart';
import 'package:model_architecture/screens/HomeScreenGeneral/Components/PostContainer.dart';
import 'package:model_architecture/utils/preference.dart';

class HomeProvider extends ChangeNotifier {
  List<Widget> postWidgets;
  Widget drawer = CommonDrawer();

  Future<void> loadGeneralData() async {
    String login_flag = await (Preference.getString(loginjson));
    if (login_flag == null) {
      drawer = CommonDrawer();
    }

    if (postWidgets != null) {
      return;
    }
    Response res = await Api().getGeneralPost("");
    List<dynamic> ls = jsonDecode(res.data);
    postWidgets = [];
    for (var i = 0; i < ls.length; i++) {
      print(PostFromServer.fromJson(ls[i]).attachments);
      String attachmentString = PostFromServer.fromJson(ls[i]).attachments;

      UploadFileDetailModel attachmentmodel = parseString(attachmentString);
      postWidgets.add(PostContainer(
        model: PostFromServer.fromJson(ls[i]),
        attachmentmodel: attachmentmodel,
      ));
    }
    ////////////////////////////////////---notifylistener---////////////////////////////////////

    notifyListeners();
  }

  Future<void> loadDepartmentData() async {
    String login_flag = await (Preference.getString(loginjson));
    if (login_flag != null) {
      if (Globals.loginResponseModel.authlvl == "1") {
        drawer = AdminDrawer();
      } else {
        drawer = EmployeeDrawer();
      }
    }

    if (postWidgets != null) {
      return;
    }
    Response res = await Api().getDepartmentPost("");
    List<dynamic> ls = jsonDecode(res.data);
    postWidgets = [];
    for (var i = 0; i < ls.length; i++) {
      print(PostFromServer.fromJson(ls[i]).attachments);
      String attachmentString = PostFromServer.fromJson(ls[i]).attachments;

      UploadFileDetailModel attachmentmodel = parseString(attachmentString);
      postWidgets.add(PostContainer(
        model: PostFromServer.fromJson(ls[i]),
        attachmentmodel: attachmentmodel,
      ));
    }
    ////////////////////////////////////---notifylistener---////////////////////////////////////

    notifyListeners();
  }

  UploadFileDetailModel parseString(String attachmentString) {
    print(attachmentString);

    try {
      UploadFileDetailModel m =
          UploadFileDetailModel.fromJson(jsonDecode(attachmentString));
      print("first is${m.attachments[0]}");
      return m;
    } catch (e) {
      return null;
    }
  }

  bool refreshdone = false;

  void check_need_refresh(RefreshAlertModel args) async {
    if (args != null) if (args.login_perform_refresh_alert == true) {
      postWidgets = null;
      await loadDepartmentData();
      notifyListeners();
      args.login_perform_refresh_alert = false;
      args = null;
    } else if (args.log_out_perform_refresh_alert == true) {
      postWidgets = null;
      await loadGeneralData();
      notifyListeners();
      args.log_out_perform_refresh_alert = false;
      args = null;
    }
  }

   refreshButtonAction() async {
    String chklogin = await Preference.getString(loginjson);
    if (chklogin != null){
      loadDepartmentData();
    }else{
      loadGeneralData();
    }
    notifyListeners();
  }
}
