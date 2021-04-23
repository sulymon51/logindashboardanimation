import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_dash_animation/History/history.dart';
import 'package:login_dash_animation/Settings/inviteFriends.dart';
import 'package:login_dash_animation/screens/MyProfile/myProfile.dart';
import 'package:login_dash_animation/screens/MyProfile/profile.dart';
// import 'package:login_dash_animation/screens/MessagesScreen.dart';
import 'package:login_dash_animation/screens/ProfileScreen.dart';
import 'package:login_dash_animation/screens/ReferralScreen.dart';
import 'package:login_dash_animation/screens/driver/Request/request.dart';
import 'package:login_dash_animation/screens/driver/additionalform.dart';
import 'package:login_dash_animation/screens/driver/driverHistory.dart';
import 'package:login_dash_animation/screens/driver/model/card_model.dart';
import 'package:login_dash_animation/screens/driver/model/place_model.dart';
import 'package:login_dash_animation/screens/driver/model/ride_option_model.dart';
import 'package:login_dash_animation/screens/driver/myridesScreen.dart';
import 'package:login_dash_animation/screens/driver/pages/AdduserPage.dart';
import 'package:login_dash_animation/screens/driver/pages/taxi_movement_page.dart';
import 'package:login_dash_animation/screens/driver/provider/google_map_service.dart';
import 'package:login_dash_animation/screens/driver/utils/constants.dart';
import 'package:login_dash_animation/screens/driver/utils/styles.dart';
import 'package:login_dash_animation/screens/historyScreen.dart';
import 'package:login_dash_animation/screens/kycScreen.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/main_screen.dart';
import 'package:login_dash_animation/screens/walletScreen.dart';
import 'package:login_dash_animation/theme/style.dart';
import 'package:place_picker/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:typed_data';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
class BookPage extends StatefulWidget {
  static final routeName = "book-taxi-page";

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  LatLng myLocation;
  Set<Marker> _markers = {};
  String _mapStyle;
  BitmapDescriptor _taxilocation;
  BitmapDescriptor _mylocation;
  Completer<GoogleMapController> _controller = Completer();

  bool isMapCreated = false;
  final Key _mapKey = UniqueKey();
  int _selectedIndex = -1;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _fromLocationController = TextEditingController();
  final TextEditingController _toLocationController = TextEditingController();
  var uuid = Uuid();
  var sessionToken;
  var googleMapServices;
  PlaceDetail _fromPlaceDetail;
  PlaceDetail _toPlaceDetail;
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  bool _hasGottenCordinates = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  





  List<UserCardModel> _cards = [
    UserCardModel(
        id: "1",
        imageUrl: 'assets/images/img_visa_logo.png',
        cardNumber: "**** **** **** 5687"),
    UserCardModel(
        id: "2",
        imageUrl: 'assets/images/img_visa_logo.png',
        cardNumber: "**** **** **** 9987"),
    UserCardModel(
        id: "3",
        imageUrl: 'assets/images/img_visa_logo.png',
        cardNumber: "**** **** **** 7879")
  ];

  List<RideOptionModel> ridesOptions = [
    RideOptionModel(
        id: "1",
        price: 9.90,
        estimatedTime: "5 MIN",
        rideType: "Standard",
        index: 0,
        imageUrl: "assets/images/standard.png"),
    RideOptionModel(
        id: "2",
        price: 10.90,
        index: 1,
        estimatedTime: "6 MIN",
        rideType: "Comfort",
        imageUrl: "assets/images/comfort.png"),
    RideOptionModel(
        id: "3",
        price: 49.90,
        index: 2,
        estimatedTime: "5 MIN",
        rideType: "Luxury",
        imageUrl: "assets/images/luxury.png"),
  ];

  UserCardModel _selectedalvalue;
  
  Future<List<Message>> fetchUserBankDetails() async {
    
    var webAddress = "https://ridezmyway.com/apiall/getdoc.php?bkf="+id;
    var response = await http.get(Uri.encodeFull(webAddress),);
    var res = jsonDecode(response.body);

    List<Message> messages = [];

    for(var u in res){
      Message message = Message(u["document_1"], u["document_2"],  u["license_pic"]);
      messages.add(message);
      print(message.accountno);
    }
    //print(messages.length);
    return messages;

  }



  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getMarker();
    getCredential();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/taxi.png')
        .then((onValue) {
      _taxilocation = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/mylocation.png')
        .then((onValue) {
      _mylocation = onValue;
    }); 

    super.initState();
    rootBundle.loadString('assets/images/map_style.txt').then((string) {
      _mapStyle = string;
    });

    _selectedalvalue = _cards[0];

    myLocation = LatLng(6.5483768, 3.1438744);
    _markers.add(Marker(
        markerId: MarkerId("my location"),
        position: LatLng(myLocation.latitude, myLocation.longitude),
        icon: _mylocation,
        infoWindow: InfoWindow(
          title: "Pick Up Location",
        ),
        onTap: () {}));
  }

//   Future<void> getMyLocation() async {
//     Position position = await Geolocator()
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// //    myLocation = LatLng(position.latitude, position.longitude);
//     setState(() {
//       myLocation = LatLng(6.31, 5.2139453);
//     });

//     print(position);
//   }

  setPolylines() async {
    polylineCoordinates.clear();
    _polylines.clear();
    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        Constatnts.API_KEY,
        _fromPlaceDetail.lat,
        _fromPlaceDetail.lng,
        _toPlaceDetail.lat,
        _toPlaceDetail.lng
        );
    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      // create a Polyline instance

      Polyline polyline = Polyline(
          polylineId: PolylineId('poly'),
          color: Colors.black,
          width: 4,
          points: polylineCoordinates);
      _polylines.add(polyline);
      _hasGottenCordinates = true;
    });
  }

  void _moveCamera(
      PlaceDetail _fromplaceDetail, PlaceDetail _toPlaceDetail) async {
    if (_markers.length > 0) {
      setState(() {
        _markers.clear();
      });
    }
    if (_toLocationController.text != null && _toPlaceDetail != null) {
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(
        LatLng(_toPlaceDetail.lat, _toPlaceDetail.lng),
      ));
    }

    setState(() {
      if (_fromLocationController.text != null && _fromplaceDetail != null) {
        _markers.add(
          Marker(
            markerId: MarkerId(_fromplaceDetail.placeId),
            position: LatLng(_fromplaceDetail.lat, _fromplaceDetail.lng),
            icon: _mylocation,
            infoWindow: InfoWindow(
              title: "pick up",
              snippet: _fromplaceDetail.formattedAddress,
            ),
          ),
        );
      }

      if (_toLocationController.text != null && _toPlaceDetail != null) {
        _markers.add(
          Marker(
            markerId: MarkerId(_toPlaceDetail.placeId),
            position: LatLng(_toPlaceDetail.lat, _toPlaceDetail.lng),
            infoWindow: InfoWindow(
              title: "destination",
              snippet: _toPlaceDetail.formattedAddress,
            ),
          ),
        );
      }
    });

    if (_toLocationController.text != null &&
        _toPlaceDetail != null &&
        _fromLocationController.text != null &&
        _fromplaceDetail != null) {
      await setPolylines();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage('' + profilepic),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  )
                  ),
              accountName: Text('' + phone),
              accountEmail: Text('' + email),
              currentAccountPicture: CircleAvatar(
                // shape: BoxShape.circle,
                child: new Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        image: new NetworkImage('' + profilepic),
                        fit: BoxFit.cover,
                      ),
                    )),

                //  Image.network(''+ profilepic),
              ),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainScreen()))),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text("Messages"),
              // onTap: () => Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MessageScreen())),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("Wallet"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WalletPage())),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Referral"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InviteFriends())),
            ),
            ListTile(
              leading: Icon(Icons.local_taxi),
              title: Text("My Rides"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RequestScreen())),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Rides History"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoryScreen())),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text("Verify Documents"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdduserPage())),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Payments History"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoryPage())),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("My Profile"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profile())),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Log Out"),
              onTap: () => setState(
                () {
                  Navigator.pop(context);
                  signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height, //- 230.0,
              child: myLocation == null
                  ? Center(
                      child: Text("Loading Map"),
                    )
                  : GoogleMap(
                      key: _mapKey,
                      mapType: MapType.normal,
                      zoomGesturesEnabled: true,
                      // myLocationEnabled: true,
                      markers: _markers,
                      polylines: _polylines,
                      initialCameraPosition:
                          CameraPosition(target: myLocation, zoom: 15),
                      onMapCreated: (GoogleMapController controller) {
                        controller.setMapStyle(_mapStyle);
                        _controller.complete(controller);
                        //  _controller = controller;
                        // setState(() {
                        //   _markers.add(
                        //     Marker(
                        //         markerId: MarkerId("1"),
                        //         position: LatLng(6.465422, 3.406448),
                        //         icon: _taxilocation,
                        //         onTap: () {}),
                        //   );

                        //   _markers.add(
                        //     Marker(
                        //         markerId: MarkerId("2"),
                        //         position: LatLng(6.30, 3.2145634),
                        //         icon: _taxilocation,
                        //         onTap: () {}),
                        //   );

                        //   _markers.add(
                        //     Marker(
                        //         markerId: MarkerId("3"),
                        //         position: LatLng(6.35, 3.2139453),
                        //         icon: _taxilocation,
                        //         onTap: () {}),
                        //   );
                        // });
                      },
                    )),
          Positioned(top: 65, left: 5, right: 5, child: _buildHelloWidget()),
          _hasGottenCordinates
              ? _buildSelectRideWidget()
              : _buildToFromDestination(),
          Positioned(
            top: 25.0,
            left: 5.0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildToFromDestination() {
    return Positioned(
        bottom: 5,
        left: 5,
        right: 5,
        child: Card(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: <Widget>[
                TypeAheadField(
                  direction: AxisDirection.up,
                  debounceDuration: Duration(milliseconds: 500),
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _fromLocationController,
                    autofocus: false,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        icon: new Icon(
                          FontAwesomeIcons.taxi,
                          color: Colors.deepOrange,
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 15,
                            ),
                            onPressed: () {
                              _fromLocationController.clear();
                            }),
                        labelText: "From"),
                  ),
                  suggestionsCallback: (pattern) async {
                    if (sessionToken == null) {
                      sessionToken = uuid.generateV4();
                    }
                    googleMapServices =
                        GoogleMapServices(sessionToken: sessionToken);
                    return await googleMapServices.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggetion) {
                    return ListTile(
                      title: Text(
                        suggetion.description,
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggetion) async {
                    _fromLocationController.text = suggetion.description;
                    _fromPlaceDetail = await googleMapServices.getPlaceDetail(
                      suggetion.placeId,
                      sessionToken,
                    );

                    _moveCamera(_fromPlaceDetail, _toPlaceDetail);
                    sessionToken = null;
                  },
                ),
                TypeAheadField(
                  direction: AxisDirection.up,
                  debounceDuration: Duration(milliseconds: 500),
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _toLocationController,
                    autofocus: false,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        icon: new Icon(
                          FontAwesomeIcons.dotCircle,
                          color: Colors.red,
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 15,
                            ),
                            onPressed: () {
                              _toLocationController.clear();
                            }),
                        labelText: "To"),
                  ),
                  suggestionsCallback: (pattern) async {
                    if (sessionToken == null) {
                      sessionToken = uuid.generateV4();
                    }
                    googleMapServices =
                        GoogleMapServices(sessionToken: sessionToken);
                    return await googleMapServices.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggetion) {
                    return ListTile(
                      title: Text(
                        suggetion.description,
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggetion) async {
                    _toLocationController.text = suggetion.description;
                    _toPlaceDetail = await googleMapServices.getPlaceDetail(
                      suggetion.placeId,
                      sessionToken,
                    );
                    _moveCamera(_fromPlaceDetail, _toPlaceDetail);
                    sessionToken = null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        var senter = _fromLocationController.text;
                        var denter = _toLocationController.text;
                        var frmlat = _fromPlaceDetail.lat;
                        var frmlng = _fromPlaceDetail.lng;
                        var tolat = _toPlaceDetail.lat;
                        var tolng = _toPlaceDetail.lng;
                        print(senter);
                        print(_fromPlaceDetail.lat);
                        print(_fromPlaceDetail.lng);
                        print(_toPlaceDetail.lat); 
                        print(_toPlaceDetail.lng);
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return AditionalScreen(
                            fromPlaceDetail: _fromPlaceDetail,
                            toPlaceDetail: _toPlaceDetail,
                            polylines: _polylines,
                            polylineCoordinates: polylineCoordinates,
                            stname: senter,
                            dtname: denter,
                            frmlt: frmlat,
                            frmlg: frmlng,
                            tolt: tolat,
                            tolg: tolng,
                          );
                        }));
                      },
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 15,
                      ),
                      padding: EdgeInsets.all(6),
                      shape: CircleBorder(),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildHelloWidget() {
    return Card(
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: Icon(
            FontAwesomeIcons.user,
            color: Constatnts.primaryColor,
            size: 40,
          ),
          title: Text(
            "Hello," + name,
            style: CustomStyles.smallTextStyle,
          ),
          subtitle: Text(
            "Where are you Going to ?",
            style: CustomStyles.normalTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectRideWidget() {
    return Positioned(
      bottom: 5,
      left: 5,
      right: 5,
      child: Card(
        child: Container(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "",
                style: CustomStyles.normalTextStyle,
              ),
              Container(
                height: 1,
                child: ListView.builder(
                    itemCount: ridesOptions.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Card(
                          margin: const EdgeInsets.all(15.0),
                          elevation: 10,
                          color: _selectedIndex == ridesOptions[index].index
                              ? Constatnts.primaryColor
                              : Colors.white,
                          child: Container(
                            child: Container(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          ridesOptions[index].rideType,
                                          style: _selectedIndex ==
                                                  ridesOptions[index].index
                                              ? CustomStyles.cardBoldTextStyle
                                              : CustomStyles
                                                  .cardBoldDarkTextStyle,
                                        ),
                                        Text(
                                          "N ${ridesOptions[index].price.toString()}",
                                          style: _selectedIndex ==
                                                  ridesOptions[index].index
                                              ? CustomStyles.cardNormalTextStyle
                                              : CustomStyles
                                                  .cardNormalDarkTextStyle,
                                        ),
                                        Text(
                                          ridesOptions[index].estimatedTime,
                                          style: _selectedIndex ==
                                                  ridesOptions[index].index
                                              ? CustomStyles.cardNormalTextStyle
                                              : CustomStyles
                                                  .cardNormalDarkTextStyle,
                                        )
                                      ],
                                    ),
                                    Expanded(
                                        child: Image.asset(
                                            ridesOptions[index].imageUrl))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Container(
                    //   width: 200,
                    //   height: 50.0,
                    //   child: DropdownButton<UserCardModel>(
                    //     icon: const Icon(
                    //       Icons.arrow_drop_down,
                    //       color: Colors.deepOrange,
                    //     ),
                    //     items: _cards.map((UserCardModel value) {
                    //       return new DropdownMenuItem<UserCardModel>(
                    //           value: value,
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //             children: <Widget>[
                    //               // Image.asset(
                    //               //   value.imageUrl,
                    //               //   height: 10,
                    //               // ),
                    //               // Text(
                    //               //   value.cardNumber,
                    //               //   style: TextStyle(fontSize: 10),
                    //               // ),
                    //             ],
                    //           ));
                    //     }).toList(),

                    //     onChanged: (value) {
                    //       setState(() {
                    //         _selectedalvalue = value;
                    //       });
                    //     },
                    //     underline: SizedBox(),
                    //     isExpanded: true,
                    //     elevation: 0,
                    //     value: _selectedalvalue,

                    //     // onSaved: (value) {

                    //     // },
                    //   ),
                    // ),
                    Center(
                      child:  Builder(
                                  builder: (context) {
                                    // var newa = '${riderhisTory.bal}';
                                    // print(newa);
                                    if (carnumber == null) {
                                      return  MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Constatnts.primaryColor,
                        onPressed: () {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) {
                            return AdduserPage();
                          })
                          );
                        },
                        child: Center(
                          child: Text(
                            "Upload your KYC",
                            style: CustomStyles.cardBoldTextStyle,
                          ),
                        ),
                );
                }else{
                  return  MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Constatnts.primaryColor,
                        onPressed: () {
                          var senter = _fromLocationController.text;
                          var denter = _toLocationController.text;
                          var frmlat = _fromPlaceDetail.lat;
                          var frmlng = _fromPlaceDetail.lng;
                          var tolat = _toPlaceDetail.lat;
                          var tolng = _toPlaceDetail.lng;
                          print(senter);
                          print(_fromPlaceDetail.lat);
                          print(_fromPlaceDetail.lng);
                          print(_toPlaceDetail.lat);
                          print(_toPlaceDetail.lng);
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) {
                            return AditionalScreen(
                              fromPlaceDetail: _fromPlaceDetail,
                              toPlaceDetail: _toPlaceDetail,
                              polylines: _polylines,
                              polylineCoordinates: polylineCoordinates,
                              stname: senter,
                              dtname: denter,
                              frmlt: frmlat,
                              frmlg: frmlng,
                              tolt: tolat,
                              tolg: tolng,
                            );
                          })
                          );
                        },
                        child: Center(
                          child: Text(
                            "Confirm",
                            style: CustomStyles.cardBoldTextStyle,
                          ),
                        ),
                );
              }
              })
                      
                      
                      
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SharedPreferences sharedPreferences;

  String name = "",
      phone = "",
      email = "",
      type = "",
      carmodel = "",
      carnumber = "",
      carcolor = "",
      profilepic = "",
      dvype = "",
      dvstatus = "",
      id = "";
       

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString("name");
      email = sharedPreferences.getString("email");
      phone = sharedPreferences.getString("phone");
      type = sharedPreferences.getString("type");
      carmodel = sharedPreferences.getString("carmodel");
      carnumber = sharedPreferences.getString("carnumber");
      carcolor = sharedPreferences.getString("carcolor");
      profilepic = sharedPreferences.getString("profilepic");
      dvype = sharedPreferences.getString("dvype");
      dvstatus = sharedPreferences.getString("dvstatus");
      id = sharedPreferences.getString("id");
    });
    //  print(email);

    //  print(name);
  }

  LoginStatus _loginStatus = LoginStatus.notSignIn;
  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString("phone", null);
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("wallet_balance", null);
      preferences.setString("type", null);
      preferences.setString("ref", null);
      preferences.setString("carmodel", null);
      preferences.setString("carnumber", null);
      preferences.setString("carcolor", null);
      preferences.setString("city", null);
      preferences.setString("driverimage", null);
      preferences.setString("profilepic", null);
      preferences.setString("id", null);
      // preferences.setInt("value", null);
      // preferences.setString("phone", null);
      // preferences.setString("name", null);
      // preferences.setString("email", null);
      // preferences.setString("id", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }
}
class Message {

  final String accountname;
  final String bankname;
  final String accountno;

  Message(this.accountname, this.bankname, this.accountno);
}