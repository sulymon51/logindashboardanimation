// import 'dart:html';

import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_dash_animation/screens/main_screen.dart';
import 'package:login_dash_animation/screens/myridesScreen.dart';
import 'package:login_dash_animation/screens/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart' as validator;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


import 'model/place_model.dart';


class AditionalScreen extends StatefulWidget {
    // static String routeName = "taxi-movement-page";
  final PlaceDetail fromPlaceDetail;
  final PlaceDetail toPlaceDetail;
  final Set<Polyline> polylines;
  final List<LatLng> polylineCoordinates;
  final stname;
  final dtname;
  final frmlt;
  final frmlg;
  final tolt;
  final tolg;
  const AditionalScreen(
      {Key key,
      this.fromPlaceDetail,
      this.toPlaceDetail,
      this.polylines,
      this.polylineCoordinates,
      this.stname, this.dtname,
      this.frmlt, 
      this.frmlg, 
      this.tolt, 
      this.tolg
      })
      : super(key: key);
  
  // AditionalScreen({@required this.stname, this.dtname});

  @override
  _AditionalScreenState createState() => _AditionalScreenState();

  
}

class _AditionalScreenState extends State<AditionalScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final fromController = TextEditingController();
  final destinController = TextEditingController();
  final frmlgController = TextEditingController();
  final frmltController = TextEditingController();
  final tolgController = TextEditingController();
  final toltController = TextEditingController();
  final carnumberController = TextEditingController();
  final carcolorController = TextEditingController();
  final carmodelController = TextEditingController();
  final numberofseatsController = TextEditingController();
  final costperseatController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  DateTime date1;
  DateTime date2;
  DateTime date3;
   final timeFormat = DateFormat("h:mm a");
  DateTime date;
  TimeOfDay time;
  
  @override
  void dispose(){
    fromController.dispose();
    destinController.dispose();
    carnumberController.dispose();
    carcolorController.dispose();
    carmodelController.dispose();
    numberofseatsController.dispose();
    costperseatController.dispose();
    timeController.dispose();
    dateController.dispose();
    frmlgController.dispose();
    frmltController.dispose();
    tolgController.dispose();
    toltController.dispose();
    super.dispose();
  }
Future sharRidezac() async {
    // Showing CircularProgressIndicator.
    setState(() {
      // visible = true;
      // _isLoading = false;
    });

    // Getting value from Controller
    String from = fromController.text;
    String to = destinController.text;
    String carnumber = carnumberController.text;
    String carcolor = carcolorController.text;
    String carmodel = carmodelController.text;
    String numberofseats = numberofseatsController.text;
    String costperseat = costperseatController.text;
    String time = timeController.text;
    String date = dateController.text;
    String frmlg = frmlgController.text;
    String frmlt = frmltController.text;
    String tolg = tolgController.text;
    String tolt = toltController.text;
    
    print(id);
    // SERVER API URL
    var url = 'https://ridezmyway.com/apiall/shareridez.php';

    final response = await http.post(url, body: {
      // "flag": 1.toString(),
      "from": from,
      "to": to,
      "carnumber": carnumber,
      "carcolor": carcolor,
      "carmodel": carmodel,
      "numberofseats": numberofseats,
      "costperseat": costperseat,
      "time": time,
      "date": date,
      "frmlg": frmlg,
      "frmlt": frmlt,
      "tolg": tolg,
      "tolt": tolt,
      "id": id,
      "driverimage": driverimage,
      "name": name,
      "city": city,
      "phone": phone,
      "bookedseats": "00",
      "status": "00",
      "ac": "yes",
      "music": "yes",
      "smoking": "no",
      
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];

    registerToast(String toast) {
      return Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.deepOrange,
          textColor: Colors.white);
    }

    if (value == 1) {
      setState(() {
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => MainScreen()),
        );
      });
      print(message);
      registerToast(message);
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else if (value == 2) {
      print(message);
      registerToast(message);
    } else {
      print(message);
      registerToast(message);
    }

    print(message);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        // visible = false;
      });
    }

  }




  @override
  Widget build(BuildContext context) {
        // String _formattedate = new DateFormat.yMMMd().format(_currentdate);
 getCredential();
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return new Scaffold(
        appBar: AppBar(
          title: Text("ADDITIONAL FILDS "),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.user),
              onPressed: () {},
            ),
          ],
          elevation: 0,
          // backgroundColor: Color.fromARGB(255, 20, 0, 100),
          backgroundColor: Colors.deepOrange,
          brightness: Brightness.dark,
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: new Form(
          key: _formKey,
          // color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 50.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[],
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                               Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'ROUTE DETAILS',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // _status ? _getEditIcon() : new Container(),
                                        ],
                                      )
                                    ],
                                  )),

                                  Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Starting Location',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      enabled: false,
                                      controller: fromController
                                        ..text = '${widget.stname}',
                                      decoration: const InputDecoration(
                                        hintText: "Starting Location",
                                      ),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                              Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[ 
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Detination ',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      enabled: false,
                                      controller: destinController
                                        ..text = '${widget.dtname}',
                                      decoration: const InputDecoration(
                                        hintText: "Destination",
                                      ),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )
                              ),
                      // Lat and lag HiddenInputElement form 

                        Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new
                                    Visibility(
                                     visible: false,
                                    child: new TextFormField(
                                      enabled: false,
                                      controller: frmlgController
                                        ..text = '${widget.frmlg}',
                                      decoration: const InputDecoration(
                                        hintText: "Destination",
                                      ),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    ),
                                    )
                                  
                                ],
                              )
                              ),

                              Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Visibility(
                                     visible: false,
                                    child: new TextField(
                                      enabled: false,
                                      controller: frmltController
                                        ..text = '${widget.frmlt}',
                                      decoration: const InputDecoration(
                                        hintText: "Destination",
                                      ),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )
                              ),
                              Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Visibility(
                                     visible: false,
                                    child: new TextField(
                                      enabled: false,
                                      controller: tolgController
                                        ..text = '${widget.tolg}',
                                      decoration: const InputDecoration(
                                        hintText: "Destination",
                                      ),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )
                              ),
                              Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Visibility(
                                     visible: false,
                                    child: new TextField(
                                      enabled: false,
                                      controller: toltController
                                        ..text = '${widget.tolt}',
                                      decoration: const InputDecoration(
                                        hintText: "Destination",
                                      ),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )
                              ),


                      // Lat and lag HiddenInputElement ends here



                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'CAR DETAILS',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),

                                      // Imageform field



                                      // image form fiel ends



                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // _status ? _getEditIcon() : new Container(),
                                        ],
                                      )
                                    ],
                                  )),

                                  Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Car Model',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      enabled: false,
                                      controller: carmodelController
                                         ..text = '' + carmodel,
                                      decoration: const InputDecoration(
                                        hintText: "Car Model",
                                      ), 
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                              Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Car Number',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      enabled: false,
                                      controller: carnumberController
                                        ..text = '' +carnumber,
                                      decoration: const InputDecoration(
                                        hintText: "Car Number",
                                      ),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )
                              ),
                              
                             Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Car Color',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      enabled: false,
                                      controller: carcolorController
                                        ..text = '' +carcolor,
                                      decoration: const InputDecoration(
                                        hintText: "Car Color",
                                      ),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )
                              ),
                              


                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'RIDE DETAILS',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold                                              
                                                ),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // _status ? _getEditIcon() : new Container(),
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Number Of Seats',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      validator: (value){
                                      if(value.isEmpty){
                                        return 'Should Not Be Empty';
                                      }
                                      return null;
                                    },
                                      controller: numberofseatsController,
                                        // ..text = 'No. Of Seats',
                                      decoration: const InputDecoration(
                                        hintText: "Number Of Seats",
                                      ),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Cost Per Seat',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      validator: (value){
                                      if(value.isEmpty){
                                        return 'Should Not Be Empty';
                                      }
                                      return null;
                                    },
                                      controller: costperseatController,
                                        // ..text = 'Cost Per Seat',
                                      decoration: const InputDecoration(
                                          hintText: "Cost Per Seat"),
                                      // enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Time',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new
                                    TimePickerFormField(
                                    controller: timeController,
                                    format: timeFormat,
                                    initialTime: TimeOfDay.now(),
                                    decoration: InputDecoration(labelText: 'Time',
                                    icon: const Icon(Icons.timer),
                                    hasFloatingPlaceholder: false
                                    ),
                                    onChanged: (t) => setState(() => time = t),
                                  ),
                                    
                                    
                                    
                                    //  TextFormField(
                                    //    validator: (value){
                                    //   if(value.isEmpty){
                                    //     return 'Time Should Not Be Empty';
                                    //   }
                                    //   return null;
                                    // },
                                    //   controller: timeController,
                                    //     // ..text = 'Time',
                                    //   decoration: const InputDecoration(
                                    //       hintText: "Enter Time"),
                                    //   // enabled: !_status,
                                    // ),
                                    
                                  ),
                                ],
                              )
                              
                      ),
                      Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Date',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new 
                                    DateTimePickerFormField(
                                  controller: dateController,
                                  inputType: InputType.date,
                                  format: DateFormat("yyyy-MM-dd"),
                                  initialDate: DateTime.now(),
                                  editable: false,
                                  decoration: const InputDecoration(
                                          hintText: "Enter Date",
                                           icon: const Icon(Icons.date_range),),
                                          
                                  onChanged: (dt) {
                                    setState(() => date2 = dt);
                                    // print('Selected date: $date2');
                                  },
                                ),
                                    // TextFormField(
                                    //   controller: dateController,
                                    //   validator: (value){
                                    //   if(value.isEmpty){
                                    //     return 'Date Should Not Be Empty';
                                    //   }
                                    //   return null;
                                    // },
                                    //     // ..text = 'Date',
                                    //   decoration: const InputDecoration(
                                    //       hintText: "Enter Date"),
                                    //   // enabled: !_status,
                                    // ),
                                  ),
                                ],
                              )  
                      ),
                      SizedBox(height: 10,),
                      RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        onPressed: () {
                          if(_formKey.currentState.validate()){
                          
                              var from = fromController.text;
                              var to = destinController.text;
                              var carcolor = carcolorController.text;
                              var carnumber = carnumberController.text;
                              // var date = dateController.text;
                              // var time = timeController.text;
                              var numberofseats = numberofseatsController.text;
                              var costperseat = costperseatController.text;
                              var carmodel = carmodelController.text;
                              var frml = frmlgController.text;
                              var frmlt = frmltController.text;
                              var tolg = tolgController.text;
                              var tolt = toltController.text;
                              

                              print('From: ${from} To: ${to}');
                              print('lang: ${frml} Lat: ${frmlt}');
                              print('Des lan: ${tolg} Des lt: ${tolt}');
                              print(id);
                          }
                          sharRidezac();
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Share Ride',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

   SharedPreferences sharedPreferences;

  String name = "", phone = "", email = "",  type = "",  carnumber = "", carmodel= "", carcolor = "", id="", driverimage= "", city = "";


  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString("name");
      email= sharedPreferences.getString("email");
      phone= sharedPreferences.getString("phone");
      type= sharedPreferences.getString("type");
      carnumber= sharedPreferences.getString("carnumber");
      carmodel = sharedPreferences.getString("carmodel");
      carcolor= sharedPreferences.getString("carcolor");
      id= sharedPreferences.getString("id");
      driverimage= sharedPreferences.getString("driverimage");
      city= sharedPreferences.getString("city");

      
    });
  //  print(email);            

  //  print(name);

  }

  


}
