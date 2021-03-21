

import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/providers/DrawerProvider.dart';
import 'package:model_architecture/screens/CreateDepartment/DepartmentCreateScreen.dart';
import 'package:model_architecture/screens/HomeScreenGeneral/HomeScreenGeneral.dart';
import 'package:provider/provider.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {

    Provider.of<DrawerProvider>(context).context=context;

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
                    "A",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home), title: Text("होम "),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context,HomeScreenGeneral.classname, (route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.note_add), title: Text("नई सूचना जोड़े "),
                onTap: () {
                 value. createPost();
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add_alt_1), title: Text("नया उपयोगकर्ता जोड़े  "),
                onTap: () {
                  Navigator.pushNamed(context, '/SignUpScreen');
                },
              ),

              ListTile(
                leading: Icon(Icons.fact_check), title: Text("विभाग बनाएँ"),
                onTap: () {
                  Navigator.pushNamed(context, DeparmentCreateScreen.classname);
                },
              ),

              ListTile(
                leading: Icon(Icons.person), title: Text("लॉग आउट"),
                onTap: () {
                  FutureBuilder(future: value.performLogOut(),
                  builder: (context,snap){
                    return null;
                  },
                  );
                }),

              ListTile(
                leading: Icon(Icons.contacts), title: Text("संपर्क करें"),
                onTap: () {
                  value.contactus();
                 // Navigator.pop(context);
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
