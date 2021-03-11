import 'package:flutter/material.dart';
import 'package:model_architecture/screens/Splash/splashscreen.dart';

class InternetNotFound extends StatelessWidget {
  static const classname='/InternetNotFound';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/internet.png'),
        SizedBox(height: 20,),
        Text("Internet not Found",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22),),
        RaisedButton(
          child: Text("होम "),
          onPressed: (){
          Navigator.popAndPushNamed(context, SplashScreen.classname);
        },)
      ],
    )),);
  }
}
