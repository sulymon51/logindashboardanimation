import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_dash_animation/chat/lets_text.dart';
import 'package:login_dash_animation/models/allrides.dart';
import 'package:login_dash_animation/screens/History/requesthis.dart';
import 'package:login_dash_animation/screens/driver/mappage.dart';
import 'package:login_dash_animation/screens/driver/model/place_model.dart';
import 'package:login_dash_animation/screens/driver/pages/taxi_movement_page.dart';
import 'package:login_dash_animation/src/data/category_data.dart';
import 'package:login_dash_animation/src/models/category_model.dart';
import 'package:login_dash_animation/theme/style.dart';
import 'package:login_dash_animation/widgets/allridesmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

 

class RideSHar extends StatefulWidget {
  @override
  _RideSHarState createState() => _RideSHarState();
}

class _RideSHarState extends State<RideSHar> {
  final _formKey = GlobalKey<FormState>();
  final List<Category> _categories = categories;

  bool visible = false;

  bool _isLoading = false;

 


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  TextEditingController _bookController = new TextEditingController();
  TextEditingController idsController = new TextEditingController();
  TextEditingController costController = new TextEditingController();
  TextEditingController statusController = new TextEditingController();
  TextEditingController driveridController = new TextEditingController();
  TextEditingController drivernamController = new TextEditingController();
  TextEditingController drivernumController = new TextEditingController();
  TextEditingController carcollorController = new TextEditingController();
  TextEditingController carmodelController = new TextEditingController();
  TextEditingController carnumberController = new TextEditingController();
  TextEditingController carpicController = new TextEditingController();
  TextEditingController destinationController = new TextEditingController();
  TextEditingController startjController = new TextEditingController();
  TextEditingController slanController = new TextEditingController();
  TextEditingController slatController = new TextEditingController();
  TextEditingController dlanController = new TextEditingController();
  TextEditingController dlatController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController driverimgController = new TextEditingController();

  Future userRerequest() async {
    
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
      _isLoading = false;
    });
    // Getting value from Controller
    String seatno = _bookController.text;
    String ids = idsController.text;
    String cost = costController.text;
    String status = statusController.text;
    String driverid = driveridController.text;
    String drivernam = drivernamController.text;
    String drivernum = drivernumController.text;
    String carcol = carcollorController.text;
    String carmo = carmodelController.text;
    String carnum = carnumberController.text;
    String carpic = carpicController.text;
    String destn = destinationController.text;
    String startjo = startjController.text;
    String slan = slanController.text;
    String alat = slatController.text;
    String dlan = dlanController.text;
    String dlat = dlatController.text;
    String date = dateController.text;
    String time = timeController.text;
    String driverimg = driverimgController.text;

    // SERVER API URL
    var url = 'https://ridezmyway.com/apiall/requestri.php';
    final response = await http.post(url, body: {
      // "flag": 1.toString(),
      "booked": seatno,
      "rideid": id,
      "ridename": name,
      "ridenumber": phone,
      "seatno": seatno,
      "shareid": ids,
      "cost": cost,
      "status": status,
      "driverid": driverid,
      "drivernam": drivernam,
      "drivernum": drivernum,
      "carcol": carcol,
      "carmo": carmo,
      "carnum": carnum,
      "carpic": carpic,
      "destn": destn,
      "startjo": startjo,
      "slan": slan,
      "alat": alat,
      "dlan": dlan,
      "dlat": dlat,
      "date": date,
      "time": time,
      "driverimg": driverimg,
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
          backgroundColor: Colors.green,
          textColor: Colors.white);
          
    }

    if (value == 1) {
      showNotification();
      setState(() {
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new RequesthScreen()),
        );
      });
      print(message);
      registerToast(message);
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => new RequesthScreen()),
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
        visible = false;
      });
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getCredential();
  // }

  @override
  Widget build(BuildContext context) {
    // getCredential();
    return Container(
      height: 480.0,
      // width: 450.0,
      child: FutureBuilder(
        future: alridezModel(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  AlridezModel alridezModel = snapshot.data[index];
                  return Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFF082938)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 247,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage('${alridezModel.carPic}'),
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.dstATop),
                                  fit: BoxFit.cover),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Center(
                                  child:
                                  Builder(
                                  builder: (context) {
                                    var newa = '${alridezModel.seatNo}';
                                    // print(newa);
                                    if (newa == "0") {
                                      return   Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      IconButton(
                                        icon: allriedItemIcon(Icons.call, ""),
                                        // onPressed: () => _service.call(number),
                                        onPressed: () => UrlLauncher.launch(
                                            "tel://" +
                                                '${alridezModel.driverNumber}'),
                                      ),
                                      IconButton(
                                        icon: allriedItemIcon(Icons.chat, ""),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LetsChat()),
                                          );
                                        },
                                      ),
                                      SizedBox(width: 0),
                                      SizedBox(width: 1),
                                      RaisedButton.icon(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    10.0)),
                                        elevation: 0.0,
                                        color: Colors.grey[400],
                                        icon: new Text(''),
                                        label: new Text(
                                          'All Booked',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () => {}
                                          ),
                                    ],
                                  );
                                  }else{
                                    return  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      IconButton(
                                        icon: allriedItemIcon(Icons.call, ""),
                                        // onPressed: () => _service.call(number),
                                        onPressed: () => UrlLauncher.launch(
                                            "tel://" +
                                                '${alridezModel.driverNumber}'),
                                      ),
                                      IconButton(
                                        icon: allriedItemIcon(Icons.chat, ""),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LetsChat()),
                                          );
                                        },
                                      ),
                                      SizedBox(width: 0),
                                      SizedBox(width: 1),
                                      RaisedButton.icon(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    10.0)),
                                        elevation: 0.0,
                                        color: Colors.deepOrange,
                                        icon: new Text(''),
                                        label: new Text(
                                          'Request Now',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Form(
                                                    key: _formKey,
                                                    child: AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      32.0))),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 10.0),
                                                      content: Container(
                                                        width: 300.0,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  "RidezMyway",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.0),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.grey,
                                                              height: 4.0,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          30.0,
                                                                      right:
                                                                          30.0),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .phone,
                                                                    maxLength:
                                                                        1,
                                                                    validator:
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Should Not Be Empty';
                                                                      }
                                                                      return null;
                                                                    },
                                                                    controller:
                                                                        _bookController,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      hintText:
                                                                          "Enter Seats No.",
                                                                    ),
                                                                    maxLines: 2,
                                                                  ),
                                                                  Column(
                                                                    children: <
                                                                        Widget>[],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: idsController
                                                                          ..text =
                                                                              '${alridezModel.id}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: idsController
                                                                          ..text =
                                                                              '${alridezModel.id}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: costController
                                                                          ..text =
                                                                              '${alridezModel.seatCost}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: statusController
                                                                          ..text =
                                                                              '${alridezModel.status}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: driveridController
                                                                          ..text =
                                                                              '${alridezModel.driverId}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: drivernamController
                                                                          ..text =
                                                                              '${alridezModel.driverName}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: drivernumController
                                                                          ..text =
                                                                              '${alridezModel.driverNumber}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: carcollorController
                                                                          ..text =
                                                                              '${alridezModel.carColor}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: carmodelController
                                                                          ..text =
                                                                              '${alridezModel.carModel}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: carnumberController
                                                                          ..text =
                                                                              '${alridezModel.carNumber}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: driverimgController
                                                                          ..text =
                                                                              '${alridezModel.driverImage}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: carpicController
                                                                          ..text =
                                                                              '${alridezModel.carPic}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: destinationController
                                                                          ..text =
                                                                              '${alridezModel.destName}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: startjController
                                                                          ..text =
                                                                              '${alridezModel.startName}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: slanController
                                                                          ..text =
                                                                              '${alridezModel.startLan}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: slatController
                                                                          ..text =
                                                                              '${alridezModel.startLat}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: dlanController
                                                                          ..text =
                                                                              '${alridezModel.destLan}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: dlatController
                                                                          ..text =
                                                                              '${alridezModel.destLat}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: dateController
                                                                          ..text =
                                                                              '${alridezModel.date}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25.0,
                                                                        right:
                                                                            25.0,
                                                                        top:
                                                                            2.0),
                                                                child: new Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <
                                                                      Widget>[
                                                                    new Visibility(
                                                                      visible:
                                                                          false,
                                                                      child:
                                                                          new TextField(
                                                                        enabled:
                                                                            false,
                                                                        controller: timeController
                                                                          ..text =
                                                                              '${alridezModel.time}',
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              "Starting Location",
                                                                        ),
                                                                        // enabled: !_status,
                                                                        // autofocus: !_status,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            InkWell(
                                                              child: Container(
                                                                  padding: EdgeInsets.only(
                                                                      top: 5.0,
                                                                      bottom:
                                                                          5.0),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .deepOrange,
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                32.0),
                                                                        bottomRight:
                                                                            Radius.circular(32.0)),
                                                                  ),
                                                                  child: Builder(
                                                                      builder:
                                                                          (context) {
                                                                    var newa =
                                                                        '${alridezModel.seatNo}';
                                                                    print(newa);
                                                                    if (newa ==
                                                                        "0") {
                                                                      return FlatButton(
                                                                        child:
                                                                            Text(
                                                                          "All Booked",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                        onPressed:
                                                                            () =>
                                                                                {},
                                                                      );
                                                                    } else {
                                                                      return FlatButton(
                                                                        child:
                                                                            Text(
                                                                          "Request Ride",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                        // onPressed: () =>
                                                                        //     Navigator.pop(
                                                                        //         context, 'OK'),
                                                                        onPressed:
                                                                            () {
                                                                          if (_formKey
                                                                              .currentState
                                                                              .validate()) {
                                                                            // var from = fromController.text;
                                                                            userRerequest();
                                                                            // print('From: ${from} To: ${to}');

                                                                          }

                                                                          // CircularProgressIndicator();
                                                                        },
                                                                      );
                                                                    }
                                                                  })),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                              }).then((returnVal) {
                                            if (returnVal != null) {
                                              Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'You clicked: $returnVal'),
                                                  action: SnackBarAction(
                                                      label: 'OK',
                                                      onPressed: () {}),
                                                ),
                                              );
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ) ;
              }
              })
                                  
                                  
                                  
                                ),
                                SizedBox(height: 6),
                                SizedBox(height: 9),
                                Center(
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${alridezModel.driverImage}'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    allriedItemIcon(
                                        Icons.timer, "" '${alridezModel.time}'),
                                    SizedBox(width: 6),
                                    allriedItemIcon(Icons.date_range,
                                        "" '${alridezModel.date}'),
                                  ],
                                ),
                                SizedBox(width: 6),
                                Text(
                                    "Cost Per Seat: "
                                    "\₦"
                                    '${alridezModel.seatCost}',
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "Available Seat No: "
                                    '${alridezModel.seatNo}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 2),
                                Icon(Icons.place,
                                    size: 10, color: Colors.white),
                                Text("From: " + '${alridezModel.startName}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 6),
                                Text('|',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.gps_fixed,
                                    size: 10, color: Colors.white),
                                SizedBox(height: 3),
                                Text("To:" + '${alridezModel.destName}',
                                    style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 3),
                                Text("Car Model: " + '${alridezModel.carModel}',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 3),
                                Text("Car No: " '${alridezModel.carNumber}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)),
                                SizedBox(height: 20)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(" ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              SizedBox(height: 3),
                              Text("Name: " '${alridezModel.driverName}',
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  allriedItemIcon(
                                      Icons.airplay, "" + '${alridezModel.ac}'),
                                  SizedBox(width: 15),
                                  allriedItemIcon(Icons.queue_music,
                                      "" '${alridezModel.music}'),
                                  SizedBox(width: 15),
                                  allriedItemIcon(Icons.smoking_rooms,
                                      "" + '${alridezModel.smoking}'),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LetsChat())),
                                    child: Image.asset(
                                      "assets/view_all.png",
                                      height: 30,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }

                // return Column(
                //   children: <Widget>[
                //     Text('${alridezModel.driverName}'),
                //     Text('${alridezModel.carColor}'),
                //     Text('${alridezModel.carNumber}'),
                //   ],

                // );

                );
          } else if (snapshot.hasError) {
            return Center(child: Text('NO RIDEZ AVALABLE IN YOUR ROUTE'));
          }
          //return  a circular progress indicator.
          return Center(child: new CircularProgressIndicator());
        },
      ),
    );
  }

  Widget allriedItemIcon(IconData iconData, String text) {
    return Row(
      children: <Widget>[
        Icon(iconData, color: Colors.white),
        SizedBox(width: 2),
        Text(text, style: TextStyle(color: Colors.white))
      ],
    );

// navigateToDetail() {
//     // var name =  requestRidez.rideName
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => RequestDetail( )));
//   }
    // showDialog() {

    //           }

    // }
  }

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getCredential();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
     var android = AndroidInitializationSettings('@mipmap/ic_launcher');
     var iOS = IOSInitializationSettings();
     var initSetttings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,onSelectNotification: onbookridez);


  }
  Future onbookridez(String payload)async{
     if(payload != null){
       debugPrint("Notification : " + payload);
     }
  }

  Future showNotification()async{
    var android = AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
    var ios = IOSNotificationDetails();
    var platform =NotificationDetails(android,ios);
    flutterLocalNotificationsPlugin.show(0, 'Ride Requested ', 'Await the driver to accept the RIDE', platform,payload: 'check you request ');
  }

  String name = "",
      phone = "",
      email = "",
      id = "",
      profilepic = "",
      dvype = "",
      dvstatus = "";

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString("name");
      phone = sharedPreferences.getString("phone");
      email = sharedPreferences.getString("email");
      profilepic = sharedPreferences.getString("profilepic");
      dvype = sharedPreferences.getString("dvype");
      dvstatus = sharedPreferences.getString("dvstatus");
      id = sharedPreferences.getString("id");
    });

    // print(dvstatus);
    print(id);
  }
}
