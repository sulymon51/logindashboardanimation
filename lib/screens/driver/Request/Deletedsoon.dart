import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//this is the name given to the background fetch
const simplePeriodicTask = "simplePeriodicTask";
// flutter local notification setup
void showNotification( v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High, importance: Importance.Max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);
  await flp.show(0, 'Virtual intelligent solution', '$v', platform,
      payload: 'VIS \n $v');
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher, isInDebugMode: true); //to true if still in testing lev turn it to false whenever you are launching the app
  await Workmanager.registerPeriodicTask("5", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(seconds: 15),//when should it check the link
      initialDelay: Duration(seconds: 5),//duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  // runApp(DAPMyApp());
}

 void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {

    // FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    // var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOS = IOSInitializationSettings();
    // var initSetttings = InitializationSettings(android, iOS);
    // flp.initialize(initSetttings);
    FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin(); 
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher'); 
    var IOS = new IOSInitializationSettings(); 
    var settings = new InitializationSettings(android, IOS); 
    flip.initialize(settings); 
    // _showNotificationWithDefaultSound(flip); 
    // return Future.value(true); 
      var response= await http.post('https://ridezmyway.com/apiall/getnotify.php');
   
   final data = jsonDecode(response.body);
     var msg = data['message'];
     var status = data['status'];
        print(status);
        print(msg);
    var convert = json.decode(response.body);
      if (status == true) {
        showNotification(convert['msg'], flip);
      } else {
      print("no messgae");
      }
  //  var response= await http.post('http://ridezmyway.com/apiall/updateridapi1.php');
  //  print("here================");
  //  print(response);
  //   var convert = json.decode(response.body);
  //     if (convert['status']  == true) {
  //       showNotification(convert['msg'], flip);
  //     } else {
  //     print("no messgae");
  //     }


    return Future.value(true);
  });
}

//  Future now() async {
//       var response= await http.post('https://ridezmyway.com/apiall/getnotify.php');
   
//    final data = jsonDecode(response.body);
//      var msg = data['message'];
//      var status = data['status'];
//         print(status);
//         print(msg);
//     var convert = json.decode(response.body);
//       if (status == true) {
//         showNotification(convert['msg'], msg);
//       } else {
//       print("no messgae");
//       }
//  }

class DAPMyApp extends StatefulWidget {
  DAPMyApp();

  @override
  _DAPMyAppState createState() => _DAPMyAppState();
}

class _DAPMyAppState extends State<DAPMyApp> {
  @override
  Widget build(BuildContext context) {
    // now();
    return MaterialApp(
      title: 'Flutter notification',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold( 
        appBar: AppBar(
          title: Text("Testing push notification")
          ,
          centerTitle: true,
          ),
              body: Align(
                alignment: Alignment.center,
                              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
       child: Text("Flutter push notification without firebase with background fetch feature")
        
        ),
                  ),
                  
                ),
               
              )
        ));
  }
}
