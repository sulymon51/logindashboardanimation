import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_dash_animation/components/buttonLoginAnimation.dart';
import 'package:login_dash_animation/components/customTextfield.dart';
import 'package:login_dash_animation/screens/api.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'homeScreen.dart';
import 'loginScreen.dart';

class SignupScreen extends StatefulWidget {
  final FirebaseUser user;

  SignupScreen({this.user});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var selectedGender, selectedType;

    String dob = '';

 DateTime date1;

//  final format = DateFormat("yyyy-MM-dd");


  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  List<String> _accountType = <String>['rider', 'driver'];

    List<String> _genderType = <String>['Male', 'Female'];


  bool visible = false;

  bool _isLoading = false;

  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController referbyController = new TextEditingController();

  

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
      _isLoading = false;
    });

    // Getting value from Controller
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String password = passwordController.text;
    String referby = referbyController.text;
    String type = selectedType;
    String gender = selectedGender;
    


    print(type);

    // SERVER API URL

    var url = 'https://ridezmyway.com/apiall/register_user.php';

    final response = await http.post(url, body: {
      // "flag": 1.toString(),
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "phone": phone,
      "type": type,
      "gender": gender,
      "password": password,
      "referby": referby,
      "fcm_token": "test_fcm_token",
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];

    registerToast(String toast) {
      return Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.deepOrange,
          textColor: Colors.white);
    }

    if (value == 1) {
      setState(() {
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new LoginScreen()),
        );
      });
      print(message);
      registerToast(message);
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => new LoginScreen()),
      );
    } else if (value == 2) {
      print(message);
      registerToast(message);
    } else {
      print(message);
      registerToast(message);
    }

    print(message);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }
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
                              Navigator.pop(context);
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
                  //   Center(
                  //   child: Text(msg, style: TextStyle(color: Colors.red)),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                    height: MediaQuery.of(context).size.height * 0.80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: ListView(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Sign Up",
                                style: TextStyle(
                                    color: Color(0xFFF032f42),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            Text("ready to join Us",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15)),
                            SizedBox(height: 40),
                            CustomTextField(
                              isonChanged: (text) {
                                print("Fist Name: $text");
                              },
                              label: "First Name",
                              isControll: firstnameController,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              isonChanged: (text) {
                                print("Last Name: $text");
                              },
                              label: "last Name",
                              isControll: lastnameController,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              iskeyboardType: TextInputType.emailAddress,
                              isonChanged: (text) {
                                print("Email: $text");
                              },
                              label: "Email",
                              isControll: emailController,
                            ),
                            SizedBox(height: 10),

                            CustomTextField(
                              iskeyboardType: TextInputType.phone,
                              isonChanged: (text) {
                                print("Phone Number: $text");
                              },
                              label: "Phone Number",
                              // hintText: "${widget.user.phoneNumber}",
                              isControll: phoneController,
                            ),
                            CustomTextField(
                              iskeyboardType: TextInputType.text,
                              isonChanged: (text) {
                                print("Referral ID: $text");
                              },
                              label: "Referral ID",
                              // hintText: "${widget.user.phoneNumber}",
                              isControll: referbyController,
                            ),
                            Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.car,
                                    size: 25.0,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(width: 50.0),
                                  DropdownButton(
                                    items: _accountType
                                        .map((value) => DropdownMenuItem(
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.deepOrange),
                                              ),
                                              value: value,

                                            ))
                                        .toList(),
                                    onChanged: (selectedAccountType) {
                                      print('$selectedAccountType');
                                      setState(() {
                                        selectedType = selectedAccountType;
                                      });
                                    },
                                    value: selectedType,
                                    isExpanded: false,
                                    hint: Text(
                                      ' Account Type',
                                      style:
                                          TextStyle(color: Colors.deepOrange),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.user,
                                    size: 25.0,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(width: 50.0),
                                  DropdownButton(
                                    items: _genderType
                                        .map((value) => DropdownMenuItem(
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.deepOrange),
                                              ),
                                              value: value,

                                            ))
                                        .toList(),
                                    onChanged: (selectedGenderType) {
                                      print('$selectedGenderType');
                                      setState(() {
                                        selectedGender = selectedGenderType;
                                      });
                                    },
                                    value: selectedGender,
                                    isExpanded: false,
                                    hint: Text(
                                      'Select Gender ',
                                      style:
                                          TextStyle(color: Colors.deepOrange),
                                    ),
                                  )
                                ],
                              ),
                            ),
                              // DateTimeField(
                              //   autofocus: false,
                              //   decoration: InputDecoration(
                              //     icon: Icon(FontAwesomeIcons.calendar,
                              //         size: 25.0,
                              //         color: Colors.deepOrange,
                              //         ),
                              //     hintText: 'Date of Birth',
                              //     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), 
                              //   ),
                              //   onShowPicker: (context, currentValue) {
                              //     return showDatePicker(
                              //         context: context,
                              //         firstDate: DateTime(1900),
                              //         initialDate: currentValue ?? DateTime.now(),
                              //         lastDate: DateTime(2100));
                              //   },
                              //   onChanged: (dt) {
                              //       setState(() => date1 = dt);
                              //       print('Selected date: $date1');
                              //   },
                              // ),
                         

                            SizedBox(height: 10),
                            CustomTextField(
                              isPassword: true,
                              isonChanged: (text) {
                                print("Password Name: $text");
                              },
                              label: "Password",
                              isControll: passwordController,
                            ),

                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              child: FlatButton(
                                child: Text(
                                  _isLoading ? 'Creating...' : 'Verify Now',
                                ),
                                textColor: Colors.white,
                                padding: EdgeInsets.all(16),
                                onPressed: _isLoading ? null : userRegistration,
                                color: Colors.deepOrange,
                              ),
                            ),
                            // SizedBox(height: 10),
                            // ButtonLoginAnimation(
                            //   label: "Continue",
                            //   fontColor: Colors.white,
                            //   background: Colors.deepOrange,
                            //   borderColor: Color(0xFFF1a7a8c),
                            //   child: LoginScreen(),
                            // )
                          ],
                        ),
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
