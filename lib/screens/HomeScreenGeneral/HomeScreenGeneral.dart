import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:model_architecture/Globals/Widgets/adminDrawer.dart';
import 'package:model_architecture/constantPackage/constStrings.dart';
import 'package:model_architecture/model/RefereshAlertModel.dart';

import 'package:model_architecture/providers/HomeProvider.dart';
import 'package:model_architecture/providers/SampleProvider.dart';

import 'package:model_architecture/screens/SearchScreen/SearchScreen.dart';
import 'package:model_architecture/screens/SearchScreen/SearchScreenDepartment.dart';
import 'file:///D:/Practice%20folder/News%20App/lib/Globals/Globals.dart';
import 'package:model_architecture/utils/languageDeligate.dart';
import 'package:model_architecture/utils/preference.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Components/CornerImages.dart';
import 'Components/PostContainer.dart';

class HomeScreenGeneral extends StatefulWidget {
  static const classname= "/HomeScreenGeneral";
  @override
  _HomeScreenGeneralState createState() => _HomeScreenGeneralState();
}

class _HomeScreenGeneralState extends State<HomeScreenGeneral> {

  initdataPreference()async{
    String str=  await Preference.getString(loginjson);

    if(str!=null){
      Provider.of<HomeProvider>(context,listen: false).loadDepartmentData();
    }else{
      Provider.of<HomeProvider>(context,listen: false).loadGeneralData();
    }


  }

  @override
  void initState() {
    initdataPreference();


  }
_askPermission() async{
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
    Permission.mediaLibrary,
    Permission.photos,
  ].request();
  }
  @override
  Widget build(BuildContext context) {
  String str=  Preference.getString(loginjson);
  print("data is here $str");
  final provider = Provider.of<HomeProvider>(context);

  final RefreshAlertModel args = ModalRoute.of(context).settings.arguments;
    provider.check_need_refresh(args);


    return Scaffold(

      drawer: provider.drawer,// drawer
        appBar: AppBar(
          actions: [
            InkWell(
              child: Icon(Icons.autorenew),
              onTap: () {
                Provider.of<HomeProvider>(context,listen: false).postWidgets=null;
                Provider.of<HomeProvider>(context,listen: false).notifyListeners();
                // todo check department referesh

           Provider.of<HomeProvider>(context,listen: false).refreshButtonAction();


              },
            ),
            SizedBox(width:24),
            InkWell(
              child: Icon(Icons.search),
              onTap: ()async {
               String str= await Preference.getString(loginjson);

               if(str!=null)
                Navigator.pushNamed(context, SearchScreenDepartment.classname);
                else
                 Navigator.pushNamed(context, SearchScreen.screenname);

               },
            ),
            SizedBox(
              width: 20,
            ),
          ],

          title: Row(
            children: [
              Container(
               child: CircleAvatar(
                radius: 12.0,
                backgroundImage:
                AssetImage("assets/logo.png"),
                backgroundColor: Colors.transparent,
              ),

              ),
              SizedBox(width: 10,),
              Text("संप्रक सेतु"),
            ],
          ),
        ),
        body:     Consumer<HomeProvider>(
            builder: (context, value, child) {
              if(value.postWidgets!=null)
              return SingleChildScrollView(
                  child: Column(
                    children: value.postWidgets,
                  ));
            else return Center(child: CircularProgressIndicator());
            })
    );
  }
}


