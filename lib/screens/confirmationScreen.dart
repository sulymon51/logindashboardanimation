  
  
import 'package:login_dash_animation/screens/main_screen.dart';
import 'package:login_dash_animation/screens/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:login_dash_animation/screens/ProfileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationWidget extends StatefulWidget {
  @override
  _ConfirmationWidgetState createState() => _ConfirmationWidgetState();
}

class _ConfirmationWidgetState extends State<ConfirmationWidget> {
      final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


        
  SharedPreferences sharedPreferences;

  String name = "", phone = "", email = "",  type = "";


  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString("name");
      email= sharedPreferences.getString("email");
      phone= sharedPreferences.getString("phone");
      type= sharedPreferences.getString("type");
    });
  //  print(email);            

  //  print(name);

  
 
}

  @override
  Widget build(BuildContext context) {
    getCredential();

    if(type == 'driver'){
    Navigator.push(
            context, new MaterialPageRoute(builder: (context) => MainScreen()));
    }else{
      Navigator.push(
            context, new MaterialPageRoute(builder: (context) => WelcomScreen()));
    }
      
      
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF1f94aa).withOpacity(0.5),
            blurRadius: 5
          )
        ]
      ),
      child: Row(
        
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Hi,' + name, style: TextStyle(
              color: Color(0xFFF2c4e5e),
            )),
          // Icon(Icons.menu, color: Color(0xFFF2c4e5e),size: 30),
        
        ],
      ),
    );

   
  }


  
  }


