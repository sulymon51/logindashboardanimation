import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_dash_animation/History/history.dart';
import 'package:login_dash_animation/components/ink_well_custom.dart';
import 'package:login_dash_animation/screens/History/history_screen.dart';
import 'package:login_dash_animation/screens/Message/MessageScreen.dart';
import 'package:login_dash_animation/screens/driver/Request/request.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/walletScreen.dart';
import 'package:login_dash_animation/theme/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:http/http.dart' as http;

class PayDetail extends StatefulWidget {
 final String id;
 final String idaa;
 final String idab;
 final String rname;
 final String sname;
 final String dname;
 final String aname;
 final String pname;
 final String sename;
 final String bsname;
 final String senname;
 final String sdate;
 final String stime;
 final String sstatus;


 PayDetail({this.id, this.idaa, this.idab,
 this.rname , 
 this.sname, 
 this.dname, 
 this.aname, 
 this.pname,
 this.sename,
 this.bsname,
 this.senname,
 this.sdate,
 this.stime,
 this.sstatus,
 });

  @override
  _PayDetailState createState() => _PayDetailState();
}

class _PayDetailState extends State<PayDetail> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String yourReview;
  double ratingScore;
    // For CircularProgressIndicator.
  bool visible = false;
  bool _isLoading = false;

// Widget _buildChild() {
//   if (sstatus=="pending") {
//     return ...
//   }
//   return ...
// }
Future navigateToStt() async {
     // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
      _isLoading = false;
    });

   String idas= '${widget.idaa}';
   String status = '${widget.sstatus}';
    var url = 'https://ridezmyway.com/apiall/updateridapi2.php';
    final response = await http.post(url, body: {
      "rideid": idas,
      "status": status,
      "statusa": "start",
    });
        final data = jsonDecode(response.body);
        print(data);
        int value = data['value'];
        String message = data['message'];

         registerToast(String toast) {
        return Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.green[900],
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
  }

Future navigateToPay() async {
     // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
      _isLoading = false;
    });

   String id= '${widget.idaa}';
   String status = '${widget.sstatus}';
   String cost = '${widget.aname}';
   String drivid = '${widget.id}';
   String riderid = '${widget.idab}';
  //  print(id);
  //   print(status);
  //    print(cost);
  //     print(drivid);
  //     print(riderid);
    var url = 'https://ridezmyway.com/apiall/payfortrip.php';
    final response = await http.post(url, body: {
      "rideid": id,
      "status": status,
      "cost": cost,
      "driverid": drivid,
      "riderid": riderid,
      "statusa": "complete",
    });
        final data = jsonDecode(response.body);
        print(data);
        int value = data['value'];
        String message = data['message'];
         registerToast(String toast) {
        return Fluttertoast.showToast(
          msg: toast,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.green[900],
          textColor: Colors.white);
    }
          if (value == 1) {
            setState(() {
              Navigator.pushReplacement(
                context,
                new MaterialPageRoute(builder: (context) => new WalletPage()),
              );
            });
            print(message);
            registerToast(message);
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(builder: (context) => new WalletPage()),
            );
          } else if (value == 2) {
            print(message);
            registerToast(message);
          } else {
            print(message);
            registerToast(message);
          }

          print(message);
  }

  


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Payment', style: TextStyle(color: Colors.deepOrange),
        ),
        backgroundColor: whiteColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.deepOrange),
      ),
      
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 10.0,right: 10.0),
        child: 
        Builder(
            builder: (context) {
              var newa = '${widget.sstatus}';
              var ida = '${widget.idaa}';
              print(newa);
              print(ida);
             
              if (newa == 'pending') {
                return  ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton( 
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                  elevation: 0.0,
                  color: Colors.deepOrange,
                  child: Text('waiting for driver'.toUpperCase(),style: headingWhite,
                  ),
                  onPressed: (){
                    // navigateToDetail();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PickUp()));
                  },
                ),
              );
              } else if(newa == 'awaiting'){
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton( 
                  // shape: RoundedRectangleBorder(),
                  elevation: 0.0,
                  color: Colors.grey,
                  child: Text('Driver is on is Way'.toUpperCase(),style: headingWhite,
                  ),
                  onPressed: (){
                    // navigateToPay();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PickUp()));
                  },
                ),
              );
              }
              else if(newa == 'progress'){
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton( 
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                  elevation: 0.0,
                  color: Colors.greenAccent,
                  child: Text('Driver is on is Way'.toUpperCase(),style: headingWhite,
                  ),
                  onPressed: (){
                    // navigateToPay();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PickUp()));
                  },
                ),
              );
              }else if(newa == 'arrived'){
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton( 
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                  elevation: 0.0,
                  color: Colors.deepOrange,
                  child: Text('Start Trip'.toUpperCase(),style: headingWhite,
                  ),
                  onPressed: (){
                    navigateToStt();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PickUp()));
                  },
                ),
              );
              }else if(newa == 'trip started'){
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton( 
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                  elevation: 0.0,
                  color: Colors.deepOrange,
                  child: Text('Trip in Progress'.toUpperCase(),style: headingWhite,
                  ),
                  onPressed: (){
                    // navigateToStta();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PickUp()));trip Successful
                  },
                ),
              );
              }
              else if(newa == 'trip Successful'){
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton( 
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                  elevation: 0.0,
                  color: Colors.deepOrange,
                  child: Text('pay now'.toUpperCase(),style: headingWhite,
                  ),
                  onPressed: (){
                    navigateToPay();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PickUp()));
                  },
                ),
              );
              }
              else if(newa == 'complete'){
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton( 
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                  elevation: 0.0,
                  color: Colors.grey,
                  child: Text('Completed'.toUpperCase(),style: headingWhite,
                  ),
                  onPressed: (){
                    // navigateToPay();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PickUp()));
                  },
                ),
              );
              }
              else{
                return ButtonTheme(
                minWidth: screenSize.width ,
                height: 45.0,
                child: 
                RaisedButton( 
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                  elevation: 0.0,
                  color: Colors.grey,
                  child: Text('Trip Done'.toUpperCase(),style: headingWhite,
                  ),
                  onPressed: (){
                    // navigateToPay();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PickUp()));
                  },
                ),
              );
              }
            }
          )
        
       
      ),
      body: SingleChildScrollView(
        child: InkWellCustom(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            color: greyColor,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: CachedNetworkImage(
                            imageUrl: 'https://source.unsplash.com/1600x900/?portrait',
                            fit: BoxFit.cover,
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${widget.rname}',style: textBoldBlack,),
                            Text('${widget.sdate}'+ '${widget.stime}', style: textGrey,),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 25.0,
                                    padding: EdgeInsets.all(5.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.deepOrange
                                    ),
                                    child: Text('WalletPay',style: textBoldWhite,),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 25.0,
                                    padding: EdgeInsets.all(5.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.deepOrange
                                    ),
                                    child: Text('${widget.sstatus}',style: textBoldWhite,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("\₦" '${widget.aname}',style: textBoldBlack,),
                            Text("Seat No"'${widget.senname}' ,style: textGrey,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: whiteColor,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("PICK UP".toUpperCase(),style: textGreyBold,),
                              Text('${widget.sname}',style: textStyle,),

                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("DROP OFF".toUpperCase(),style: textGreyBold,),
                              Text('${widget.dname}',style: textStyle,),

                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
                  padding: EdgeInsets.all(10),
                  color: whiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Bill Details (Wallet Payment)".toUpperCase(), style: textGreyBold,),
                      Container(
                        padding: EdgeInsets.only(top: 8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("Ride Fare", style: textStyle,),
                            new Text("\₦" '${widget.aname}', style: textBoldBlack,),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("Taxes", style: textStyle,),
                            new Text("\₦ 0", style: textBoldBlack,),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("Discount", style: textStyle,),
                            new Text("- \₦ 0", style: textBoldBlack,),
                          ],
                        ),
                      ),
                      Container(
                        width: screenSize.width - 50.0,
                        height: 1.0,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("Total Bill", style: heading18Black,),
                            new Text("\₦"'${widget.aname}', style: heading18Black,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: whiteColor,
                  padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                           UrlLauncher.launch("tel://"+'${widget.pname}');
                        },
                        child: Container(
                          height: 60,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.call,color: whiteColor,),
                              Text('Call',style: TextStyle(fontSize: 18,color: whiteColor,fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          print('ok');
                          Navigator.of(context).push(new MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                                return ChatScreen();
                              },
                              fullscreenDialog: true));

                        },
                        child: Container(
                          height: 60,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.mail,color: whiteColor,),
                              Text('Chat Now',style: TextStyle(fontSize: 18,color: whiteColor,fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          print('ok');
                        },
                        child: Container(
                          height: 60,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: greyColor2,
                              borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.delete,color: whiteColor,),
                              Text('Cancel',style: TextStyle(fontSize: 18,color: whiteColor,fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
