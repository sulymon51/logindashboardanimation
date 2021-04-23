import 'package:country_pickers/utils/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:login_dash_animation/chat/lets_text.dart';
import 'package:login_dash_animation/models/allrides.dart';
import 'package:login_dash_animation/src/data/allride_data.dart';
import 'package:login_dash_animation/widgets/allridesmodel.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


class SecondabScreen extends StatefulWidget {
  final SecondabScreen value;

  SecondabScreen({Key key, this.value}) : super(key: key);

  @override
  _SecondabScreenState createState() => _SecondabScreenState();
}

class _SecondabScreenState extends State<SecondabScreen> {
  @override
  Widget build(BuildContext context) {
     FutureBuilder(
              future: alridezModel(),
              builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index){
                AlridezModel alridezModel = snapshot.data[index];
                         return ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 230.0,
                            width: 340.0,
                            child: Image(
                              image: AssetImage(
                                '${alridezModel.driverImage}'
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 0.0,
                            bottom: 0.0,
                            width: 340.0,
                            height: 60.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [Colors.black, Colors.black12])),
                            ),
                          ),
                          Positioned(
                            left: 10.0,
                            bottom: 10.0,
                            right: 10.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Car Color: " +
                                      '${alridezModel.carColor}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text("Car Model: " +
                                      '${alridezModel.carModel}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text("Car Number: "+
                                     '${alridezModel.carNumber}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text("Driver Name: "+
                                     '${alridezModel.driverName}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text("Available Seat: "+
                                     '${alridezModel.seatNo}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text("From: "+ 
                                      '${alridezModel.startName}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text("|",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text("To: " + 
                                     '${alridezModel.destName}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          "(" +'${alridezModel.rating}' + " Reviews)",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      '${alridezModel.seatCost}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orangeAccent),
                                    ),
                                    Text("Min order",
                                        style: TextStyle(color: Colors.grey))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                          ),
                    );
                // return Column(
                //   children: <Widget>[
                //     Text('${alridezModel.driverName}'),
                //     Text('${alridezModel.carColor}'),
                //     Text('${alridezModel.carNumber}'),
                //   ],
                  
                // );
                }
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
                //return  a circular progress indicator.
                return Center(child: new CircularProgressIndicator());
              },
    
      );
  }

}
