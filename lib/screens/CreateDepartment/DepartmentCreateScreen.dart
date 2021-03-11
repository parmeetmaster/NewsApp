import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:model_architecture/Globals/Widgets/adminDrawer.dart';
import 'package:model_architecture/providers/DepartmentCreateProvider.dart';

import 'package:model_architecture/providers/PostProvider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class DeparmentCreateScreen extends StatelessWidget {
  static const classname = "/DeparmentCreateScreen";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DepartmentCreateProvider>(context);
    provider.setContext(context);

    return Consumer<DepartmentCreateProvider>(builder: (context, value, child) {
      return Scaffold(
          drawer: AdminDrawer(),
          appBar: AppBar(
            title: Text("नया विभाग बनाएँ"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "कृपया विभाग का विवरण दें",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      )),
                  TextField(
                      controller: value.deparmentName,
                      decoration: InputDecoration(
                          labelText: 'कृपया विभाग का नाम दर्ज करें')),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.88,
                    child: RaisedButton(
                      child: Text(
                        "जामा करे",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: value.submitDepartment,
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
