// import 'package:login_dash_animation/screens/wallethisApi.dart';
import 'package:http/http.dart' as http;

  // SharedPreferences sharedPreferences;

  // @override
  // void initState() {
  //   super.initState();
  //   getCredential();
  // }

  // String name = "", phone = "", email = "", id = "", wallet_balance = "";

  // getCredential() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     name = sharedPreferences.getString("name");
  //     phone = sharedPreferences.getString("phone");
  //     email = sharedPreferences.getString("email");
  //     id = sharedPreferences.getString("id");
  //     wallet_balance = sharedPreferences.getString("wallet_balance");
  //   });

  //   // print(email);
  //   // print(name);
  //   // print(id);
  //   // print(wallet_balance);
  // }



// Future<List<WalletHIstory>>  fetchWallethis() async {
//     String url = "https://ridezmyway.com/apiall/wallet_history.php?id="+id;
//     final response = await http.get(url);
//     return walletHIstoryFromJson(response.body);
//   }