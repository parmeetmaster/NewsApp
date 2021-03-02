

import 'dart:io';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/model/DepartmentItemModel.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:model_architecture/model/postcarrier.dart';
import 'package:url_launcher/url_launcher.dart';

class PostProvider extends ChangeNotifier{

  PostCarrier args;
  List<Widget> list_of_attachment_widget;

generatePostList(PostCarrier args) {
    if(list_of_attachment_widget!=null){
      return;
    }

    list_of_attachment_widget=[];
    if(args.attachmentmodel.attachments==null){
      notifyListeners();
      return;
    }

    for(String string in args.attachmentmodel.attachments){
      File file = new File(string);

  String    basename= path.basename(file.path);
      list_of_attachment_widget.add(Card(
        child: InkWell( onTap:(){
          _launchURL(string);

        },child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(child: Text(basename,style: TextStyle(color: Colors.lightBlue),),))),
      ));


    }

    notifyListeners();

}

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  DepartmentItemModel active_deptmodel;
  void getPostDepartementName() {

    for(DepartmentItemModel deptmodel in   Globals.list_of_department){
        if(deptmodel.sno==args.model.department){
          print(deptmodel.departmentname);
          active_deptmodel=deptmodel;
          break;
        }else if(args.model.department=="0"){
          try {
            if(Globals.loginResponseModel!=null) {
              active_deptmodel = new DepartmentItemModel(departmentname: "Administrative");
            }else{
              active_deptmodel =   new DepartmentItemModel(departmentname: "General");
            }
          }catch(e){
            active_deptmodel =   new DepartmentItemModel(departmentname: "General");
          }

        break;
        }

      }


  }

  void setArgs(PostCarrier margs) {
  args=margs;
  }


}