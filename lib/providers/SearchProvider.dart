import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/model/DepartmentItemModel.dart';
import 'package:model_architecture/model/post_from_server.dart';
import 'package:model_architecture/model/uploadFileDetailsModel.dart';
import 'package:model_architecture/screens/HomeScreenGeneral/Components/PostContainer.dart';


class SearchScreenProvider extends ChangeNotifier {

   bool searchExpanded = true;
   List<String> listDepartments = [];
   String fromDate=null;
   String toDate=null;
   TextEditingController searchinputController=new TextEditingController();
   String department="Set Department";
   String office="Set Office";
    List<Widget> postWidgets=[];
   BuildContext context;
   List<String> departments = [];

  setExpansion(bool val) {
    searchExpanded = val;
    notifyListeners();
  }

  setDepartemnt(String val) {
    department=val;
   notifyListeners();
  }

  set(String val) {
    print(val);
  }


   initDepartemetList(){
     if(departments.length>0){
       return;
     }
     for(DepartmentItemModel model in Globals.list_of_department){
       departments.add(model.departmentname);
     }

   }




   List<String>getListOfDepartments() {
    return ["Bollywood","Hollywood","Usa"];
  }

  List<String>getListOfOffice() {
    return ["Office A","Office B","Office C"];
  }

  setFromDate(String val){
     fromDate=val;
     print(val);
  notifyListeners();

  }

  setToDate(String val){
    toDate=val;
    print(val);
    notifyListeners();
  }

  setDepartment(String val){
    department=val;
    notifyListeners();

  }
  setOffice(String val){
    office=val;
    notifyListeners();
  }

    onSubmit(){
    searchData();

  }

  Future<void>  searchData() async{
    showScaffold("Loading");

    postWidgets=[];
  String searchtext=  searchinputController.text;

    searchtext.replaceAll(" ","|");
    fromDate??="2000-02-21";
    toDate??="2050-02-21";

    DateTime dateTimeFrom = DateTime.parse(fromDate);
    DateTime dateTimeTo = DateTime.parse(toDate);
    final differenceInDays = dateTimeTo.difference(dateTimeFrom).inDays;
    print('difference in date is $differenceInDays');



      Response res=await Api().searchGeneralPost(fromdate:"${fromDate} 00:00:00.000000",todate: "${toDate} 23:59:59.000000",department: 0,searchwords: searchtext,);
  //  print(res.data.toString());
      List<dynamic> ls =jsonDecode(res.data);

    //  print("----------show search query------------");

  //  print(fromDate+ "<--->"+toDate );
    //  print(res.data.toString());

      for  (var i=0;i<ls.length;i++){
        print(PostFromServer.fromJson(ls[i]).attachments);
        String attachmentString=PostFromServer.fromJson(ls[i]).attachments;
        UploadFileDetailModel attachmentmodel=parseString(attachmentString);
        postWidgets.add(PostContainer(model:PostFromServer.fromJson(ls[i]),attachmentmodel:attachmentmodel ,));
//print("search data is here ${attachmentmodel.post}");
      }
      ////////////////////////////////////---notifylistener---////////////////////////////////////
      notifyListeners();
  }

   UploadFileDetailModel parseString(String attachmentString ){
     try{
       UploadFileDetailModel m=  UploadFileDetailModel.fromJson(jsonDecode(attachmentString));
       print("first is${m.attachments[0]}");
       return m;
     }catch(e){
       return null;

     }

   }

void setContext(BuildContext mcontext){
    context=mcontext;
}

void showScaffold(String msg){

    Fluttertoast.showToast(msg: msg);

}



}