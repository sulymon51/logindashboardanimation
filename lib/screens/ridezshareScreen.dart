import 'package:login_dash_animation/models/ridezshare.dart';
import 'package:http/http.dart' as http;







Future<void>  fetchridezshareFromJson() async {
    String url = "https://ridezmyway.com/apiall/getallrides.php";
    final response = await http.get(url);
    return ridezshareFromJson(response.body);
  }