import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/model/postcarrier.dart';
import 'package:model_architecture/providers/PostProvider.dart';
import 'package:model_architecture/utils/Utf8convertUtils.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    String convertDateTimeDisplay(String date) {
      final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
      final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
      final DateTime displayDate = displayFormater.parse(date);
      final String formatted = serverFormater.format(displayDate);
      return formatted;
    }

    final PostCarrier args = ModalRoute.of(context).settings.arguments;
    final provider = Provider.of<PostProvider>(context);
    provider.setArgs(args);
    provider.generatePostList(args);
    provider.getPostDepartementName();

    _getDepartmentNameAsPerLoginStatus(String str) {
      if(Globals.loginResponseModel != null){

      }


    }

    return Scaffold(
        appBar: AppBar(),
        body: Consumer<PostProvider>(builder: (context, value, child) {
          if (value.list_of_attachment_widget != null) {
            print("post json is${args.model.department}");
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          child: Image.network(
                            args.attachmentmodel.post,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text("${args.model.title}",
                          style: TextStyle(color: Colors.black, fontSize: 30)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Text("${value.active_deptmodel.departmentname}",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 17)),
                          Spacer(),
                          Text(
                              "Date : ${convertDateTimeDisplay(args.model.date)} ",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 17)),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text("${args.model.description} ",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Text("-- Author is : ${args.model.cypherTitle}",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 17)),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text("File Available for download :-",
                              style: TextStyle(
                                  color: Colors.green[500], fontSize: 17)),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: value.list_of_attachment_widget,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }));
  }

  @override
  void initState() {
    Provider.of<PostProvider>(context, listen: false)
        .list_of_attachment_widget = null;
  }
}
