

import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/providers/DrawerProvider.dart';
import 'package:model_architecture/screens/CreateDepartment/DepartmentCreateScreen.dart';
import 'package:provider/provider.dart';

class EmployeeDrawer extends StatefulWidget {
  @override
  _EmployeeDrawerState createState() => _EmployeeDrawerState();
}

class _EmployeeDrawerState extends State<EmployeeDrawer> {
  @override
  Widget build(BuildContext context) {
   final provider= Provider.of<DrawerProvider>(context);
   provider.context=context;
   return Consumer<DrawerProvider>(

     builder: (context, value,child) {
       return Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(Globals.loginResponseModel.name),
                accountEmail: Text(Globals.loginResponseModel.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    "E",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.note_add), title: Text("नई सूचना जोड़े "),
                onTap: value.createPost,
              ),


              ListTile(
                leading: Icon(Icons.person), title: Text("लॉग आउट"),
                onTap: () {
                  FutureBuilder(future: value.performLogOut(),);
                },
              ),

            ],
          ),
        );
     }
   )
    ;
  }
}
