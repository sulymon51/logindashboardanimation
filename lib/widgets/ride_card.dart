import 'package:flutter/material.dart';
import 'package:login_dash_animation/models/rideshist.dart';
import 'package:login_dash_animation/widgets/allridesmodel.dart';

class RideCard extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    FutureBuilder(
      future: alridezHis(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                RideZhist rideZhist = snapshot.data[index];
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
                          Text('${rideZhist.time}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            height: 170.0,
                            color: Colors.red,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 0.0,
                            ),
                            title: Text('${rideZhist.driverName}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.pin_drop,
                                  color: _theme.primaryColor,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text('${rideZhist.startName}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('${rideZhist.seats}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\₦"'${rideZhist.cost}',
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
    );
  }
}
