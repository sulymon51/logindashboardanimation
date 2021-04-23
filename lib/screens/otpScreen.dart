import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';
import 'package:login_dash_animation/screens/signupScreen.dart';

import 'loginScreen.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
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
                alignment: Alignment.topCenter
              )
            ),
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
                            icon: Icon(Icons.arrow_back, color: Colors.white,size:32),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Icon(Icons.slow_motion_video, color: Colors.white,size: 0),
                              Text("", style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                              )),
                              Text("", style: TextStyle(
                                color: Colors.white,
                                fontSize: 12
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40,vertical: 50),
                    height: MediaQuery.of(context).size.height * 0.70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("OTP",style: TextStyle(
                          color: Color(0xFFF032f42),
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        )),
                        Text("Enter your One Time Password",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25
                        )),
                        SizedBox(height: 40),
                        CustomTextField(
                          label: "Entre otp code",
                        ),
                        SizedBox(height: 10),
                        ButtonLoginAnimation(
                          label: "Continue",
                          fontColor: Colors.white,
                          background: Colors.deepOrange,
                          borderColor: Color(0xFFF1a7a8c),
                          child: SignupScreen(),
                        )
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
  }
}