import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:model_architecture/api/api_service.dart';
import 'package:model_architecture/constantPackage/constStrings.dart';
import 'package:model_architecture/model/file_placeholder.dart';
import 'package:model_architecture/model/uploadFileDetailsModel.dart';
import 'package:path/path.dart';

class Api{

/*  Dio dio=ApiService(baseOptions:  BaseOptions(
    baseUrl: "https://news.inrexa.com",
    connectTimeout: 10000,
    receiveTimeout: 10000,)).getclient();*/
  Dio dio= ApiService().getclient();
Future<Response>  requestSamplePost(String name,String email,String password,String authlvl) async{


  var formData= FormData.fromMap({
      "name": "wendux",
      "email":"asndk@gmail.com",
      "password":"asndk@gmail.com",
      "authlvl": 2,
       "authcode": authcode,

    });


   return dio.post("/signup.php",data:await formData);
  }

  Future<Response>  uploadGeneralPost(String title,String description,dynamic attachment,String authlvl) async {
    var encoded = utf8.encode(description);
    var decoded = utf8.decode(encoded);
    print(decoded);

   // var map={"postimage":"dasd","data":attachment};

    var formData= FormData.fromMap({
      "title": title,
      "description":description,
      "attachments": jsonEncode(attachment),
      "cdescription":utf8.encode(description).toString(),
      "ctitle": utf8.encode(title).toString(),
      "authcode": authcode,
    });



    return dio.post("/uploadgeneral.php",data:await formData);
  }




  Future<Response> searchPost(String sno) async {
    return dio.post("/search.php",);
  }

  Future<Response>  getGeneralPost(String sno) async {


    return dio.post("/generalpost.php");
  }


  Future<Response>  searchGeneralPost(
      {String searchwords,
      String fromdate,
      String todate,
      int department}) async {
    // var map={"postimage":"dasd","data":attachment};

    var formData= FormData.fromMap({
      "searchwords": searchwords,
      "fromdate":fromdate,
      "todate": todate,
      "department":department,
    });



    return dio.post("/search.php",data:await formData);
  }





}