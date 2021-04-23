import 'package:login_dash_animation/models/walletModel.dart';
import 'package:http/http.dart' as http;


Future<List<Wallet>>  fetchWallets() async {
    String url = "https://ridezmyway.com/apiall/walletuser.php";
    final response = await http.get(url);
    return walletFromJson(response.body);
  }