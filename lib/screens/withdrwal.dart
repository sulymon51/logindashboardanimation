import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_dash_animation/screens/BankConfirm.dart';
import 'package:login_dash_animation/screens/BankDetails.dart';
import 'package:login_dash_animation/screens/historyScreen.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/myridesScreen.dart';
// import 'package:savests/dashboard.dart' as prefix0;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:http/http.dart' as http;

final Color themeColor = Colors.deepOrange;
final Color backgroundColor = Colors.white;


class Withdraw extends StatefulWidget {
  static String tag = 'Withdraw';
  @override
  _Withdraw createState() => _Withdraw();
}

class _Withdraw extends State<Withdraw> {

    double screenWidth, screenHeight;
    Future<List<Message>> fetchUserBankDetails() async {
    
    var webAddress = "https://ridezmyway.com/apiall/getaccdetails.php?bkf="+id;
    var response = await http.get(Uri.encodeFull(webAddress),);
    var res = jsonDecode(response.body);

    List<Message> messages = [];

    for(var u in res){
      Message message = Message(u["bank_name"], u["acc_name"],  u["acc_no"]);
      messages.add(message);
      print(message.accountno);
    }
    //print(messages.length);
    return messages;

  }



  final Color backgroundColor = Colors.white;
  final Color iconColor = Colors.deepOrange;
  final Color textColor = Colors.black;

  DateTime date1;

  String plann = '', amountt = '', maturityy = '', freq = '';
  String email = "", name = "",  username = "", id = "";
bool visible = false;

  bool _isLoading = false;

  TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      email = preferences.getString("email");
      name = preferences.getString("name");
   
    });
  }

  Future<void> fetchSaveCurrentBal() async {
    var webAddress = "https://ridezmyway.com/apiall/currentbal.php?pfbkf="+id;
    var response = await http.get(Uri.encodeFull(webAddress),);
    var res = jsonDecode(response.body);
    var curr = res['data'];
    return curr;
  }
Future withDrawalr() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
      _isLoading = false;
    });

    // Getting value from Controller
    // String from = fromController.text;
    // String from = fromController.text;

    print(id);
    // SERVER API URL
    var url = 'https://ridezmyway.com/apiall/withdrawalapi.php';

    final response = await http.post(url, body: {
      // "flag": 1.toString(),
      "id": id,
      "amount": amountt,
      "accno": name,
      "status": "1",

      
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
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }

    if (value == 1) {
      setState(() {
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => new HistoryPage()),
        );
      });
      print(message);
      registerToast(message);
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => new HistoryPage()),
      );
    } else if (value == 0) {
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
  void initState() {

    super.initState();
    getPref();
  }



  @override
  Widget build(BuildContext context) {
    
     Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    
    final amount = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        icon: Icon(Icons.dialpad, color: themeColor,),
        hintText: 'Amount',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
      onChanged: (String text) {
        setState(() {
          amountt = text;
        },
        );
      },
    );



    final payButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.blue.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 50.0,
          
          onPressed: () {
              withDrawalr();
            // // userid = baei || amount =  cvdnco
            //   var webAddress = "https://savests.com/moblieapp/withdraw.php?baei=" + id + "&cvdnco=" + amountt; 
            //   FocusScope.of(context).requestFocus(FocusNode());
            //   this._openInWebview(webAddress);
              },

          color: Colors.deepOrange,
          child: Text(
            'Withdraw',
           style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final amtText = FutureBuilder(
          future: fetchSaveCurrentBal(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return AutoSizeText(
                  'loading ...',
                  style: TextStyle(fontSize: 15),
                  maxLines: 1,
                );
            } else {
              return AutoSizeText(
                  'Your Wallet Balance: NGN ' + snapshot.data,
                  style: TextStyle(fontSize: 10),
                  maxLines: 1,
                );

            }
          },
        );



    
    if (email == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
        ),
        backgroundColor: Colors.white,
        body: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/dashh.png'), fit: BoxFit.cover),
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                AutoSizeText(
                  'Session Time-Out ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 48.0),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(30.0),
                    shadowColor: Colors.redAccent,
                    elevation: 5.0,
                    child: MaterialButton(
                      minWidth: 200.0,
                      height: 50.0,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LoginScreen()),
                        );
                      },
                      color: Colors.redAccent,
                      child: Text("Login Again",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      );
    } else {

          return Scaffold(
      appBar: AppBar(
        title: Text("Withdrawal"),
        
        backgroundColor: Colors.deepOrange,),
      //backgroundColor: Colors.white,
      body:  DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage('assets/dashh.png'),
              //     fit: BoxFit.cover),
            ),
            child: Container(
        child: FutureBuilder(
            future: fetchUserBankDetails(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text('loading...'),
                  ),
                );
               
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){

                    if(snapshot.data[index].accountno == null){
                      return  Container(
                      child: Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 0.3 * screenHeight),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text('You have not Entered your bank details yet, Click below to add',textAlign: TextAlign.center,
                                 style: TextStyle(fontSize: 18, color: themeColor),
                                )
                                ),
                                Center(
                                child: Visibility(
                                    visible: visible,
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 30),
                                        child: CircularProgressIndicator())
                                        ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(30.0),
                                  shadowColor: Colors.blue.shade100,
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    minWidth: 200.0,
                                    height: 50.0,
                                    onPressed: () =>
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => BankDetail())),
                                    color: Colors.deepOrange,
                                    child: Text(
                                      'Add Bank',
                                    style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ),
                    );
                    //return 
                      //Navigator.of(context).pushNamed(BankDetail.tag);
                    } else {
                       return Container(
                         
                          child: ListView(
                            
                            shrinkWrap: true,
                            padding: EdgeInsets.only(left: 24.0, right: 24.0),
                            children: <Widget>[
                              SizedBox(height: 100.0),
                              AutoSizeText(
                                'Withdraw to your bank account',
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: themeColor),
                                maxLines: 1,
                              ),
                              SizedBox(height: 10.0),
                              AutoSizeText(
                                'Note: Your request will be process on Sundays and hit your bank account within 24hours(Mondays).',
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(height: 10.0),
                              amtText,
                              SizedBox(height: 48.0),
                              amount,
                              SizedBox(height: 24.0),
                              payButton,
                            ],
                          ),
                      );
                    }        
                  },
                );          
              }
            },
          ),
        ),
      ),


      //  bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   child: Container(
      //     height: 70.0,
      //     child:
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         // Icon(Icons.person,),
      //         // Icon(Icons.link,),
      //       ],
      //     ),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      // backgroundColor: Colors.white,
      // child: Icon(Icons.home, color: Colors.blueAccent,), 
      // onPressed: () {
      //    Navigator.pushReplacement(
      //       context,
      //       new MaterialPageRoute(builder: (context) => new LoginScreen()),
      //     );
      // },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );


    }


  
  }

  Future<Null> _openInWebview(String url) async {
    if (await url_launcher.canLaunch(url)) {
      Navigator.of(context).push(
        MaterialPageRoute(

          builder: (ctx) => WebviewScaffold(
            initialChild: Center(child: CircularProgressIndicator()),
            url: url,
            appBar: AppBar(title: Text('Withdrawal Page'), backgroundColor: Colors.white,),
          //   bottomNavigationBar: BottomAppBar(
          //   shape: const CircularNotchedRectangle(),
          //   child: Container(
          //     height: 70.0,
          //     child:
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         Text(''),
          //          FlatButton(
          //           color: backgroundColor,
          //           onPressed: () => setState(
          //                 () {
          //                   Navigator.pushReplacement(context,
          //                     new MaterialPageRoute(builder: (context) => new LoginScreen()),
          //                   );
          //                 },
          //               ),
          //           child: Icon(
          //             Icons.home,
          //             color: themeColor,
          //           )
          //         ),
          //         Text(''),
          //       ],
          //     ),
          //   ),
          // ),
          ),
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Error processing payment'),
        ),
      );
    }
  }

}

class Message {

  final String accountname;
  final String bankname;
  final String accountno;

  Message(this.accountname, this.bankname, this.accountno);
}

