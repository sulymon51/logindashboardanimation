import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_dash_animation/models/walletHistorymodel.dart';
import 'package:login_dash_animation/models/walletModel.dart';
import 'package:login_dash_animation/screens/addfund.dart';
import 'package:login_dash_animation/screens/wallet-api.dart';

import 'package:http/http.dart' as http;
import 'package:login_dash_animation/screens/wallethisAPI.dart';
// import 'package:login_dash_animation/screens/wallethisApi.dart';
import 'package:login_dash_animation/screens/wallethisapii.dart';
import 'package:login_dash_animation/screens/withdrwal.dart';
import 'package:login_dash_animation/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  Future<void> fetchBal() async {
    var url = "https://ridezmyway.com/apiall/walletuser.php?idn=" + id;
    var response = await http.get(
      Uri.encodeFull(url),
    );
    var res = jsonDecode(response.body);
    var data = res['data'];
    return data;
  }

  // Future<void> fetchWallethisa() async {
  //   var url = "https://ridezmyway.com/apiall/wallet_history.php?id="+id;
  //   var response = await http.get(
  //     Uri.encodeFull(url),
  //   );
  //   var res = jsonDecode(response.body);
  //   var datah = res['data'];
  //   print(datah);
  //   print(res);
  //   return datah;
  // }

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
    fetchWallethisaa();
  }

  String name = "", phone = "", email = "", id = "",  wallet_balance = "";

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name");
      phone = sharedPreferences.getString("phone");
      email = sharedPreferences.getString("email");
      id = sharedPreferences.getString("id");
      // token = sharedPreferences.getString("token");
      wallet_balance = sharedPreferences.getString("wallet_balance");
    });

    // print(email);
   
    print(id);
    // print(wallet_balance);
  }

// // Future<void>  walletFromJson() async {
// //     String url = "https://ridezmyway.com/apiall/walletuser.php";
// //     final response = await http.get(url);
// //     return jsonDecode(response.body);
// //   }

  @override
  Widget build(BuildContext context) {
    // getCredential();

    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
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

      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 20, 0, 100),
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    )),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Wallet Balance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "NGN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FutureBuilder(
                              future: fetchBal(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Text('Loading!!!',
                                  style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                  )
                                  );
                                } else {
                                  return Text(
                                    "\₦" + snapshot.data.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF2ecc71),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Text(
                                "Online",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(16),
                  //   gradient: LinearGradient(
                  //     colors: [
                  //       Colors.deepOrange,
                  //       Colors.deepOrange,
                  //     ],
                  //   ),
                  // ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton.icon(
                        onPressed: () =>
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => AddfundPage())),
                        icon: Icon(
                          FontAwesomeIcons.levelUpAlt,
                          color: Colors.deepOrange,
                        ),
                        label: Text("Add Money"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: RaisedButton.icon(
                        onPressed: () =>
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => Withdraw())),
                        icon: Icon(
                          FontAwesomeIcons.levelDownAlt,
                          color: Color(0xFF2ecc71),
                        ),
                        label: Text("Withdral"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                alignment: Alignment.topLeft,
                child: Text(
                  "Wallet History",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10,),
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                  

                    // SizedBox(height: 10,),
              FutureBuilder(
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
            ),

                    
//  FutureBuilder<List>(
//                       future: getData(),
//                       builder: (ctx, ss) {
//                         if (ss.hasError) {
//                           print("erorr");
//                         }
//                         if (ss.hasData) {
//                           return Center(child: Items(list: ss.data));
//                         } else {
//                           return CircularProgressIndicator();
//                         }
//                       },
//                     ),
                  ],
                ),
              ),


              SizedBox(height: 100,),
            ],
          ),
        ),
      ),

      //
    );
  }
}

class Items extends StatelessWidget {
  List list;
  Items({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          return    Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          FontAwesomeIcons.bitcoin,
                          color: Colors.deepOrange,
                        ),
                      ),
                      title: Text(list[i]['details']),
                      trailing: Text(list[i]['amount']),
                    ),
                  ),
                );  
        });
  }
}
