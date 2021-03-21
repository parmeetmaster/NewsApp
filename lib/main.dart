import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route_annotations.dart';
import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/api/Api.dart';
import 'package:model_architecture/constantPackage/language/languageEn.dart';
import 'package:model_architecture/providers/DepartmentCreateProvider.dart';
import 'package:model_architecture/providers/DrawerProvider.dart';
import 'package:model_architecture/providers/HomeProvider.dart';

import 'package:model_architecture/providers/PostProvider.dart';
import 'package:model_architecture/providers/SampleProvider.dart';
import 'package:model_architecture/providers/SearchProviderDepartment.dart';
import 'package:model_architecture/providers/SignInProvider.dart';
import 'package:model_architecture/providers/SignUpProvider.dart';
import 'package:model_architecture/providers/SplashProvider.dart';
import 'package:model_architecture/screens/CreateDepartment/DepartmentCreateScreen.dart';
import 'package:model_architecture/screens/ImagePickerScreen/imagepicker.dart';
import 'package:model_architecture/screens/InternetNotFoundScreen/InternetNotFound.dart';
import 'package:model_architecture/screens/SearchScreen/SearchScreenDepartment.dart';
import 'package:model_architecture/screens/SuccessScreen/SuccessScreen.dart';
import 'file:///D:/Practice%20folder/News%20App/lib/screens/SignUp/signup.dart';
import 'file:///D:/Practice%20folder/News%20App/lib/Globals/Globals.dart';
import 'file:///D:/git%20main/flutter-modules/model_architecture/lib/api/api_service.dart';
import 'package:model_architecture/utils/languageDeligate.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'providers/SearchProvider.dart';

import 'screens/HomeScreenGeneral/HomeScreenGeneral.dart';

import 'screens/PostScreen/PostScren.dart';
import 'screens/SearchScreen/SearchScreen.dart';
import 'screens/SignIn/signin.dart';
import 'screens/Splash/splashscreen.dart';
import 'utils/preference.dart';
// need to add async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Preference.load();



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SampleProvider()),
        ChangeNotifierProvider(create: (ctx) => PostProvider()),
        ChangeNotifierProvider(create: (ctx) => SplashProvider()),
        ChangeNotifierProvider(create: (ctx) => SearchScreenProvider()),
        ChangeNotifierProvider(create: (ctx) => SignInProvider()),
        ChangeNotifierProvider(create: (ctx) => SignUpProvider()),
        ChangeNotifierProvider(create: (ctx) => HomeProvider()),
        ChangeNotifierProvider(create: (ctx) => SearchScreenProviderDepartment()),
        ChangeNotifierProvider(create: (ctx) => DepartmentCreateProvider()),
        ChangeNotifierProvider(create: (ctx) => DrawerProvider()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: SplashScreen.classname,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        HomeScreenGeneral.classname: (context) => HomeScreenGeneral(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/SearchScreen': (context) => SearchScreen(),
        '/post':(context)=>PostScreen(),
        SplashScreen.classname:(context)=>SplashScreen(),
        '/SignInPage':(context)=>SignInPage(),
        InternetNotFound.classname:(context)=>InternetNotFound(),
        '/SignUpScreen':(context)=>SignUpScreen(),
        '/SignUpScreen':(context)=>SignUpScreen(),
        DeparmentCreateScreen.classname:(context)=>DeparmentCreateScreen(),
        SuccessScreen.classname:(context)=>SuccessScreen(),
        '/SplashScreen':(context)=>SplashScreen(),
        SearchScreenDepartment.classname:(context)=>SearchScreenDepartment()
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}
/////////////////


class CustomFilePicker extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CustomFilePicker();
  }
}

class _CustomFilePicker extends State<CustomFilePicker>{

  File selectedfile;
  Response response;
  String progress;
  Dio dio = new Dio();



  uploadFile() async {
    String uploadurl = "https://news.inrexa.com/fileup.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(
          selectedfile.path,
          filename: basename(selectedfile.path)
        //show only filename from path
      ),
    });

    response = await dio.post(uploadurl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent/total*100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" + " Bytes of " "$total Bytes - " +  percentage + " % uploaded";
          //update the progress
        });
      },);

    if(response.statusCode == 200){
      print(response.toString());
      //print response from server
    }else{
      print("Error during connection to server.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text("Select File and Upload"),
          backgroundColor: Colors.orangeAccent,
        ), //set appbar
        body:Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(40),
            child:Column(children: <Widget>[

              Container(
                margin: EdgeInsets.all(10),
                //show file name here
                child:progress == null?
                Text("Progress: 0%"):
                Text(basename("Progress: $progress"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),),
                //show progress status here
              ),

              Container(
                margin: EdgeInsets.all(10),
                //show file name here
                child:selectedfile == null?
                Text("Choose File"):
                Text(basename(selectedfile.path)),
                //basename is from path package, to get filename from path
                //check if file is selected, if yes then show file name
              ),

              Container(
                  child:RaisedButton.icon(
                    onPressed: (){

                    },
                    icon: Icon(Icons.folder_open),
                    label: Text("CHOOSE FILE"),
                    color: Colors.redAccent,
                    colorBrightness: Brightness.dark,
                  )
              ),

              //if selectedfile is null then show empty container
              //if file is selected then show upload button
              selectedfile == null?
              Container():
              Container(
                  child:RaisedButton.icon(
                    onPressed: (){
                      uploadFile();
                    },
                    icon: Icon(Icons.folder_open),
                    label: Text("UPLOAD FILE"),
                    color: Colors.redAccent,
                    colorBrightness: Brightness.dark,
                  )
              )

            ],)
        )
    );
  }
}
