


import 'package:flutter/material.dart';
import 'package:model_architecture/providers/PostCreateProvider.dart';
import 'package:provider/provider.dart';


class AddmoreDefault extends StatefulWidget {


  @override
  _AddmoreDefault createState() => _AddmoreDefault();
}

class _AddmoreDefault extends State<AddmoreDefault> {
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<PostCreateProvider>(context);
    return Container(color:Colors.grey[300]
    ,height:70,width:70,
      margin: EdgeInsets.only(top:10,left:10),
      child:Center(child: Icon(Icons.image,size:25))
    );
  }
}
