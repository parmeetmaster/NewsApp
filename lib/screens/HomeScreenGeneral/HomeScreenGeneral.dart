import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:model_architecture/Globals/Widgets/drawer.dart';

import 'package:model_architecture/providers/HomeProvider.dart';
import 'package:model_architecture/providers/SampleProvider.dart';

import 'package:model_architecture/screens/SearchScreen/SearchScreen.dart';
import 'file:///D:/Practice%20folder/News%20App/lib/Globals/Globals.dart';
import 'package:model_architecture/utils/languageDeligate.dart';
import 'package:provider/provider.dart';

import 'Components/CornerImages.dart';
import 'Components/PostContainer.dart';

class HomeScreenGeneral extends StatefulWidget {
  static const classname= "/HomeScreenGeneral";
  @override
  _HomeScreenGeneralState createState() => _HomeScreenGeneralState();
}

class _HomeScreenGeneralState extends State<HomeScreenGeneral> {
  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(

      drawer: GlobalDrawer(),// drawer
        appBar: AppBar(
          actions: [
            InkWell(
              child: Icon(Icons.search),
              onTap: () {
                Navigator.pushNamed(context, SearchScreen.screenname);
              },
            ),
            SizedBox(
              width: 14,
            )
          ],

          title: Text("TOP 10 NEWS"),
        ),
        body: FutureBuilder(
            future: provider.loadData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  return Consumer<HomeProvider>(
                      builder: (context, value, child) {
                    return SingleChildScrollView(
                        child: Column(
                      children: value.postWidgets,
                    ));
                  });
              }
            }));
  }
}
