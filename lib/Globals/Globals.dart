import 'package:model_architecture/constantPackage/language/words.dart';
import 'package:model_architecture/model/DepartmentItemModel.dart';
import 'package:model_architecture/model/LoginResponseModel.dart';

import '../utils/languageDeligate.dart';

class Globals {
  static Words primaryLanguage;
  static const apikey = "";
  static String imageUrl = "";

  // preference keys constants
  static String SESSION_ID = "session_id";
  static String TOKEN = "token";
  static String USER = "user";
  static String VOUCHER_PREFIX = "dd_voucher_";
  static LoginResponseModel loginResponseModel;
  static List<DepartmentItemModel> list_of_department=[];
  DateTime loginClickTime;

  bool isRedundentClick(DateTime currentTime) {
    if (loginClickTime == null) {
      loginClickTime = currentTime;
      print("first click");
      return false;
    }
    print('diff is ${currentTime.difference(loginClickTime).inSeconds}');
    if (currentTime.difference(loginClickTime).inSeconds < 10) {
      //set this difference time in seconds
      return true;
    }

    loginClickTime = currentTime;
    return false;
  }
}

const String SIGNUP_TOKEN = "SIGNUP_TOKEN";
