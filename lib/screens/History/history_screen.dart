import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:login_dash_animation/components/animation_list_view.dart';
import 'package:login_dash_animation/models/RiderHistoryModel.dart';
import 'package:login_dash_animation/models/driverhist.dart';
import 'package:login_dash_animation/models/rideshist.dart';
import 'package:login_dash_animation/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show DateFormat;

class HistoryScreena extends StatefulWidget {
  @override
  _HistoryScreenaState createState() => _HistoryScreenaState();
}

class _HistoryScreenaState extends State<HistoryScreena> {
  final String screenName = "HISTORY";
  DateTime selectedDate;
  List<dynamic> event = [];
  String selectedMonth = '';

  navigateToDetail(String id) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HistoryDetail(
              id: id,
            )));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          
          title: Text(
            'History',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange,
          elevation: 2.0,
          iconTheme: IconThemeData(color: blackColor),
        ),
        // drawer: new MenuScreens(activeScreenName: screenName),
        body: Container(
          child: Column(
            children: <Widget>[
              // Container(
              //   height: 120.0,
              //   margin: EdgeInsets.symmetric(horizontal: 16.0),
              //   child: CalendarCarousel(
              //     weekendTextStyle: TextStyle(
              //       color: Colors.red,
              //     ),
              //     headerTextStyle: TextStyle(color: Colors.black45),
              //     inactiveWeekendTextStyle: TextStyle(color: Colors.black45),
              //     headerMargin: EdgeInsets.all(0.0),
              //     thisMonthDayBorderColor: Colors.grey,
              //     weekFormat: true,
              //     height: 150.0,
              //     selectedDateTime: DateTime.now(),
              //     selectedDayBorderColor: blue1,
              //     selectedDayButtonColor: blue2,
              //     todayBorderColor: primaryColor,
              //     todayButtonColor: primaryColor,
              //     onDayPressed: (DateTime date, List<dynamic> events) {
              //       this.setState(() => selectedDate = date);
              //       print(selectedDate);
              //     },
              //     onCalendarChanged: (DateTime date) {
              //       this.setState(
              //           () => selectedMonth = DateFormat.yMMM().format(date)
              //           );
              //       print(selectedMonth);
              //     },
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.all(20.0),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: <Widget>[
              //       Material(
              //         elevation: 5.0,
              //         borderRadius: BorderRadius.circular(8.0),
              //         color: Colors.deepOrange,
              //         child: Container(
              //           padding: EdgeInsets.all(10.0),
              //           height: 80,
              //           width: screenSize.width * 0.4,
              //           child: Row(
              //             children: <Widget>[
              //               Icon(
              //                 Icons.content_paste,
              //                 size: 30.0,
              //               ),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //               Container(
              //                   child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: <Widget>[
              //                   Text(
              //                     "Job",
              //                     style: heading18,
              //                   ),
              //                   Text(
              //                     "20",
              //                     style: headingWhite,
              //                   )
              //                 ],
              //               )),
              //             ],
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 10.0,
              //       ),
              //       Material(
              //         elevation: 5.0,
              //         borderRadius: BorderRadius.circular(8.0),
              //         color: Colors.deepOrange,
              //         child: Container(
              //           padding: EdgeInsets.all(10.0),
              //           height: 80,
              //           width: screenSize.width * 0.4,
              //           child: Row(
              //             children: <Widget>[
              //               Icon(
              //                 Icons.card_membership,
              //                 size: 30.0,
              //               ),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //               Container(
              //                   child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: <Widget>[
              //                   Text(
              //                     "Earning",
              //                     style: heading18,
              //                   ),
              //                   Text(
              //                     "20",
              //                     style: headingWhite,
              //                   )
              //                 ],
              //               )),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Scrollbar(


                  child: FutureBuilder(
                future: alridezHisaa(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                      RiderhisTory riderhisTory = snapshot.data[index];
                        return GestureDetector(
                              onTap: () {
                          var id = '${riderhisTory.id}';
                          var ridid = '${riderhisTory.rideId}';
                          var drivername = '${riderhisTory.driverName}';
                          var driverpic = '${riderhisTory.driverPic}';
                          var staname = '${riderhisTory.startName}';
                          var dsaname = '${riderhisTory.destName}';
                          var amount = '${riderhisTory.cost}';

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryDetail(id: id, ridid: ridid,drivername: drivername,driverpic: driverpic,staname: staname,dsaname: dsaname,amount: amount,)));
                          print('$index');
                          // navigateToDetail(index.toString());
                        },
                            child: Card(
                              margin: EdgeInsets.all(10.0),
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          color: backgroundColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          )),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            // child: ClipRRect(
                                            //   borderRadius:
                                            //       BorderRadius.circular(50.0),
                                            //   child: CachedNetworkImage(
                                            //     imageUrl:
                                            //         'https://source.unsplash.com/1600x900/?portrait',
                                            //     fit: BoxFit.cover,
                                            //     width: 40.0,
                                            //     height: 40.0,
                                            //   ),
                                            // ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${riderhisTory.driverName}',
                                                  style: textBoldBlack,
                                                ),
                                                Text('${riderhisTory.date}'+""+'${riderhisTory.time}',
                                                  style: textGrey,
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                        height: 25.0,
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            color:
                                                                Colors.deepOrange),
                                                        child: Text(
                                                          'Wallet Payment',
                                                          style: textBoldWhite,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Container(
                                                        height: 25.0,
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        alignment:
                                                            Alignment.center,
                                                        // decoration: BoxDecoration(
                                                        //     borderRadius:
                                                        //         BorderRadius
                                                        //             .circular(
                                                        //                 10.0),
                                                        //     color:
                                                        //         Colors.deepOrange),
                                                        // child: Text(
                                                        //   'Discount',
                                                        //   style: textBoldWhite,
                                                        // ),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  "\₦"+ '${riderhisTory.cost}',
                                                  style: textBoldBlack,
                                                ),
                                                Text("Seat No"+'${riderhisTory.seats}',
                                                  style: textGrey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "PICK UP".toUpperCase(),
                                                    style: textGreyBold,
                                                  ),
                                                  Text(
                                                    '${riderhisTory.startName}',
                                                    style: textStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "DROP OFF".toUpperCase(),
                                                    style: textGreyBold,
                                                  ),
                                                  Text(
                                                    '${riderhisTory.destName}',
                                                    style: textStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ));
                      }
                      );
                } else if (snapshot.hasError) {
                  return Center(child: Text('No History Data'));
                }
                //return  a circular progress indicator.
                return Center(child: new CircularProgressIndicator());
              },
            )
                      
                ),
              ),
            ],
          ),
        ));
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
      id = sharedPreferences.getString("id");
    });
  }
Future<List<RiderhisTory>>  alridezHisaa() async {
    String url = "https://ridezmyway.com/apiall/getallrideh.php?id=" +id;
    final response = await http.get(url);
    // print(url);
    //     print(response);
    return riderhisToryFromJson(response.body);
  }
  // Future<List<Driverhistory>> aldriezHisa() async {
  //   String url = "https://ridezmyway.com/apiall/getalldriveh.php?id=" + id;
  //   final response = await http.get(url);
  //   print(response);
  //   return riderhisToryFromJson(response.body);
  }


  

// }

