

import 'package:flutter/material.dart';
import 'package:model_architecture/providers/DrawerProvider.dart';
import 'package:model_architecture/screens/CreateDepartment/DepartmentCreateScreen.dart';
import 'package:model_architecture/screens/HomeScreenGeneral/HomeScreenGeneral.dart';
import 'package:provider/provider.dart';

class CommonDrawer extends StatefulWidget {
  @override
  _CommonDrawerState createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerProvider>(

      builder: (context,value,child) {
        return Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("User not Log In"),
                accountEmail: Text("Email is Undefined"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    "U",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home), title: Text("Home"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context,HomeScreenGeneral.classname, (route) => false);
                },
              ),

              ListTile(
                leading: Icon(Icons.person), title: Text("Login"),
                onTap: () {
                  Navigator.pushNamed(context, '/SignInPage');
                },
              ),

              ListTile(
                leading: Icon(Icons.contacts), title: Text("Contact Us"),
                onTap: () {
                  Navigator.pop(context);
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
