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


class SearchScreenProviderDepartment extends ChangeNotifier {

   bool searchExpanded = true;
   List<String> listDepartments = [];
   String fromDate=null;
   String toDate=null;
   TextEditingController searchinputController=new TextEditingController();
   String departmentDropDownName="Set Department";
   String office="Set Office";
    List<Widget> postWidgets=[];
   BuildContext context;
   List<String> departments = [];
   String activeDepartmentSerialNumber="0";
   List<DepartmentItemModel> temlist=[];


   int department_no = 0;
  setExpansion(bool val) {
    searchExpanded = val;
    notifyListeners();
  }

  setDepartemnt(String value) {
departmentDropDownName=value;
    department_no = departments.indexOf(value);
    print(department_no);
    print("value ${temlist[department_no].sno}");
activeDepartmentSerialNumber=temlist[department_no].sno;
    notifyListeners();

  }

  set(String val) {
    print(val);
  }


   initDepartemetList(){

     temlist.addAll(Globals.list_of_department);

     temlist.add(new DepartmentItemModel(sno: "0",departmentname: "Unknown"));

     if(departments.length>0){
       return;
     }
     for(DepartmentItemModel model in temlist){
       departments.add(model.departmentname);
     }

   }




   List<String>getListOfDepartments() {
    return departments;
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
      Response res=await Api().searchDepartmentPost(fromdate:"${fromDate} 00:00:00.000000",todate: "${toDate} 23:59:59.000000",department: activeDepartmentSerialNumber,searchwords: searchtext,);
      List<dynamic> ls =jsonDecode(res.data);

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