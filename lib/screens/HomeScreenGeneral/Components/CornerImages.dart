
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/constantPackage/constColors.dart';
import 'package:model_architecture/model/DetailScreenModel.dart';

import 'package:model_architecture/utils/uuidUtils.dart';

class RoundedCornerImages extends StatelessWidget {


  String title,imageurl,price;

  RoundedCornerImages({ this.imageurl}){

    imageurl??="";

  }

  @override
  Widget build(BuildContext context) {
    DetailScreenModel model=new DetailScreenModel(imgUrl: imageurl,tag: UUIdUtils().getInstance().getV4Uuid());

    return  Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
                 borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network(model.imgUrl,
               fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
