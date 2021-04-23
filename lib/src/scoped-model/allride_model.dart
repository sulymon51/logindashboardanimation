import 'dart:convert';

import 'package:login_dash_animation/models/allavailableridesModel.dart';

import 'package:scoped_model/scoped_model.dart';
// import 'package:soped';
import 'package:http/http.dart' as http;

class AllrideModel extends Model {
  List<AllavailableridesModel> _allavailableridesModel = [];

  List<AllavailableridesModel> get allavailableridesModel {
    return List.from(_allavailableridesModel);
  }

  void addAllride(AllavailableridesModel allride) {
    _allavailableridesModel.add(allride);
  }

  Future <String> fetchAllrides() {
    http
        .get("https://ridezmyway.com/apiall/getallrides.php")
        .then((http.Response response) {
      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      final List<AllavailableridesModel> fetchedAllItems =  [];
      print(fetchedData);
      fetchedData.forEach((data) {
        AllavailableridesModel allavailableridesModel1 = AllavailableridesModel(
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

        fetchedAllItems.add(allavailableridesModel1);
      });

      _allavailableridesModel = fetchedAllItems;
      print(_allavailableridesModel);
    });
  }
}