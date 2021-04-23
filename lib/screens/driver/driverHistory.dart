import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_dash_animation/models/driverhist.dart';
import 'package:login_dash_animation/models/rideshist.dart';
import 'package:login_dash_animation/widgets/allridesmodel.dart';
import 'package:login_dash_animation/widgets/ride_card.dart';
import 'package:http/http.dart' as http;
import 'package:login_dash_animation/widgets/ride_cards.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uberr/router.dart';
class MyRidesHis extends StatefulWidget {
  @override
  _MyRidesHisState createState() => _MyRidesHisState();
}

class _MyRidesHisState extends State<MyRidesHis> {
  @override
  Widget build(BuildContext context) {
   
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text("Rides History"),
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
      body:
     FutureBuilder(
      future: aldriezHisa(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                DriverHistory driverHistory = snapshot.data[index];
                final ThemeData _theme = Theme.of(context);
                return Container(
                  margin: EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Card(
                    elevation: 0.0,
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${driverHistory.time}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Text('${driverHistory.date}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            height: 170.0,
                            color: Colors.deepOrange,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 0.0,
                            ),
                            title: Text('${driverHistory.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.gps_fixed,
                                      color: _theme.primaryColor,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text('${driverHistory.startName}' ,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      
                                    ),
                                     Icon(
                                      Icons.pin_drop,
                                      color: _theme.primaryColor,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text('${driverHistory.destName}' ,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      
                                    )
                                  ],
                                ),
                              ],
                            ),
                            
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('${driverHistory.seats}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\₦"'${driverHistory.cost}',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: _theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        //return  a circular progress indicator.
        return Center(child: new CircularProgressIndicator());
      },
    )
      );
  
  }

  SharedPreferences sharedPreferences;

   @override
  void initState() {
    super.initState();
    getCredential();
  }

  String id = "";


  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      id= sharedPreferences.getString("id");
    });
  }

  Future<List<DriverHistory>>  aldriezHisa() async {
    String url = "https://ridezmyway.com/apiall/getalldriveh.php?id="+ id;
    final response = await http.get(url);
    // print(url);
    return driverHistoryFromJson(response.body);
  }
}