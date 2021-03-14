

import 'package:flutter/material.dart';
import 'package:model_architecture/constantPackage/constStrings.dart';
import 'package:model_architecture/screens/HomeScreenGeneral/HomeScreenGeneral.dart';

class SuccessScreen extends StatefulWidget {
  static const classname="/SuccessScreen";
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
     body: Container(child: Center(child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height:180,width: 180,
              child: Image.asset('assets/check.png')),
          Text("${sucessultxt}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800),),
          SizedBox(height: 10,),
              RaisedButton(
           child: Text("होम पेज पर वापस जाएं"),
           onPressed: (){
             Navigator.pushNamedAndRemoveUntil(context,HomeScreenGeneral.classname, (route) => false);

           })


        ],

      ),),),
    );
  }
}
