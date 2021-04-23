import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:login_dash_animation/chat/lets_text.dart';
import 'package:login_dash_animation/models/beachesModel.dart';
import 'package:login_dash_animation/models/allavailableridesModel.dart';
import 'package:login_dash_animation/src/scoped-model/allride_model.dart';
import 'package:login_dash_animation/src/data/allride_data.dart';
import 'package:login_dash_animation/services/service_locator.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
import 'package:login_dash_animation/models/ridezshare.dart';
import 'package:login_dash_animation/screens/ridezshareScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class CallsAndMessagesService {
  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
  void sendEmail(String email) => launch("mailto:$email");
}

class AllRidesScreen extends StatefulWidget {
  List<AllavailableridesModel> _allavailableridesModel = [];

  List<AllavailableridesModel> get allavailableridesModel {
    return List.from(_allavailableridesModel);
  }

  void addAllride(AllavailableridesModel allride) {
    _allavailableridesModel.add(allride);
  }

  void fetchAllrides() {
    http
        .get("https://ridezmyway.com/apiall/getallrides.php")
        .then((http.Response response) {
      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      final List<AllavailableridesModel> fetchedAllItems = [];
      print(fetchedData);
      fetchedData.forEach((data) {
        AllavailableridesModel allavailableridesModel = AllavailableridesModel(
          id: data["id"],
          driverId: data["driver_id"],
          driverName: data["driver_name"],
          driverNumber: data["driver_number"],
          driverImage: data["driver_image"],
          carNumber: data["car_number"],
          carModel: data["car_model"],
          carColor: data["car_color"],
          city: data["city"],
          startLat: data["start_lat"],
          startLan: data["start_lan"],
          startName: data["start_name"],
          destLat: data["dest_lat"],
          destLan: data["dest_lan"],
          destName: data["dest_name"],
          liveLat: data["live_lat"],
          liveLan: data["live_lan"],
          seatNo: data["seat_no"],
          seatCost: data["seat_cost"],
          bookedSeats: data["booked_seats"],
          time: data["time"],
          date: data["date"],
          music: data["music"],
          ac: data["ac"],
          smoking: data["smoking"],
          status: data["status"],
          rating: data["rating"],
        );

        fetchedAllItems.add(allavailableridesModel);
      });

      _allavailableridesModel = fetchedAllItems;
      print(_allavailableridesModel);
    });
  }

  final AllrideModel allrideModel;
  AllRidesScreen({this.allrideModel});

  @override
  _AllRidesScreenState createState() => _AllRidesScreenState();
}

class _AllRidesScreenState extends State<AllRidesScreen> {
  List<AllavailableridesModel> _allavailableridesModel = allrides;

  // final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  final String number = "123456789";
  final String email = "dancamdev@example.com";

  @override
  void initState() {
    // widget.allrideModel.fetchAllrides();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        // itemCount: avblrid1.length,
        itemBuilder: (context, index) {
          // AllavailableridesModel allavailableridesModel = avblrid1[index];
          // return allavmItem(allavailableridesModel);
        },
      ),
    );
  }

  Widget allavmItem(AllavailableridesModel allavailableridesModel) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xFFF082938)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              width: 250,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(allavailableridesModel.driverImage),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: allriedItemIcon(Icons.call, ""),
                          // onPressed: () => _service.call(number),
                          onPressed: () =>
                              UrlLauncher.launch("tel://21213123123"),
                        ),
                        IconButton(
                          icon: allriedItemIcon(Icons.chat, ""),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LetsChat()),
                            );
                          },
                        ),
                        IconButton(
                          icon: allriedItemIcon(Icons.location_on, ""),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LetsChat()),
                            );
                          },
                        ),
                        SizedBox(width: 0),
                        SizedBox(width: 1),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  SizedBox(height: 9),
                  Center(
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/images/user_5.jpg"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      allriedItemIcon(
                          Icons.timer, "" + allavailableridesModel.time),
                      SizedBox(width: 6),
                      allriedItemIcon(
                          Icons.date_range, "" + allavailableridesModel.date),
                    ],
                  ),
                  SizedBox(width: 6),
                  Text("Cost Per Seat: " + allavailableridesModel.seatCost,
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text("Seat No: " + allavailableridesModel.seatNo,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 2),
                  Icon(Icons.place, size: 10, color: Colors.white),
                  Text(allavailableridesModel.startName,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('|',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                  Icon(Icons.gps_fixed, size: 10, color: Colors.white),
                  SizedBox(height: 3),
                  Text(allavailableridesModel.destName,
                      style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                  Text("Car Model: " + allavailableridesModel.carModel,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                  Text("Car No: " + allavailableridesModel.carNumber,
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(" ", style: TextStyle(color: Colors.white, fontSize: 12)),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    allriedItemIcon(Icons.airplay, "Ac"),
                    SizedBox(width: 15),
                    allriedItemIcon(Icons.queue_music, "Music"),
                    SizedBox(width: 15),
                    allriedItemIcon(Icons.smoking_rooms, "No Smoke"),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LetsChat())),
                      child: Image.asset(
                        "assets/view_all.png",
                        height: 30,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget allriedItemIcon(IconData iconData, String text) {
    return Row(
      children: <Widget>[
        Icon(iconData, color: Colors.white),
        SizedBox(width: 2),
        Text(text, style: TextStyle(color: Colors.white))
      ],
    );
  }

  Widget buttunAction(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const RaisedButton(
            onPressed: null,
            child: Text('Disabled Button', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 30),
          RaisedButton(
            onPressed: () {},
            child: const Text('Enabled Button', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 30),
          RaisedButton(
            onPressed: () {},
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child:
                  const Text('Gradient Button', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
