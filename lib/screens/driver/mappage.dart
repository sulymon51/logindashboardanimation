// import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_map_polyline/google_map_polyline.dart';
// import 'package:permission/permission.dart';
import 'package:flutter/material.dart';
import 'package:login_dash_animation/screens/driver/additionalform.dart';
import 'package:login_dash_animation/screens/walletScreen.dart';
import 'package:permission/permission.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDDashboard extends StatefulWidget {
  const UserDDashboard({Key key}) : super(key: key);

  static String tag = 'UserDashboard';
  @override
  _UserDDashboardState createState() => _UserDDashboardState();
}

final Color themeColor = Colors.deepPurpleAccent;
final Color inactiveColor = Colors.blueGrey;
double screenWidth, screenHeight;

final Color backgroundColor = Colors.white;
final Color iconColor = Colors.lightBlueAccent;
final Color savingsColor = Colors.deepPurpleAccent;
final Color investColor = Colors.indigoAccent;
final Color ajoColor = Colors.black;
final Color cardBg = Colors.white;
final textheadsize = 17.0;
final amountsize = 25.0;
final textbodysize = 15.0;
final textbodysizesm = 12.0;
final Color textColor = Colors.white;
final tabFontSize = 10.0;
final double imgHeight = 40;

class _UserDDashboardState extends State<UserDDashboard> {
  final Set<Polyline> polyline = {};
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final startController = TextEditingController();
  final detinationController = TextEditingController();

  List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyAgFYeWZeu79_HY3F0wTYjfWyc4L1xyCeg");

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged().listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  getPoints() async {
    // var permissions = await Permission.getPermissionsStatus([PermissionName.Location]);

    // if(permissions[0].permissionStatus == PermissionStatus.notAgain){
    //   var askpermissions = await Permission.requestPermissions([PermissionName.Location]);
    // }else{
    //   routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
    //   origin:  LatLng(6.5244, 3.3792),
    //   destination: LatLng(6.4584, 7.5464),
    //   mode: RouteMode.driving
    //   );

    // }
  }

  getAddressPoints() async {
    routeCoords = await googleMapPolyline.getPolylineCoordinatesWithAddress(
        origin: '18, Afolabi Aina Street, Off Allen Avenue, Ikeja Lagos.',
        destination: '873 Ozumba Mbadiwe Rd, Victoria Island, Lagos',
        mode: RouteMode.driving);
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
//    items.add((items.length+1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddressPoints();
    getCurrentLocation();
    getAddressPoints();
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('Full Name'),
      accountEmail: Text('user.name@email.com'),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 42.0),
        backgroundColor: cardBg,
      ),
      otherAccountsPictures: <Widget>[
        CircleAvatar(
          backgroundColor: cardBg,
          child: GestureDetector(
            child: Icon(
              Icons.exit_to_app,
              color: themeColor,
            ),
            // onTap: () {
            //   Navigator.of(context).pushNamed(Login.tag);
            // }
          ),
        )
      ],
    );

    return Scaffold(
      key: this._scaffoldKey,
      //  appBar: FloatAppBar(),
      body: Stack(
        children: <Widget>[
          // Replace this container with your Map widget
          Container(
            child: GoogleMap(
              mapType: MapType.normal,
              polylines: polyline,
              trafficEnabled: true,
              mapToolbarEnabled: true,
              indoorViewEnabled: true,
              myLocationButtonEnabled: true,
              tiltGesturesEnabled: true,
              myLocationEnabled: true,
              rotateGesturesEnabled: true,
              initialCameraPosition: initialLocation,
              markers: Set.of((marker != null) ? [marker] : []),
              circles: Set.of((circle != null) ? [circle] : []),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            ),
          ),
          // Container(
          //   // color: Colors.black,

          // ),
          Positioned(
            top: 550,
            right: 13,
            left: 10,
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  // IconButton(
                  //   splashColor: Colors.grey,
                  //   icon: Icon(Icons.menu),
                  //   onPressed: () {},
                  // ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: startController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.my_location),
                            labelText: 'Enter Starting Location ',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: detinationController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.location_on),
                            labelText: 'Enter Destination Location ',
                          ),
                        ),
                        RaisedButton(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          onPressed: () {
                            var senter = startController.text;
                            var denter = detinationController.text;
                            print(senter);
                            print(denter);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AditionalScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Next Step',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),

                    //  TextField(
                    //   cursorColor: Colors.black,
                    //   keyboardType: TextInputType.text,
                    //   textInputAction: TextInputAction.go,
                    //   decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       contentPadding:
                    //           EdgeInsets.symmetric(horizontal: 15),
                    //       hintText: "Search..."),
                    // ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 8.0),
                  //   child:
                  //   // CircleAvatar(
                  //   //   backgroundColor: Colors.deepPurple,
                  //   //   child: Text('RD'),
                  //   // ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),

      // GoogleMap(
      //   onMapCreated: onMapCreated,
      //   polylines: polyline,
      //   initialCameraPosition: CameraPosition(target: LatLng(6.5244, 3.3792),
      //   zoom: 11.0
      //   ),
      //   mapType: MapType.normal,
      //   ),

      // drawer: Drawer(
      //   child: drawerItems,
      // ),

      floatingActionButton: Column(
        children: <Widget>[
          //  Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: <Widget>[
          //             SizedBox(
          //               width: 40.0,
          //               height: 500.0,
          //             ),
          //             FloatingActionButton(
          //               backgroundColor: Colors.black,
          //               elevation: 0,
          //               child: Icon(Icons.create),
          //                   onPressed: () => this
          //               ._scaffoldKey
          //               .currentState
          //               .showBottomSheet((ctx) => _buildBottomSheet(ctx)),
          //                 ),
          //           ],
          //         ),
          //       ),
          //  Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: FloatingActionButton(
          //       child: Icon(Icons.create),
          //          onPressed: () => showModalBottomSheet(
          // context: context, builder: (ctx) => _buildBottomSheet(ctx)),
          //       ),
          // ),
          //       RaisedButton(
          //   child: Text('show bottom sheet'),
          // onPressed: () => this
          //     ._scaffoldKey
          //     .currentState
          //     .showBottomSheet((ctx) => _buildBottomSheet(ctx)),
          // ),
        ],
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
      polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: routeCoords,
          width: 4,
          color: themeColor,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    });
  }

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      height: 500,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepOrange, width: 3.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView(
        children: <Widget>[
          ListTile(title: Text('Set your Journey')),
          TextFormField(
            controller: startController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.my_location),
              labelText: 'Enter Starting Location ',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: detinationController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.location_on),
              labelText: 'Enter Destination Location',
            ),
          ),
          RaisedButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            onPressed: () {
              var senter = startController.text;
              var denter = detinationController.text;
              print(senter);
              print(denter);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WalletPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Custom Shape Button',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          // RaisedButton(
          //   color: Colors.deepOrange,
          //   icon: Icon(Icons.save),
          //   label: Text('Next'),
          //   onPressed: (){
          //     var senter =startController.text;
          //     var denter = detinationController.text;
          //     print(senter);
          //     print(denter);
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => WalletPage()));
          //   },
          // ),
        ],
      ),
    );
  }
}

class FloatAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 15,
      left: 15,
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            IconButton(
              splashColor: Colors.grey,
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: "Search..."),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text('RD'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
