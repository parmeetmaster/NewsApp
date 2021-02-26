

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/model/post_from_server.dart';
import 'package:model_architecture/model/uploadFileDetailsModel.dart';
import 'package:model_architecture/screens/HomeScreenGeneral/Components/PostContainer.dart';



class Transport{


}


class HomeProvider extends ChangeNotifier{
List<Widget> postWidgets=[];
bool isloaded=false;

    Future<void>  loadData() async{
      if(isloaded==false) {
        isloaded=true;
    Response res=await Api().getGeneralPost("");
    List<dynamic> ls =jsonDecode(res.data);

         for  (var i=0;i<ls.length;i++){
      print(PostFromServer.fromJson(ls[i]).attachments);
      String attachmentString=PostFromServer.fromJson(ls[i]).attachments;


      UploadFileDetailModel attachmentmodel=parseString(attachmentString);
      postWidgets.add(PostContainer(model:PostFromServer.fromJson(ls[i]),attachmentmodel:attachmentmodel ,));

    }
    ////////////////////////////////////---notifylistener---////////////////////////////////////

   notifyListeners();

    }
  }

UploadFileDetailModel parseString(String attachmentString ){
      print(attachmentString);



      try{
        UploadFileDetailModel m=  UploadFileDetailModel.fromJson(jsonDecode(attachmentString));
        print("first is${m.attachments[0]}");
        return m;
      }catch(e){
        return null;

      }

}



}