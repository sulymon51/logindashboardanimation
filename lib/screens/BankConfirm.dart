import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:login_dash_animation/screens/BankDetails.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BankEntered extends StatefulWidget {
  static String tag = 'BankEntered';
  @override
  _BankEnteredState createState() => _BankEnteredState();
}

class _BankEnteredState extends State<BankEntered> {
  
    double screenWidth, screenHeight;
    Future<List<Message>> fetchUserBankDetails() async {
    
    var webAddress = "https://savests.com/htghbxviopnhg89512/p548nfubdbh/ndbzxgsdn589241/ncfvgbhjkestapis-xcvb/getbankdetails.php?pfbkf="+username;
    var response = await http.get(Uri.encodeFull(webAddress),);
    var res = jsonDecode(response.body);

    List<Message> messages = [];

    for(var u in res){
      Message message = Message(u["bankname"], u["accountname"],  u["accountno"]);
      messages.add(message);
      // print(message.accountno);
    }
    //print(messages.length);
    return messages;

  }



  final Color backgroundColor = Colors.white;
  final Color iconColor = Colors.blue;
  final Color textColor = Colors.black;

  DateTime date1;


  TabController tabController;

    String email = "", name = "",  username = "", id = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      email = preferences.getString("email");
      name = preferences.getString("name");
      username = preferences.getString("username");
//      bonus = preferences.getString("bonus");
    });
    print(id);
  }

  @override
  void initState() {
      getPref();
    super.initState();
    getPref();
  }



  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    if (email == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
      appBar: AppBar(backgroundColor: Colors.white,),
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
                                 style: TextStyle(fontSize: 18, color: Colors.deepOrange),
                                )
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
                                     onPressed: () {
                                        Navigator.of(context).pushNamed(BankDetail.tag);
                                      },
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
                      child: Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 0.3 * screenHeight),
                               Container(
                                 padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                                 child: AutoSizeText(
                                    'You have already registered a bank account to your With us, account with the details below',
                                    style: TextStyle(fontSize: 10,),
                                  ),
                               ),
                                ListTile(
                                leading:Icon(Icons.account_balance, color: Colors.deepOrange),
                                title: Text(snapshot.data[index].bankname, style: TextStyle(color: Colors.deepOrange),),
                                subtitle: Text(snapshot.data[index].accountname, style: TextStyle(color: Colors.deepOrange),),
                                ),
                            ],
                          ),
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


       bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 70.0,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Icon(Icons.person,),
              // Icon(Icons.link,),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.white,
      child: Icon(Icons.home, color: Colors.blueAccent,),
      onPressed: () {
         Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => new LoginScreen()),
          );
      },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

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

