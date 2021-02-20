import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:model_architecture/Globals/Widgets/drawer.dart';
import 'package:model_architecture/providers/PostCreateProvider.dart';
import 'package:model_architecture/providers/PostProvider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'Components/AddMore.dart';




class PostCreateScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<PostCreateProvider>(context);
    return Consumer<PostCreateProvider>(

      builder: (context, value, child)  {
        return Scaffold(
          drawer: GlobalDrawer(),
          appBar: AppBar(title: Text("Add new post"),
          bottom:PreferredSize(child:  LinearPercentIndicator(
            width: MediaQuery.of(context).size.width,
            lineHeight: 5.0,
            percent: provider.percent,

            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: Colors.white,
            progressColor: Colors.green,
          ),  ),

          ),
          body:  SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Choose Type of Post", style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),)),
                        SizedBox(height: 25,),
                        Row(children: [
                          Flexible(
                        fit: FlexFit.tight,
                        flex:4,
                          child: RadioListTile(
                          groupValue: value.radioItem,
                          title: Text('General',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          value: 'General',
                          onChanged:value.setDepartment,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex:5,
                        child: RadioListTile(
                          groupValue: value.radioItem,
                          title: Text('Departmental',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          value: 'Departmental',
                          onChanged:value.setDepartment,
                        ),
                      ),
                    ],),
                        SizedBox(height: 25,),
                        TextField(controller:value.title_controller,decoration: InputDecoration(labelText: 'Title')),
                        SizedBox(height: 25,),
                        TextFormField(
                            decoration: InputDecoration(labelText: 'Description'),
                            controller: value.description_controller,
                            keyboardType: TextInputType.multiline,
                            maxLines: null
                        ),
                        SizedBox(height: 25,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            children: value.filesWidgets,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.88,
                          child: RaisedButton(child: Text("Submit",style: TextStyle(color: Colors.white),),
                          color: Theme.of(context).accentColor,
                          onPressed: value.uploadPost,
                          ),
                        ),
                      ],

                    ),
                  ),
                )
        );
      }
    );
  }
}
