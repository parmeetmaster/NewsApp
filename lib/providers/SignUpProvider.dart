

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/model/DepartmentItemModel.dart';
import 'package:model_architecture/model/LoginResponseModel.dart';

class SignUpProvider extends ChangeNotifier{

  List<String> departments = [];
  TextEditingController firstnamecontroller = new TextEditingController();
  TextEditingController lastnamecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController phonecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldkey_signup = new GlobalKey<ScaffoldState>();

  final GlobalKey<ScaffoldState> scaffoldkeySignup = GlobalKey<ScaffoldState>();
  String radioItem = "general";
  double percent = 0;
  Function sentMessage;
  Response response;
  String progress;
  List<String> attachmentUrls = [];
  String postUrl = "";
  int dept_list_no = 0;
  String activeDepartmentString=null;
  int real_department_no=0;


  bool performBasicValidation() {
    bool iserror = false;
    if (firstnamecontroller.text.isEmpty) {
      scaffoldkey_signup.currentState
          .showSnackBar(new SnackBar(content: Text("FirstName is Undefined")));
      iserror = true;
    }

    if (emailcontroller.text.isEmpty) {
      scaffoldkey_signup.currentState
          .showSnackBar(new SnackBar(content: Text("ई मेल  is Undefined")));
      iserror = true;
    }
    if (phonecontroller.text.isEmpty) {
      scaffoldkey_signup.currentState.showSnackBar(
          new SnackBar(content: Text("Phone Number is Undefined")));
      iserror = true;
    }
    if (passwordcontroller.text.isEmpty) {
      scaffoldkey_signup.currentState
          .showSnackBar(new SnackBar(content: Text("Password is Undefined")));
      iserror = true;
    }

    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailcontroller.text);

    if (emailValid == false) {
      scaffoldkey_signup.currentState
          .showSnackBar(new SnackBar(content: Text("ई मेल  Format Incorrect")));
      iserror = true;
    }
    return iserror;
  }

  void onChangeListItem(String value) {
    activeDepartmentString=value;
    dept_list_no = departments.indexOf(value);
    print(dept_list_no);
    print("value ${Globals.list_of_department[dept_list_no].sno}");
    real_department_no=int.parse(Globals.list_of_department[dept_list_no].sno);
    notifyListeners();
  }

  initDepartemetList(){
    if(departments.length>0){

      return;
    }

    for(DepartmentItemModel model in Globals.list_of_department){
      departments.add(model.departmentname);
    }
notifyListeners();
  }


  List<String>getListOfDepartments() {


    return departments;
  }

  onsubmit() async {
    if(performBasicValidation()){
      return;

    }

    try{
      Response response=await Api().signUp(name: firstnamecontroller.text,password: passwordcontroller.text
      ,email: (emailcontroller.text).toLowerCase(),phone: phonecontroller.text,deptno: real_department_no
      );
     if(response.data.toString().contains("successfully")){
   /*    Globals.loginResponseModel=new LoginResponseModel(name: firstnamecontroller.text,email:  emailcontroller.text
       ,password: passwordcontroller.text,authlvl: "2",departmentnumber: real_department_no.toString() );
       */

      sentMessage();
     }else if(response.statusCode==404)  {
       scaffoldkeySignup.currentState.showSnackBar(SnackBar(content: Text("User Already Exist"),));
     }

    }on DioError catch(e){
      scaffoldkeySignup.currentState.showSnackBar(SnackBar(content: Text("${e.response.data}"),));
    }

  }

  void successmessagefunction(Function mcontext) {
    this.sentMessage=mcontext;

  }


}