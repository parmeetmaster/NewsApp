

import 'package:flutter/material.dart';
import 'package:model_architecture/constantPackage/constColors.dart';

class CategoryButton extends StatelessWidget {

  Function onPress;
  String text="";
  CategoryButton({this.onPress,this.text});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed:onPress,
      color: projpink,
      child: Text(text),
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
    );
  }
}
