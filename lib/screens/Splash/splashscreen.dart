import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/Globals/Globals.dart';
import 'package:model_architecture/constantPackage/constStrings.dart';
import 'package:model_architecture/providers/SplashProvider.dart';
import 'package:model_architecture/screens/HomeScreenGeneral/HomeScreenGeneral.dart';
import 'package:model_architecture/screens/InternetNotFoundScreen/InternetNotFound.dart';
import 'package:model_architecture/screens/PostCreateScreen2/PostCreateScreen2.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
static const classname="/SplashScreen";
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {



  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage()async {
    if(Globals.list_of_department.length>0) {
      Navigator.of(context).pushReplacementNamed(HomeScreenGeneral.classname);
    }else{
      await  Provider.of<SplashProvider>(context,listen: false).checkInternetConnection();
      if( Provider.of<SplashProvider>(context,listen: false).isinternetworking==false){
        Navigator.of(context).pushReplacementNamed(InternetNotFound.classname);
        Provider.of<SplashProvider>(context,listen: false).dispose();
      }

      await Future.delayed(Duration(seconds:4));
      Provider.of<SplashProvider>(context,listen: false).loadDepartements();



      navigationPage();
    }


    }

  @override
  void initState() {
    super.initState();
    Provider.of<SplashProvider>(context,listen: false).checkInternetConnection();
    Provider.of<SplashProvider>(context,listen: false).loadCredentials();
    Provider.of<SplashProvider>(context,listen: false).loadDepartements();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

            ],),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/images/logo.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}