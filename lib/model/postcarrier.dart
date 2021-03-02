


import 'package:model_architecture/model/post_from_server.dart';
import 'package:model_architecture/model/uploadFileDetailsModel.dart';

class PostCarrier{
  PostFromServer model;
  UploadFileDetailModel attachmentmodel;

  PostCarrier({this.model, this.attachmentmodel});

  void generatePostList(PostCarrier args) {}
}