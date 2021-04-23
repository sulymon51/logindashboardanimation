import 'package:flutter/material.dart';
// import 'package:login_dash_animation/screens/profileimgScreen.dart';
import 'dart:ui' as ui;

import 'package:login_dash_animation/screens/walletScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferralPage extends StatefulWidget {
  @override
  _ReferralPageState createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  @override
  SharedPreferences sharedPreferences;

  String name = "", phone = "", email = "", ref = "";

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString("name");
      phone = sharedPreferences.getString("phone");
      email = sharedPreferences.getString("email");
      ref = sharedPreferences.getString("ref");
    });
  }

  Widget build(BuildContext context) {
    getCredential();
    return Scaffold(
        appBar: AppBar(),
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/2.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: new AssetImage('assets/images/t.png'),
                        fit: BoxFit.fill,
                      ),
                      // shape: BoxShape.rectangle,
                      // border:
                      //     Border.all(width: 3.0, color: const Color(0xFFFFFFFF))
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 180,
                ),
                Center(
                  child: Text(
                    "Referral Code",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("$ref",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      height: 420.0,
                    ),
                    // FlatButton(
                    //   color: Colors.white70,
                    //   onPressed: () {
                    //     print("About me");
                    //   },
                    //   child: Text("About me"),
                    // )
                  ],
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      height: 420.0,
                    ),
                    // FlatButton(
                    //   color: Colors.white70,
                    //   onPressed: () {
                    //     print("Portfolio");
                    //   },
                    //   child: Text("Portfolio"),
                    // )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // children: <Widget>[
              //   SizedBox(
              //     height: 600.0,
              //   ),
              //   new Text(
              //       "Long text 1 Long text 1 Long text 1 Long text 1 Long text 1 Long text 1 Long text 1 Long text 1 Long text 1 Long text 1 Long text 1 Long text 1 Long text 1 Long text 1 ",
              //       textAlign: TextAlign.left),
              //   new Text(
              //       "Long Text 2, Long Text 2, Long Text 2, Long Text 2, Long Text 2, Long Text 2, Long Text 2, Long Text 2, Long Text 2, Long Text 2, Long Text 2",
              //       textAlign: TextAlign.left),
              // ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    height: 70.0,
                  ),
                  // FloatingActionButton(
                  //   backgroundColor: Colors.teal[900],
                  //   elevation: 0,
                  //   child: Icon(Icons.phone),
                  //   onPressed: () => {},
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 400.0,
                    height: 570.0,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.deepOrange[900],
                    elevation: 0,
                    child: Icon(Icons.share),
                    //   onPressed:  () => Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //     builder: (context) =>
                    //         ProfimgScreen())),
                  ),
                ],
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 140.0,
                      height: 670.0,
                    ),
                    // FloatingActionButton(
                    //   backgroundColor: Colors.teal[900],
                    //   elevation: 0,
                    //   child: Icon(Icons.email),
                    //   onPressed: () => {},
                    // ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
