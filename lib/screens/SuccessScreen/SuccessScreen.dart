

import 'package:flutter/material.dart';

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
          Text("Successful",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800),)
        ],

      ),),),
    );
  }
}
