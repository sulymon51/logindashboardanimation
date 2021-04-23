import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/ProfileScreen.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';
import 'package:login_dash_animation/screens/homeScreen.dart';
import 'package:login_dash_animation/screens/main_screen.dart';
import 'package:login_dash_animation/screens/walletScreen.dart';
import 'package:login_dash_animation/screens/welcomeScreen.dart';
import 'package:login_dash_animation/screens/registerScreen.dart';
import 'package:login_dash_animation/src/scoped-model/allride_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  final AllrideModel allrideModel;
  LoginScreen({this.allrideModel});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginScreenState extends State<LoginScreen> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token1;

  // For CircularProgressIndicator.
  bool visible = false;
  bool _isLoading = false;
  final _key = new GlobalKey<FormState>();
  // Getting value from TextField widget.

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future getQue() async {
   
    if(token1!=null){
      var response =await http.post("https://ridezmyway.com/apiall/notification.php",
       body: {"token": token1}
   );
   return json.decode(response.body);
      //call php file
    }
    else{
      print("Token is null");
    }
  }
 

  Future userLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
      _isLoading = false;
    });

    // Getting value from Controller
    String phone = phoneController.text;
    String password = passwordController.text;

    String rider ;
    String driver ;

    // SERVER LOGIN API URL
    var url = 'https://ridezmyway.com/apiall/login.php';

    final response = await http.post(url, body: {
      "flag": 1.toString(),
      "phone": phone,
      "password": password,
      "fcm_token": token1
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String phoneAPI = data['phone'];
    String nameAPI = data['name'];
    String emailAPI = data['email'];
    String walletbalanceAPI = data['wallet_balance'];
    String typeAPI = data['type'];
    String refAPI = data['ref'];
    String carmodelAPI = data['carmodel'];
    String carnumberAPI = data['carnumber'];
    String carcolorAPI = data['carcolor'];
    String cityAPI = data['city'];
    String driverimageAPI = data['driverimage'];
    String profilepicAPI = data['profilepic'];
    String id = data['id'];

    savePref(int value, String phone, String name, String email,
        String wallet_balance, type, ref, carmodel, carnumber, carcolor, city, driverimage, profilepic, String id) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        visible = true;
        // widget.allrideModel.fetchAllrides();
        preferences.setInt("value", value);
        preferences.setString("phone", phone);
        preferences.setString("name", name);
        preferences.setString("email", email);
        preferences.setString("wallet_balance", wallet_balance);
        preferences.setString("type", type);
        preferences.setString("ref", ref);
        preferences.setString("carmodel", carmodel);
        preferences.setString("carnumber", carnumber);
        preferences.setString("carcolor", carcolor);
        preferences.setString("city", city);
        preferences.setString("driverimage", driverimage);
        preferences.setString("profilepic", profilepic);
        preferences.setString("id", id);
        preferences.commit();
      });
    }

    

    if (value == 1) {
      showNotification();
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, phoneAPI, nameAPI, emailAPI, walletbalanceAPI, typeAPI,profilepicAPI,
            refAPI, carmodelAPI, carnumberAPI, carcolorAPI, cityAPI, driverimageAPI, id);


    if(typeAPI == 'driver'){
    Navigator.push(
            context, new MaterialPageRoute(builder: (context) => MainScreen()));
    }else{
      Navigator.push(
            context, new MaterialPageRoute(builder: (context) => WelcomScreen()));
    }
      });
      print(message);
      loginToast(message);
    
    } else {
      print("fail");
      print(message);
      loginToast(message);
    }

    // var data = {'phone': phone, 'password' : password};
    // var response = await http.post(url, body: json.encode(data));
    // var message = jsonDecode(response.body);
   
    // Navigator.push(
    //         context, new MaterialPageRoute(builder: (context) => WelcomScreen()));
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString("phone", null);
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("id", null);

      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseCloudMessaging_Listeners();
    getPref();
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
    flutterLocalNotificationsPlugin.show(0, 'Welcome Back ', 'Enjoy your Day', platform,payload: 'check you request ');
  }


  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((token){
    //  print("Token is "+token);
     token1 =token;
     print(token1);
     setState((){
       getQue();
     });

    });

    //get token of mobile device    neee to fix notification on message
  }

  @override
  Widget build(BuildContext context) {
    // switch (_loginStatus) {
    // case LoginStatus.notSignIn:
    if (_loginStatus == LoginStatus.notSignIn) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login.jpg"),
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter)),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: Colors.white, size: 32),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                                // Navigator.pop(context);
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Icon(Icons.slow_motion_video,
                                    color: Colors.white, size: 0),
                                Text("",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                Text("",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Visibility(
                          visible: visible,
                          child: Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: CircularProgressIndicator())),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                      height: MediaQuery.of(context).size.height * 0.70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Welcome",
                              style: TextStyle(
                                  color: Color(0xFFF032f42),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          Text("Sign to continue",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 25)),
                          SizedBox(height: 40),
                          CustomTextField(
                            label: "Phone",
                            iskeyboardType: TextInputType.phone,
                            isControll: phoneController,
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            isPassword: true,
                            label: "Password",
                            isControll: passwordController,
                            icon: Icon(
                              Icons.https,
                              size: 27,
                              color: Color(0xFFF032f41),
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            width: double.infinity,
                            child: FlatButton(
                              child: Text(
                                _isLoading ? 'Logining...' : 'Login',
                              ),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(16),
                              onPressed: _isLoading ? null : userLogin,
                              color: Colors.deepOrange,
                            ),
                          ),
                          SizedBox(height: 10),
                          FlatButton(
                            child: Text(
                              "OR Create Account ",
                            ),
                            textColor: Colors.deepOrange,
                            padding: EdgeInsets.all(16),
                            onPressed: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => RegisterScreen())),
                          ),
                          // ButtonLoginAnimation(

                          //   label: "Go Home ",
                          //   fontColor: Colors.white,
                          //   background: Colors.deepOrange,
                          //   borderColor: Color(0xFFF1a7a8c),
                          //   onPressed:  _isLoading ? null: userLogin,
                          //   child: DashScreen(userLogin: userLogin),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return WelcomScreen();
    }

//      break;

//       case LoginStatus.signIn:
//         return DashScreen(signOut);
// //        return ProfilePage(signOut);
//         break;
//   }
  }
}
