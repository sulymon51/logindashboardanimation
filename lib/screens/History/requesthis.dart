import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login_dash_animation/components/animation_list_view.dart';
import 'package:login_dash_animation/models/requestdriver.dart';
import 'package:login_dash_animation/screens/History/paydetails.dart';
import 'package:login_dash_animation/screens/driver/Request/requestDetail.dart';
import 'package:login_dash_animation/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_screen.dart';
import 'package:http/http.dart' as http;

class RequesthScreen extends StatefulWidget {
  @override
  _RequesthScreenState createState() => _RequesthScreenState();
}

class _RequesthScreenState extends State<RequesthScreen> {
 final String screenName = "REQUEST";

  navigateToDetail() {
    // var name =  requestDridez.rideName
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RequestDetail( )));
  }

  @override
  Widget build(BuildContext context) {
    requestDrive();
    return Scaffold( 
        // appBar: AppBar(
        //   title: Text(
        //     'Requests',
        //     style: TextStyle(color: blackColor),
        //   ),
        //   backgroundColor: whiteColor,
        //   elevation: 2.0,
        //   iconTheme: IconThemeData(color: blackColor),
        // ),
        // drawer: new MenuScreens(activeScreenName: screenName),
           body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("My Requests",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )
                ),
                background: Container(
                  color: whiteColor,
                ),
              ),
            ),
          ];
        },
        body:
         Container(
            child: Scrollbar(
            child: FutureBuilder(
          future: requestDrive(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  shrinkWrap: true,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              separatorBuilder:(_,int i){
                return Divider();
              },
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    RequestDridez requestDridez = snapshot.data[index];
                    final screenSize = MediaQuery.of(context).size;
                    return GestureDetector(
                        onTap: () 

                        {
                    var id = '${requestDridez.driverId}';
                    var ida = '${requestDridez.id}';
                    var idb = '${requestDridez.rideId}';
                    var name = '${requestDridez.driverName}';
                    var number = '${requestDridez.driverNumber}';
                    var seatno = '${requestDridez.seatNo}';
                    var cost = '${requestDridez.cost}';
                    var status = '${requestDridez.requestStatus}';
                    var bseat = '${requestDridez.bookedSeats}';
                    var stname = '${requestDridez.startName}';
                    var dtname = '${requestDridez.destName}';
                    var date = '${requestDridez.date}';
                    var time = '${requestDridez.time}';
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => PayDetail(id: id, idaa: ida, idab: idb,rname: name,sname:stname,dname: dtname,aname: cost,pname: number,sename: seatno,bsname: bseat,senname: seatno,sdate: date,stime: time,sstatus: status, )));
                     // Navigator.of(context).pushReplacementNamed('/history');
                    // navigateToDetail();
                  },
                        child:
                                      Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(15.0),
                    color: whiteColor,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: whiteColor
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('${requestDridez.time}'" "'${requestDridez.date}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Builder(
                                  builder: (context) {
                                    var newa = '${requestDridez.requestStatus}';
                                    // print(newa);
                                    if (newa == 'pending') {
                                      return   Text('${requestDridez.requestStatus}'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.red[600],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0
                                        ),
                                      );
                                    } else if(newa == 'awaiting'){
                                      return   Text('${requestDridez.requestStatus}'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0
                                        ),
                                      );
                                    }else if(newa == 'progress'){ 
                                      return   Text('${requestDridez.requestStatus}'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0
                                        ),
                                      );
                                    }else
                                    
                                    {
                                      return   Text('${requestDridez.requestStatus}'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.green[600],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0
                                        ),
                                      );
                                    }
                                  }
                                )
                             
                            ],
                          ),

                          Divider(),
                          
                          Container(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("From",
                                          style: TextStyle(
                                            color: Color(0xFF97ADB6),
                                            fontSize: 13.0
                                          ),
                                        ),
                                        Text("To",
                                          style: TextStyle(
                                            color: Color(0xFF97ADB6),
                                            fontSize: 13.0
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.my_location, color: blackColor,),
                        Container(
                          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          height: 25,
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        Icon(Icons.location_on, color: blackColor,)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${requestDridez.startName}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text('${requestDridez.destName}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
            
          ],
        ),
      ),
    )
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text('No Request Found'));
            }
            //return  a circular progress indicator.
            return Center(child: new CircularProgressIndicator());
          },
        )
    )
   )
 ));
  }

  // Widget historyItem() {
  //   final screenSize = MediaQuery.of(context).size;
    
  // }

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

  Future<List<RequestDridez>> requestDrive() async {
    String url = "https://ridezmyway.com/apiall/getallridereq.php?id=" +id ;
    final response = await http.get(url);
    print(response);

    return requestDridezFromJson(response.body);
  }
}
