import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:login_dash_animation/screens/driver/model/RequestRidez.dart';
import 'package:login_dash_animation/theme/style.dart';
import 'package:login_dash_animation/widgets/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'requestDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

const simplePeriodicTask = "simplePeriodicTask";
// flutter local notification setup
void showNotification( v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High, importance: Importance.Max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);
  await flp.show(0, 'RIDEZMYWAY', '$v', platform,
      payload: 'VIS \n $v');
}

// void main(){
 
//  runApp(App());
// }

Future  maina() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher, isInDebugMode: false); //to true if still in testing lev turn it to false whenever you are launching the app
  await Workmanager.registerPeriodicTask("5", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(seconds: 15),//when should it check the link
      initialDelay: Duration(seconds: 5),//duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
 runApp(RequestScreen());
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);
    var response= await http.post('https://ridezmyway.com/apiall/getnotify.php');
   print("here================");
   print(response);
    var convert = json.decode(response.body);
      if (convert['status']  == true) {
        showNotification(convert['message'], flp);
      } else {
      print("no messgae");
      }
    return Future.value(true);
  });
}



class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final String screenName = "REQUEST";

  // navigateToDetail() {
  //   // var name =  requestRidez.rideName
  //   // Navigator.of(context)
  //   //     .push(MaterialPageRoute(builder: (context) => RequestDetail( )));

  // }

  @override
  Widget build(BuildContext context) {
    //  requestRide();
     return Scaffold(
        appBar: AppBar(
          title: Text(
            'Requests',
            style: TextStyle(color: blackColor),
          ),
          backgroundColor: whiteColor,
          elevation: 2.0,
          iconTheme: IconThemeData(color: blackColor),
        ),
        // drawer: new MenuScreens(activeScreenName: screenName),
        body: Container(
            child: Scrollbar(
            child: FutureBuilder(
          future: requestRide(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    RequestRidez requestRidez = snapshot.data[index];
                    final screenSize = MediaQuery.of(context).size;
                    return GestureDetector(
                        onTap: ()  {
                    var id = '${requestRidez.rideId}';
                    var ida = '${requestRidez.id}';
                    var name = '${requestRidez.rideName}';
                    var number = '${requestRidez.rideNumber}';
                    var seatno = '${requestRidez.seatNo}';
                    var cost = '${requestRidez.cost}';
                    var status = '${requestRidez.requestStatus}';
                    var bseat = '${requestRidez.bookedSeats}';
                    var stname = '${requestRidez.startName}';
                    var dtname = '${requestRidez.destName}';
                    var date = '${requestRidez.date}';
                    var time = '${requestRidez.time}';
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetail(id: id, idaa: ida,rname: name,sname:stname,dname: dtname,aname: cost,pname: number,sename: seatno,bsname: bseat,senname: seatno,sdate: date,stime: time,sstatus: status, )));
                     // Navigator.of(context).pushReplacementNamed('/history');
                    // navigateToDetail();
                  },
                        child: Card(
      margin: EdgeInsets.all(10.0),
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                        imageUrl: 'https://ridezmyway.com/ggn.jpeg',
                        fit: BoxFit.cover,
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${requestRidez.rideName}',
                          style: textBoldBlack,
                        ),
                        Text('${requestRidez.date}'+ '${requestRidez.time}',
                          style: textGrey,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 25.0,
                                padding: EdgeInsets.all(5.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.deepOrange),
                                child: Text(
                                  'WalletPay',
                                  style: textBoldWhite,
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                
                                child:  Container(
                                  child: Builder(
                                      builder: (context) {
                                        var newa = '${requestRidez.requestStatus}';
                                        if (newa == 'pending') {
                                          return  Container(
                                                  height: 25.0,
                                padding: EdgeInsets.all(5.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.red),
                                            child: Text(
                                                  'pending',
                                                  style: textBoldWhite,
                                                ),
                                          );
                                        } else if (newa == 'progress'){
                                          return Container(
                                                  height: 25.0,
                                                  padding: EdgeInsets.all(5.0),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      color: Colors.orange),
                                            child: Text(
                                                  'Progress',
                                                  style: textBoldWhite,
                                                   
                                                ),
                                          );
                                        }else if (newa == 'arrived'){
                                          return Container(
                                                  height: 25.0,
                                                  padding: EdgeInsets.all(5.0),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      color: Colors.orange),
                                            child: Text(
                                                  'Arrived',
                                                  style: textBoldWhite,
                                                   
                                                ),
                                          );
                                        }else {
                                          return Container(
                                                  height: 25.0,
                                                  padding: EdgeInsets.all(5.0),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      color: Colors.orange),
                                            child: Text(
                                                  'Awaiting',
                                                  style: textBoldWhite,
                                                   
                                                ),
                                          );
                                        }
                                      }
                                    ),
                                )
                                                        
                                
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "\₦"+ '${requestRidez.cost}',
                          style: textBoldBlack,
                        ),
                        Text(
                          "Seat No"+ '${requestRidez.bookedSeats}',
                          style: textGrey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "PICK UP".toUpperCase(),
                            style: textGreyBold,
                          ),
                          Text('${requestRidez.startName}',
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "DROP OFF".toUpperCase(),
                            style: textGreyBold,
                          ),
                          Text('${requestRidez.destName}',
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                   
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ButtonTheme(
                minWidth: screenSize.width,
                height: 45.0,
                child: 
                 Builder(
            builder: (context) {
              var newa = '${requestRidez.requestStatus}';
              if (newa == 'pending') {
                return  ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                  elevation: 0.0,
                  color: Colors.deepOrange,
                  child: Text(
                    'View Details',
                    style: headingWhite,
                  ),
                  onPressed: () {
                    var id = '${requestRidez.rideId}';
                    var ida = '${requestRidez.id}';
                    var name = '${requestRidez.rideName}';
                    var number = '${requestRidez.rideNumber}';
                    var seatno = '${requestRidez.seatNo}';
                    var cost = '${requestRidez.cost}';
                    var status = '${requestRidez.requestStatus}';
                    var bseat = '${requestRidez.bookedSeats}';
                    var stname = '${requestRidez.startName}';
                    var dtname = '${requestRidez.destName}';
                    var date = '${requestRidez.date}';
                    var time = '${requestRidez.time}';
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetail(id: id, idaa: ida,rname: name,sname:stname,dname: dtname,aname: cost,pname: number,sename: seatno,bsname: bseat,senname: seatno,sdate: date,stime: time,sstatus: status, )));
                     // Navigator.of(context).pushReplacementNamed('/history');
                    // navigateToDetail();
                  },
                ),
              );
              } else if(newa == 'progress') {
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                  elevation: 0.0,
                  color: Colors.deepOrange,
                  child: Text(
                    'Go to Pick UP',
                    style: headingWhite,
                  ),
                  onPressed: () {
                    var id = '${requestRidez.rideId}';
                    var ida = '${requestRidez.id}';
                    var name = '${requestRidez.rideName}';
                    var number = '${requestRidez.rideNumber}';
                    var seatno = '${requestRidez.seatNo}';
                    var cost = '${requestRidez.cost}';
                    var status = '${requestRidez.requestStatus}';
                    var bseat = '${requestRidez.bookedSeats}';
                    var stname = '${requestRidez.startName}';
                    var dtname = '${requestRidez.destName}';
                    var date = '${requestRidez.date}';
                    var time = '${requestRidez.time}';
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetail(id: id, idaa: ida,rname: name,sname:stname,dname: dtname,aname: cost,pname: number,sename: seatno,bsname: bseat,senname: seatno,sdate: date,stime: time,sstatus: status, )));
                     // Navigator.of(context).pushReplacementNamed('/history');
                    // navigateToDetail();
                  },
                ),
              );
              }else if(newa == 'arrived') {
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                  elevation: 0.0,
                  color: Colors.deepOrange,
                  child: Text(
                    'Start now',
                    style: headingWhite,
                  ),
                  onPressed: () {
                    var id = '${requestRidez.rideId}';
                    var ida = '${requestRidez.id}';
                    var name = '${requestRidez.rideName}';
                    var number = '${requestRidez.rideNumber}';
                    var seatno = '${requestRidez.seatNo}';
                    var cost = '${requestRidez.cost}';
                    var status = '${requestRidez.requestStatus}';
                    var bseat = '${requestRidez.bookedSeats}';
                    var stname = '${requestRidez.startName}';
                    var dtname = '${requestRidez.destName}';
                    var date = '${requestRidez.date}';
                    var time = '${requestRidez.time}';
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetail(id: id, idaa: ida,rname: name,sname:stname,dname: dtname,aname: cost,pname: number,sename: seatno,bsname: bseat,senname: seatno,sdate: date,stime: time,sstatus: status, )));
                     // Navigator.of(context).pushReplacementNamed('/history');
                    // navigateToDetail();
                  },
                ),
              );
              }else if(newa == 'awaiting') {
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                  elevation: 0.0,
                  color: Colors.deepOrange,
                  child: Text(
                    'Proceed',
                    style: headingWhite,
                  ),
                  onPressed: () {
                    var id = '${requestRidez.rideId}';
                    var ida = '${requestRidez.id}';
                    var name = '${requestRidez.rideName}';
                    var number = '${requestRidez.rideNumber}';
                    var seatno = '${requestRidez.seatNo}';
                    var cost = '${requestRidez.cost}';
                    var status = '${requestRidez.requestStatus}';
                    var bseat = '${requestRidez.bookedSeats}';
                    var stname = '${requestRidez.startName}';
                    var dtname = '${requestRidez.destName}';
                    var date = '${requestRidez.date}';
                    var time = '${requestRidez.time}';
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetail(id: id, idaa: ida,rname: name,sname:stname,dname: dtname,aname: cost,pname: number,sename: seatno,bsname: bseat,senname: seatno,sdate: date,stime: time,sstatus: status, )));
                     // Navigator.of(context).pushReplacementNamed('/history');
                    // navigateToDetail();
                  },
                ),
              );
              }else {
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                  elevation: 0.0,
                  color: Colors.deepOrange,
                  child: Text(
                    'Go to Pick UP',
                    style: headingWhite,
                  ),
                  onPressed: () {
                    var id = '${requestRidez.rideId}';
                    var ida = '${requestRidez.id}';
                    var name = '${requestRidez.rideName}';
                    var number = '${requestRidez.rideNumber}';
                    var seatno = '${requestRidez.seatNo}';
                    var cost = '${requestRidez.cost}';
                    var status = '${requestRidez.requestStatus}';
                    var bseat = '${requestRidez.bookedSeats}';
                    var stname = '${requestRidez.startName}';
                    var dtname = '${requestRidez.destName}';
                    var date = '${requestRidez.date}';
                    var time = '${requestRidez.time}';
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetail(id: id, idaa: ida,rname: name,sname:stname,dname: dtname,aname: cost,pname: number,sename: seatno,bsname: bseat,senname: seatno,sdate: date,stime: time,sstatus: status, )));
                     // Navigator.of(context).pushReplacementNamed('/history');
                    // navigateToDetail();
                  },
                ),
              );
              }
            }
              )
              ),
            ),
          ],
        ),
      ),
    )          
                        );
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text('No Request Found'));
            }
            //return  a circular progress indicator.
            return Center(child: new CircularProgressIndicator());
          },
        )
    )
   )
 );
  }

  // Widget historyItem() {
  //   final screenSize = MediaQuery.of(context).size;
    
  // }

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getCredential();
   }
   
   
  String id = "";

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      id = sharedPreferences.getString("id");
    });
  }

  Future<List<RequestRidez>> requestRide() async {
    String url = "https://ridezmyway.com/apiall/getalldrivereq.php?id=" + id;
    final response = await http.get(url);
    // print(url);
    return requestRidezFromJson(response.body);
  }

  
 
}
 