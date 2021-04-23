import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:login_dash_animation/widgets/app.dart';
import 'package:workmanager/workmanager.dart';


void main(){

  
  // needed if you intend to initialize in the `main` function 
  WidgetsFlutterBinding.ensureInitialized(); 
  Workmanager.initialize( 
      
      // The top level function, aka callbackDispatcher 
      callbackDispatcher, 
      
      // If enabled it will post a notification whenever 
      // the task is running. Handy for debugging tasks 
      isInDebugMode: false
  ); 
  // Periodic task registration 
  Workmanager.registerPeriodicTask( 
    "5", 
      
    //This is the value that will be 
    // returned in the callbackDispatcher 
    "simplePeriodicTask", 
      
    // When no frequency is provided 
    // the default 15 minutes is set. 
    // Minimum frequency is 15 min. 
    // Android will automatically change 
    // your frequency to 15 min 
    // if you have configured a lower frequency. 
    frequency: Duration(minutes: 5), 
  ); 

  runApp(App());
}
void callbackDispatcher() { 
  Workmanager.executeTask((task, inputData) { 
      
    // initialise the plugin of flutterlocalnotifications. 
    FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin(); 

    var android = new AndroidInitializationSettings('@mipmap/ic_launcher'); 
    var IOS = new IOSInitializationSettings(); 
      
    // initialise settings for both Android and iOS device. 
    var settings = new InitializationSettings(android, IOS); 
    flip.initialize(settings); 
    _showNotificationWithDefaultSound(flip); 
    return Future.value(true); 
  }); 
} 
  
Future _showNotificationWithDefaultSound(flip) async { 
    
  // Show a notification after every 15 minute with the first 
  // appearance happening a minute after invoking the method 
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails( 
      'your channel id', 
      'your channel name', 
      'your channel description', 
      importance: Importance.Max, 
      priority: Priority.High 
  ); 
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails(); 
    
  // initialise channel platform for both Android and iOS device. 
  var platformChannelSpecifics = new NotificationDetails( 
      androidPlatformChannelSpecifics, 
      iOSPlatformChannelSpecifics 
  ); 
  await flip.show(0, 'RIDEZMYWAY', 
    'Your are one step away to connect with RIDEZMY WAY', 
    platformChannelSpecifics, payload: 'Default_Sound'
  ); 
} 
  