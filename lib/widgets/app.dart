import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:login_dash_animation/Constant/Constant.dart';
import 'package:login_dash_animation/screens/SplashScreen.dart';
import 'package:login_dash_animation/screens/homeScreen.dart';
import 'package:login_dash_animation/screens/main_screen.dart';
import 'package:login_dash_animation/screens/welcomeScreen.dart';
import 'package:login_dash_animation/src/scoped-model/allride_model.dart';
import 'package:scoped_model/scoped_model.dart';

class App extends StatelessWidget {
      final AllrideModel allrideModel = AllrideModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AllrideModel>(
      model: allrideModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Ridezmyway",
        theme: ThemeData(primarySwatch: Colors.deepOrange,),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
      // SPLASH_SCREEN: (BuildContext context) => new MapScreen(),
      PROFILE: (BuildContext context) => new HomeScreen(),
    },
      ),
    );
  }
  
}
class HomeConnect extends StatefulWidget {
  @override
  _HomeConnectState createState() => _HomeConnectState();
}
class _HomeConnectState extends State<HomeConnect> {
  var wifiBSSID;
  var wifiIP;
  var wifiName;
  bool iswificonnected = false;
  bool isInternetOn = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetConnect(); // calls getconnect method to check which type if connection it 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Connectivity..."),
      ),
      body: isInternetOn
          ? iswificonnected ? ShowWifi() : ShowMobile()
          : buildAlertDialog(),
    );
  }
  AlertDialog buildAlertDialog() {
    return AlertDialog(
      title: Text(
        "You are not Connected to Internet",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }
  Center ShowWifi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              " Your are connected to ${iswificonnected ? "WIFI" : "MOBILE DATA"}"),
          Text(iswificonnected ? "$wifiBSSID" : "Not Wifi"),
          Text("$wifiIP"),
          Text("$wifiName")
        ],
      ),
    );
  }
  Center ShowMobile() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(" Your are Connected to  MOBILE DATA"),
        ],
      ),
    );
  }
  void GetConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetOn = false;
      });
    } else if (connectivityResult == ConnectivityResult.mobile) {
     
      iswificonnected = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      
      iswificonnected = true;
      setState(() async {
        wifiBSSID = await (Connectivity().getWifiBSSID());
        wifiIP = await (Connectivity().getWifiIP());
        wifiName = await (Connectivity().getWifiName());
      });
   
    }
  }
}
