


import 'package:flutter/material.dart';


class Added extends StatefulWidget {
  @override
  _AddedState createState() => _AddedState();
}

class _AddedState extends State<Added> {
  @override
  Widget build(BuildContext context) {
    return Container(color:Colors.grey[300]
    ,height:70,width:70,
      margin: EdgeInsets.only(left: 10,top:10),
      child:Center(child: Icon(Icons.check,color: Colors.green,))
    );
  }
}
