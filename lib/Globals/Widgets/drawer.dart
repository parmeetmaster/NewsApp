

import 'package:flutter/material.dart';
import 'package:model_architecture/screens/CreateDepartment/DepartmentCreateScreen.dart';

class GlobalDrawer extends StatefulWidget {
  @override
  _GlobalDrawerState createState() => _GlobalDrawerState();
}

class _GlobalDrawerState extends State<GlobalDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Abhishek Mishra"),
            accountEmail: Text("abhishekm977@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home), title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.note_add), title: Text("Create New Post"),
            onTap: () {
             Navigator.pushNamed(context, '/PostCreateScreen');
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt_1), title: Text("Add New User"),
            onTap: () {
              Navigator.pushNamed(context, '/SignUpScreen');
            },
          ),

          ListTile(
            leading: Icon(Icons.fact_check), title: Text("Create Department"),
            onTap: () {
              Navigator.pushNamed(context, DeparmentCreateScreen.classname);
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
    )
    ;
  }
}
