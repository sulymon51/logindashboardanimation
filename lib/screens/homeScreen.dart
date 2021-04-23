import 'package:flutter/material.dart';
import 'package:login_dash_animation/animations/fadeAnimation.dart';
import 'package:login_dash_animation/components/customButton.dart';
import 'package:login_dash_animation/components/customButtonAnimation.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/main_screen.dart';
import 'package:login_dash_animation/screens/registerScreen.dart';
import 'package:login_dash_animation/screens/welcomeScreen.dart';
import 'package:login_dash_animation/src/scoped-model/allride_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {

final AllrideModel allrideModel;
   HomeScreen({this.allrideModel});


  @override
  _HomeScreenState createState() => _HomeScreenState();
}
  enum LoginStatus { notSignIn, signIn }

class _HomeScreenState extends State<HomeScreen> {

  LoginStatus _loginStatus = LoginStatus.notSignIn;


 SharedPreferences sharedPreferences;

  String name = "", phone = "", email = "", type = "";
  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString("name");
       phone= sharedPreferences.getString("phone");
      email= sharedPreferences.getString("email");
      type= sharedPreferences.getString("type");
    });
  }




  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCredential();
  }

  @override
  Widget build(BuildContext context) {
    if(email==null){
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/images/home.jpg", fit: BoxFit.cover),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFF001117).withOpacity(0.7),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            margin: EdgeInsets.only(top: 80, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  FadeAnimation(2.4,Text("#Enjoy the Ride", style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 2
                ))),
                FadeAnimation(2.6,Text("RidezMyway", style: TextStyle(
                  color: Colors.orange,
                  fontSize: 50,
                  fontWeight: FontWeight.bold
                ))),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(3.2,CustomButtonAnimation(
                      label: "Sign up",
                      backbround: Colors.brown,
                      borderColor: Colors.white,
                      fontColor: Color(0xFFF001117),
                      child: RegisterScreen(),
                    )),
                    SizedBox(height: 20),
                    FadeAnimation(3.2,CustomButtonAnimation(
                      label: "Sign In",
                      backbround: Colors.deepOrange,
                      borderColor: Colors.white,
                      fontColor: Color(0xFFF001117),
                      child: LoginScreen(),
                    )),
                    SizedBox(height: 30),
                    FadeAnimation(3.4,Text("Forgot password", style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 17,
                      decoration: TextDecoration.underline
                    )))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
    }else{
       if(type == 'driver'){
         return MainScreen();
   
    }else{
       return WelcomScreen();
    }
      // return WelcomScreen();
    }
    }
  }
