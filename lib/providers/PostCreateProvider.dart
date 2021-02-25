import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/api/api_service.dart';
import 'package:model_architecture/constantPackage/constStrings.dart';
import 'package:model_architecture/model/file_placeholder.dart';
import 'package:model_architecture/model/uploadFileDetailsModel.dart';
import 'package:model_architecture/screens/PostCreateScreen/Components/AddMore.dart';
import 'package:model_architecture/screens/PostCreateScreen/Components/Added.dart';
import 'package:path/path.dart';

enum uploadfiletype { postimg, attachment }

class PostCreateProvider extends ChangeNotifier {
  TextEditingController title_controller = new TextEditingController();
  TextEditingController description_controller = new TextEditingController();

  String radioItem = "general";
  double percent = 0;

  File selectedfile;
  Response response;
  String progress;
  List<Widget> filesWidgets = [Addmore()];
  List<String> attachmentUrls = [];
  String postUrl = "";
  List<String> departments = ['One', 'Two', 'Three', 'Four'];
  int department_no = 0;

     String activeDepartment=null;

  void pickupFile(var type) async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedfile = await File(result.files.single.path);
      await uploadFile(type);
    } else {
      // User canceled the picker
    }
  }

  Dio dio = ApiService().getclient();

  uploadFile(var type) async {
    String uploadurl;
    if (radioItem == "general") {
      uploadurl = "/fileup.php?location=general&data=dsad";
    } else if (radioItem == "department") {
      uploadurl = "/fileup.php?location=department&data=dsad";
    } else {
      uploadurl = "/fileup.php?location=other&data=dsad";
    }

    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(selectedfile.path,
          filename: basename(selectedfile.path)
          //show only filename from path
          ),
    });

    response = await dio.post(
      uploadurl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        percent = (sent / total * 100) / 100;
        print(percentage);
        double percentdouble = double.parse(percentage);

        notifyListeners();
      },
    );

    if (response.statusCode == 200) {
      FilePlaceholder obj = new FilePlaceholder.fromJson(response.data);
      if (type == uploadfiletype.attachment) {
        attachmentUrls.add(baseurl + "/" + obj.link);
        filesWidgets.insert(0, Added());
      } else {
        postUrl = baseurl + "/" + obj.link;
      }

      print(obj.link);
      Fluttertoast.showToast(
          msg: "Upload Completed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);

      notifyListeners();
      //print response from server
    } else {
      print("Error during connection to server.");
    }
  }

  resetvariables() {
    postUrl = "";
    filesWidgets = [Addmore()];
    attachmentUrls = [];
    notifyListeners();
  }

  uploadPost() async {
    Response resp;

    if (radioItem == "general") {
       resp = await Api().uploadGeneralPost(
          title_controller.text,
          description_controller.text,
          UploadFileDetailModel(post: postUrl, attachments: attachmentUrls)
              .toJson(),
          "2");
      if (resp.statusCode == 200) {
        resetvariables();
      }
    }else if(radioItem=="department"){
       resp = await Api().uploadGeneralPost(
          title_controller.text,
          description_controller.text,
          UploadFileDetailModel(post: postUrl, attachments: attachmentUrls)
              .toJson(),
          "2");
       // handle response code
      if (resp.statusCode == 200) {
        resetvariables();
        //todo move to on sucess page
      }

    }
  }

  setDepartment(String val) {
    radioItem = val;
    notifyListeners();
  }

  void onChangeListItem(String value) {
    activeDepartment=value;
    department_no = departments.indexOf(value) + 1;
    print("value");
  }



  List<String>getListOfDepartments() {
    return departments;
  }


}
