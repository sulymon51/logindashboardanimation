import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Turn-By-Turn Navigation Provider
class MapboxNavigation {
  factory MapboxNavigation({ValueSetter<bool> onRouteProgress}) {
    if (_instance == null) {
      final MethodChannel methodChannel =
          const MethodChannel('flutter_mapbox_navigation');
      final EventChannel eventChannel =
          const EventChannel('flutter_mapbox_navigation/arrival');
      _instance = MapboxNavigation.private(
          methodChannel, eventChannel, onRouteProgress);
    }
    return _instance;
  }

  @visibleForTesting
  MapboxNavigation.private(this._methodChannel, this._routeProgressEventchannel,
      this._routeProgressNotifier);

  static MapboxNavigation _instance;

  final MethodChannel _methodChannel;
  final EventChannel _routeProgressEventchannel;
  final ValueSetter<bool> _routeProgressNotifier;

  Stream<bool> _onRouteProgress;
  StreamSubscription<bool> _routeProgressSubscription;

  ///Current Device OS Version
  Future<String> get platformVersion => _methodChannel
      .invokeMethod('getPlatformVersion')
      .then<String>((dynamic result) => result);

  ///Total distance remaining in meters along route.
  Future<double> get distanceRemaining => _methodChannel
      .invokeMethod<double>('getDistanceRemaining')
      .then<double>((dynamic result) => result);

  ///Total seconds remaining on all legs.
  Future<double> get durationRemaining => _methodChannel
      .invokeMethod<double>('getDurationRemaining')
      .then<double>((dynamic result) => result);

  ///Show the Navigation View and Begins Direction Routing
  ///
  /// [origin] must not be null. It must have a longitude, latitude and name.
  /// [destination] must not be null. It must have a longitude, latitude and name.
  /// [mode] defaults to drivingWithTraffic
  /// [simulateRoute] if true will simulate the route as if you were driving. Always true on iOS Simulator
  /// [language] this property affects the sentence contained within the RouteStep.instructions property, but it does not affect any road names contained in that property or other properties such as RouteStep.name. Defaults to "en" if an unsupported language is specified. The languages in this link are supported: https://docs.mapbox.com/android/navigation/overview/localization/ or https://docs.mapbox.com/ios/api/navigation/0.14.1/localization-and-internationalization.html
  ///
  /// Begins to generate Route Progress
  ///
  Future startNavigation(
      {Location origin,
      Location destination,
      NavigationMode mode = NavigationMode.drivingWithTraffic,
      bool simulateRoute = false, String language, VoiceUnits units}) async {
    assert(origin != null);
    assert(origin.name != null);
    assert(origin.latitude != null);
    assert(origin.longitude != null);
    assert(destination != null);
    assert(destination.name != null);
    assert(destination.latitude != null);
    assert(destination.longitude != null);
    final Map<String, Object> args = <String, dynamic>{
      "originName": origin.name,
      "originLatitude": origin.latitude,
      "originLongitude": origin.longitude,
      "destinationName": destination.name,
      "destinationLatitude": destination.latitude,
      "destinationLongitude": destination.longitude,
      "mode": mode.toString().split('.').last,
      "simulateRoute": simulateRoute,
      "language" : language,
      "units" : units?.toString()?.split('.')?.last
    };
    await _methodChannel.invokeMethod('startNavigation', args);
    _routeProgressSubscription = _streamRouteProgress.listen(_onProgressData);
  }

  ///Ends Navigation and Closes the Navigation View
  Future<bool> finishNavigation() async {
    var success = await _methodChannel.invokeMethod('finishNavigation', null);
    return success;
  }

  void _onProgressData(bool arrived) {
    if (_routeProgressNotifier != null) _routeProgressNotifier(arrived);

    if (arrived) _routeProgressSubscription.cancel();
  }

  Stream<bool> get _streamRouteProgress {
    if (_onRouteProgress == null) {
      _onRouteProgress = _routeProgressEventchannel
          .receiveBroadcastStream()
          .map((dynamic event) => _parseArrivalState(event));
    }
    return _onRouteProgress;
  }

  bool _parseArrivalState(bool state) {
    return state;
  }
}

class Location {
  final String name;
  final double latitude;
  final double longitude;

  Location(
      {@required this.name, @required this.latitude, @required this.longitude});
}

///Option to specify the mode of transportation.
enum NavigationMode { walking, cycling, driving, drivingWithTraffic }

///Whether or not the units used inside the voice instruction's string are in imperial or metric.
enum VoiceUnits { imperial, metric}

class NavigationView extends StatefulWidget {
  final Location origin;
  final Location destination;
  final bool simulateRoute;
  final String language;
  final VoiceUnits units;

  NavigationView(
      {@required this.origin, @required this.destination, this.simulateRoute, this.language, this.units});

  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  Map<String, Object> args;

  @override
  initState() {
    args = <String, dynamic>{
      "originName": widget.origin.name,
      "originLatitude": widget.origin.latitude,
      "originLongitude": widget.origin.longitude,
      "destinationName": widget.destination.name,
      "destinationLatitude": widget.destination.latitude,
      "destinationLongitude": widget.destination.longitude,
      "simulateRoute": widget.simulateRoute,
      "language" : widget.language,
      "units" : widget.units
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 350,
      width: 350,
      child: UiKitView(
          viewType: "FlutterMapboxNavigationView",
          creationParams: args,
          creationParamsCodec: StandardMessageCodec()),
    );
  }
}























// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';



// import 'package:login_dash_animation/screens/driver/map_request.dart';

// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {

//   bool loading = true;
//   final Set<Marker> _markers = {};
//   final Set<Polyline> _polyLines = {};
//   GoogleMapsServices _googleMapsServices = GoogleMapsServices();
//   Set<Polyline> get polyLines => _polyLines;
//   Completer<GoogleMapController> _controller = Completer();
//   static LatLng latLng;
//   LocationData currentLocation;


//   @override
//   void initState(){
//     getLocation();
//     loading = true;
//     super.initState();
//   }


//    getLocation() async {

//     var location = new Location();
//     location.onLocationChanged().listen((  currentLocation) {

//       print(currentLocation.latitude);
//       print(currentLocation.longitude);
//       setState(() {

//         latLng =  LatLng(currentLocation.latitude, currentLocation.longitude);
//        });

//       print("getLocation:$latLng");
//       _onAddMarkerButtonPressed();
//       loading = false;
//     });

//   }



//   void _onAddMarkerButtonPressed() {
//      setState(() {
//       _markers.add(Marker(
//          markerId: MarkerId("111"),
//         position: latLng,
//         icon: BitmapDescriptor.defaultMarker,
//       ));
//     });
//    }


//   void onCameraMove(CameraPosition position) {
//     latLng = position.target;
//    }

//   List<LatLng> _convertToLatLng(List points) {
//     List<LatLng> result = <LatLng>[];
//     for (int i = 0; i < points.length; i++) {
//       if (i % 2 != 0) {
//         result.add(LatLng(points[i - 1], points[i]));
//       }
//     }
//     return result;
//   }

//   void sendRequest() async {
//     LatLng destination = LatLng(20.008751, 73.780037);
//     String route = await _googleMapsServices.getRouteCoordinates(
//         latLng, destination);
//     createRoute(route);
//     _addMarker(destination,"KTHM Collage");
//   }

//   void createRoute(String encondedPoly) {
//     _polyLines.add(Polyline(
//         polylineId: PolylineId(latLng.toString()),
//         width: 4,
//         points: _convertToLatLng(_decodePoly(encondedPoly)),
//         color: Colors.red));
//   }

//   void _addMarker(LatLng location, String address) {
//     _markers.add(Marker(
//       markerId: MarkerId("112"),
//         position: location,
//         infoWindow: InfoWindow(title: address, snippet: "go here"),
//         icon: BitmapDescriptor.defaultMarker));
//   }

//   List _decodePoly(String poly) {
//     var list = poly.codeUnits;
//     var lList = new List();
//     int index = 0;
//     int len = poly.length;
//     int c = 0;
//      do {
//       var shift = 0;
//       int result = 0;

//       do {
//         c = list[index] - 63;
//         result |= (c & 0x1F) << (shift * 5);
//         index++;
//         shift++;
//       } while (c >= 32);
//        if (result & 1 == 1) {
//         result = ~result;
//       }
//       var result1 = (result >> 1) * 0.00001;
//       lList.add(result1);
//     } while (index < len);

//      for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

//     print(lList.toString());

//     return lList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("getLocation111:$latLng");
//     return new Scaffold(

//       body:
//       loading
//           ?
//       Container(color: Colors.red,)
//           :
//       GoogleMap(
//         polylines: polyLines,
//          markers: _markers,
//          mapType: MapType.normal,
//         initialCameraPosition: CameraPosition(
//           target: latLng,
//           zoom: 14.4746,
//         ),
//         onCameraMove:  onCameraMove,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),

//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: (){
//           sendRequest();
//         },
//         label: Text('Destination'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }
// }



