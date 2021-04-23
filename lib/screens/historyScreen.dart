import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_dash_animation/models/walletHistorymodel.dart';
import 'package:login_dash_animation/screens/wallethisAPI.dart';
import 'package:login_dash_animation/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) 
  : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Future<List<Wa lletHIstory>> fetchWallethisaa() async {
  //   String url = "https://ridezmyway.com/apiall/wallet_history.php?id=" + id;
  //   final response = await http.get(url);
  //   return walletHIstoryFromJson(response.body);
  // }

  Future<List> getData() async {
    String url = "https://ridezmyway.com/apiall/wallet_history.php?id=" + id;
    final response = await http.get(url);
    return json.decode(response.body);
  }
  Future<List<RiderhisTory>> fetchWallethisaa() async {
    String url = "https://ridezmyway.com/apiall/wallet_history.php?id=" + id;
    final response = await http.get(url);
    // print(response);
    return riderhisToryFromJson(response.body);
  }

  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    getCredential();
  }

  String name = "", phone = "", email = "", id = "", wallet_balance = "";
  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name");
      phone = sharedPreferences.getString("phone");
      email = sharedPreferences.getString("email");
      id = sharedPreferences.getString("id");
      wallet_balance = sharedPreferences.getString("wallet_balance");
    });

    // print(email);
    // print(name);
    print(id);
    // print(wallet_balance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(" Wallet & Payments History"),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.history),
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
      body:  FutureBuilder(
              future: fetchWallethisaa(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      controller: ScrollController(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        RiderhisTory riderhisTory = snapshot.data[index];
                        return  Container(
                          child: Builder(
                                  builder: (context) {
                                    var newa = '${riderhisTory.bal}';
                                    // print(newa);
                                    if (newa == 'cr') {
                                      return   Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xffecf0f1),
                                            child: Icon(FontAwesomeIcons.moneyBill, color: Color(0xff2ecc71),),
                                          ),
                                          title: Text("${riderhisTory.details}",style: TextStyle(color: Color(0xff2ecc71)),),
                                          trailing: Text("\₦"+'${riderhisTory.amount}', style: TextStyle(color: Color(0xff2ecc71)),),
                                      ),
                                    );
                                   }else{
                                      return   Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xffecf0f1),
                                            child: Icon(FontAwesomeIcons.moneyBill, color: Colors.red[600],),
                                          ),
                                          title: Text("${riderhisTory.details}", style: TextStyle(color: redColor), ),
                                          trailing: Text("\- ₦"+'${riderhisTory.amount}',style: TextStyle(color: redColor),),
                                      ),
                                    );
                                  }
                                  })
                          
                    //        Card(
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: ListTile(
                    //       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    //       leading: CircleAvatar(
                    //         backgroundColor: Color(0xffecf0f1),
                    //         child: Icon(FontAwesomeIcons.creditCard, color: Color(0xff2ecc71),),
                    //       ),
                    //       title: Text("${riderhisTory.details}"),
                    //       trailing: Text("\₦"+'${riderhisTory.amount}'),
                    //   ),
                    // ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text('No History Yet');
                }
                //return  a circular progress indicator.
                return Center(child: new CircularProgressIndicator());
              },
            )
            );
  }
}
