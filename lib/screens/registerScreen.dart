import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';
import 'package:login_dash_animation/screens/signupScreen.dart';

import 'loginScreen.dart';
import 'otpScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

   Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if(user != null){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SignupScreen(user: user,)
            ));
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Give the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async{
                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);

                      AuthResult result = await _auth.signInWithCredential(credential);

                      FirebaseUser user = result.user;

                      if(user != null){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SignupScreen(user: user,)
                        ));
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }

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
                        Text("Phone No",style: TextStyle(
                          color: Color(0xFFF032f42),
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        )),
                        Text("Verify your Phone number",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25
                        )),
                        SizedBox(height: 40),
                          CustomTextField(
                          icon: Icon(Icons.phone),
                          label: "Phone",
                          hintText: "+234",
                          isControll: _phoneController,
                          iskeyboardType: TextInputType.phone,
                        ),
                        
                        SizedBox(height: 10),
                         Container(
                        width: double.infinity,
                        child: FlatButton(
                          child: Text("Verify Now"),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(16),
                          onPressed: () {
                            final phone = _phoneController.text.trim();
                            loginUser(phone, context);
                          },
                          color: Colors.deepOrange,
                        ),
                      ),
                        // ButtonLoginAnimation(
                        //   label: "Verify Now",
                        //   fontColor: Colors.white,
                        //   background: Colors.deepOrange,
                        //   borderColor: Color(0xFFF1a7a8c),
                        //   onPressed: () {
                        //     final phone = _phoneController.text.trim();
                        //     loginUser(phone, context);
                        //   },
                        //   // child: OtpScreen(),

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
  }
}