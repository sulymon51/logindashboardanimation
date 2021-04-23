

import 'package:login_dash_animation/models/allrides.dart';
import 'package:http/http.dart' as http;
import 'package:login_dash_animation/models/rideshist.dart';

Future<List<AlridezModel>>  alridezModel() async {
    String url = "https://ridezmyway.com/apiall/getallrides.php";
    final response = await http.get(url);
    return alridezModelFromJson(response.body);
  }

Future<List<RideZhist>>  alridezHis() async {
  String url = "https://ridezmyway.com/apiall/getallrides.php?id=11";
  final response = await http.get(url);
  return rideZhistFromJson(response.body);
}
