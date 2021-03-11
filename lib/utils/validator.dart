class Validator {
  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "नाम आवश्यक है";
    } else if (!regExp.hasMatch(value)) {
      return "नाम एक z-z और A-Z होना चाहिए";
    }
    return null;
  }

  String validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "मोबाइल नंबर आवश्यक है";
    } else if (value.length != 10) {
      return "मोबाइल नंबर 10 अंकों का होना चाहिए";
    } else if (!regExp.hasMatch(value)) {
      return "मोबाइल नंबर अंकों का होना चाहिए";
    }
    return null;
  }

  String validatePasswordLength(String value){
    if(value.length==0){
      return "Password can't be empty";
    } else if (value.length < 10){
      return "Password must be longer than 10 characters";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "ई मेल  आवश्यक है";
    } else if (!regExp.hasMatch(value)) {
      return "अमान्य ईमेल";
    } else {
      return null;
    }
  }
}
