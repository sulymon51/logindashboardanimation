import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_dash_animation/screens/driver/pages/book_taxi_page.dart';
import 'package:login_dash_animation/screens/driver/utils/styles.dart';
import 'package:login_dash_animation/screens/driver/widgets/header_widget.dart';
import 'package:login_dash_animation/screens/main_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Awaitingverify extends StatefulWidget {
  // static final routeName = "otp-page";
  @override
  _AwaitingverifyState createState() => _AwaitingverifyState();
}

class _AwaitingverifyState extends State<Awaitingverify> {
  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    // if(dvstatus == 'no'){
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        title: Text("Verified"),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.bell),
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
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              HeaderWidget(height: mQ.height * 0.5),
              Positioned(
                top: 20.0,
                left: 0.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(BookPage.routeName);
                  },
                  color: Colors.white,
                  textColor: Colors.deepOrange,
                  // child: Icon(
                  //   Icons.arrow_back,
                  //   size: 15,
                  // ),
                  padding: EdgeInsets.all(6),
                  shape: CircleBorder(),
                ),
              )
            ],
          ),
          SizedBox(
            height: mQ.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text("Waiting Verification ", style: CustomStyles.smallTextStyle),
                SizedBox(height: mQ.height * 0.01),
                Text(
                  "Documents Verification Awaiting",
                  style: CustomStyles.mediumTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            height: mQ.height * 0.05,
          ),
        
          
        ],
      ),
    );
    //  }else{
       
    //      return MainScreen();
   
    // }
  }

   SharedPreferences sharedPreferences;

  String name = "", phone = "", email = "", id="", profilepic="", dvype = "", dvstatus="";

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
       name = sharedPreferences.getString("name");
       phone= sharedPreferences.getString("phone");
       email= sharedPreferences.getString("email");
       profilepic= sharedPreferences.getString("profilepic");
       dvype = sharedPreferences.getString("dvype");
       dvstatus = sharedPreferences.getString("dvstatus");
       id= sharedPreferences.getString("id");

    });

        // print(dvype);

  }
  
}
