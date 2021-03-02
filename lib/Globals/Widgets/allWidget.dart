import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Widgets/responsive_ui.dart';


class CustomAnyWidget extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;
  Widget child;


  CustomAnyWidget(
    {this.hint,
      this.textEditingController,
      this.keyboardType,
      this.icon,
      this.obscureText= false,
      this.child
     });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large? 12 : (medium? 10 : 8),
      child: child,
    );
  }
}
