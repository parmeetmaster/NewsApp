


import 'package:flutter/material.dart';
import 'package:model_architecture/providers/PostCreateProvider.dart';
import 'package:provider/provider.dart';


class Addmore extends StatefulWidget {


  @override
  _AddmoreState createState() => _AddmoreState();
}

class _AddmoreState extends State<Addmore> {
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<PostCreateProvider>(context);
    return InkWell(
      onTap: (){
        provider.pickupFile(uploadfiletype.attachment);

      },
      child: Container(color:Colors.grey[300]
      ,height:70,width:70,
        margin: EdgeInsets.only(top:10,left:10),
        child:Center(child: Text("+"))
      ),
    );
  }
}
