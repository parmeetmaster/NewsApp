import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/constantPackage/constColors.dart';

import 'package:model_architecture/providers/SearchProviderDepartment.dart';
import 'package:model_architecture/screens/HomeScreenGeneral/Components/PostContainer.dart';
import 'package:model_architecture/utils/languageDeligate.dart';
import 'package:provider/provider.dart';

class SearchScreenDepartment extends StatefulWidget {
  static const String classname = '/SearchScreenDepartment';

  @override
  _SearchScreenDepartmentState createState() => _SearchScreenDepartmentState();
}

class _SearchScreenDepartmentState extends State<SearchScreenDepartment> {
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController _controller1;
  TextEditingController _controller2;
  TextEditingController _controller3;
  TextEditingController _controller4;

  //String _initialValue;
  String _valueChanged1 = '';
  String _valueToValidate1 = '';
  String _valueSaved1 = '';
  String _valueChanged2 = '';
  String _valueToValidate2 = '';
  String _valueSaved2 = '';
  String _valueChanged3 = '';
  String _valueToValidate3 = '';
  String _valueSaved3 = '';
  String _valueChanged4 = '';
  String _valueToValidate4 = '';
  String _valueSaved4 = '';

  @override
  void initState() {
    _controller1 = TextEditingController();

    super.initState();
    Provider.of<SearchScreenProviderDepartment>(context,listen: false).initDepartemetList();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchScreenProviderDepartment>(context);
    provider.setContext(context);
    return Scaffold(
        appBar: _getAppBar(),
        body: Consumer<SearchScreenProviderDepartment>(builder: (context, value, child) {
          return SingleChildScrollView(
              child: Column(
            children: value.postWidgets,
          ));
        }));
  }

  String _dropDownValue;

  _getAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(320),
      child: Consumer<SearchScreenProviderDepartment>(builder: (context, value, child) {
        return value.searchExpanded
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "खबरों की तलाश करें",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        controller: value.searchinputController,
                        decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                            prefixIcon: Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: searchboxgrey, width: 2.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: new OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: searchboxgrey, width: 2.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "संक्षिप्त विवरण दे ",
                            fillColor: searchboxgrey),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.88,
                            child: DropdownButton(
                              hint: _dropDownValue == null
                                  ? Text('${value.departmentDropDownName}')
                                  : Text(
                                      _dropDownValue,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: Colors.blue),
                              items: value.getListOfDepartments().map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: value.setDepartemnt,
                            ),
                          ),
                          SizedBox(
                              height: 30,
                              width: 20,
                              child: Center(
                                child: VerticalDivider(
                                  color: Colors.black,
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.88 / 2,
                            child: new DateTimePicker(
                              type: DateTimePickerType.date,
                              dateMask: 'dd-MM-yyyy',
                              controller: _controller1,
                              //initialValue: _initialValue,
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2022),

                              dateLabelText: 'दिनांक से ',
                              timeLabelText: "घंटे",
                              //use24घंटेFormat: false,
                              //locale: Locale('pt', 'BR'),
                              selectableDayPredicate: (date) {
                                /*if (date.weekday == 6 || date.weekday == 7) {
                      return false;
                    }*/
                                return true;
                              },
                              onChanged: value.setFromDate,
                              validator: (val) {
                                print("validator${val}");
                              },
                              onSaved: (val) {
                                print("onSaved${val}");
                              },
                            ),
                          ),
                          Center(
                            child: SizedBox(
                                height: 30,
                                width: 20,
                                child: VerticalDivider(
                                  color: Colors.black,
                                )),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.88 / 2,
                            height: 60,
                            child: new DateTimePicker(
                              type: DateTimePickerType.date,
                              dateMask: 'dd-MM-yyyy',
                              controller: _controller2,
                              //initialValue: _initialValue,
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2022),

                              dateLabelText: 'To Date',
                              timeLabelText: "घंटे",
                              //use24घंटेFormat: false,
                              //locale: Locale('pt', 'BR'),
                              selectableDayPredicate: (date) {
                                /*if (date.weekday == 6 || date.weekday == 7) {
                      return false;
                    }*/
                                return true;
                              },
                              onChanged: value.setToDate,
                              validator: (val) {
                                print("validator${val}");
                              },
                              onSaved: (val) {
                                print("onSaved${val}");
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: RaisedButton(
                            color: Colors.blue,
                            onPressed: value.onSubmit,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search, color: Colors.white),
                                Text("खोज करें",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          value.setExpansion(false);
                        },
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 30,
                        ))
                  ],
                ),
              )
            : Container(
                height: 108,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 50),
                          child: Text(
                            "खबरों की तलाश करें",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, right: 25),
                          child: InkWell(
                              onTap: () {
                                value.setExpansion(true);
                              },
                              child: Icon(Icons.search)),
                        )
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          value.setExpansion(true);
                        },
                        child: Container(
                            width: 80, child: Icon(Icons.arrow_drop_down)))
                  ],
                ));
      }),
    );
  }
}
