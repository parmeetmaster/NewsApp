import 'package:flutter/material.dart';
import 'package:model_architecture/model/post_from_server.dart';
import 'package:model_architecture/model/postcarrier.dart';
import 'package:model_architecture/model/uploadFileDetailsModel.dart';
import 'package:model_architecture/utils/Utf8convertUtils.dart';

import 'CornerImages.dart';

class PostContainer extends StatelessWidget {


  PostFromServer model;
  UploadFileDetailModel attachmentmodel;
  PostContainer({this.model,this.attachmentmodel});

  @override
  Widget build(BuildContext context) {
    attachmentmodel??=UploadFileDetailModel(post:"https://bitsofco.de/content/images/2018/12/broken-1.png");

    UtfConvertUtils c=new UtfConvertUtils();

   return Padding (
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context, '/post',arguments:new PostCarrier(model:model,attachmentmodel:attachmentmodel) ),
        child: Container(
          margin: EdgeInsets.only(top:10),
            width:MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
            color: Colors.grey[500],),),
            child:Column(
              children: [
                Padding(padding: EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("${c.convert(model.cypherTitle)}",style:TextStyle(fontWeight:FontWeight.w600,fontSize: 22),maxLines: 2, overflow: TextOverflow.ellipsis,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(c.convert(model.cypherDescription),
                  maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                RoundedCornerImages(imageurl: attachmentmodel.post,),
              ],
            )
        ),
      ),
    )
    ;
  }
}
