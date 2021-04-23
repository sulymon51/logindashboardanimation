import 'package:flutter/material.dart';
import 'package:login_dash_animation/History/history.dart';
import 'package:login_dash_animation/Settings/settings.dart';
import 'package:login_dash_animation/screens/MyProfile/profile.dart';
// import 'package:login_dash_animation/screens/ProfileScreen.dart';
import 'package:login_dash_animation/screens/ReferralScreen.dart';
import 'package:login_dash_animation/screens/driver/awaitingScreen.dart';
import 'package:login_dash_animation/screens/driver/driverHistory.dart';
import 'package:login_dash_animation/screens/driver/location.dart';
import 'package:login_dash_animation/screens/driver/mappage.dart';
import 'package:login_dash_animation/screens/driver/myridesScreen.dart';
import 'package:login_dash_animation/screens/driver/pages/AdduserPage.dart';
import 'package:login_dash_animation/screens/driver/pages/book_taxi_page.dart';
import 'package:login_dash_animation/screens/driver/pages/driverDocuments.dart';
import 'package:login_dash_animation/screens/historyScreen.dart';
import 'package:login_dash_animation/screens/kycScreen.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/myridesScreen.dart';
import 'package:login_dash_animation/screens/walletScreen.dart';
import 'package:login_dash_animation/src/pages/favorite_page.dart';
import 'package:login_dash_animation/src/pages/home_page.dart';
import 'package:login_dash_animation/src/pages/order_page.dart';
import 'package:login_dash_animation/src/scoped-model/allride_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainScreen extends StatefulWidget {
  final AllrideModel allrideModel;
  MainScreen({this.allrideModel});
  @override
  _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  SharedPreferences sharedPreferences;
  String name = "", phone = "", email = "", id="", profilepic="", dvype = "", dvstatus = "";
  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
       name = sharedPreferences.getString("name");
       phone= sharedPreferences.getString("phone");
       email= sharedPreferences.getString("email");
       profilepic= sharedPreferences.getString("profilepic");
       dvype = sharedPreferences.getString("dvype");
       dvstatus = sharedPreferences.getString("dvstatus");
       id= sharedPreferences.getString("id");
    });
    //  print(email);
    //  print(name);
  }
  int currentTab = 0;
  // Pages
  BookPage userDashboard;
  HistoryScreen historyPage;
  WalletPage walltPage;
  SettingsScreen profile;
  List<Widget> pages;
  Widget currentPage;
  @override
  void initState() {
    userDashboard = BookPage();
    historyPage = HistoryScreen();
    walltPage = WalletPage();
    profile = SettingsScreen();
    pages = [userDashboard, historyPage, walltPage, profile];
    currentPage = userDashboard;
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    getCredential();

      // if(dvstatus =='yes'){
    return new WillPopScope(
      onWillPop: () async => false,
       child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (index) {
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
            ),
            title: Text("History"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet,
            ),
            title: Text("wallet"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            title: Text("Settings"),
          ),
        ],
      ),
      body: currentPage,
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.all(0),
      //     children: [
      //       UserAccountsDrawerHeader(
      //         accountName: Text('' + phone),
      //         accountEmail: Text('' + email),
      //         currentAccountPicture: CircleAvatar(
      //           child: Text("AC"),
      //         ),
      //       ),
      //       ListTile(
      //           leading: Icon(Icons.home),
      //           title: Text("Home"),
      //           onTap: () => Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => MainScreen()))),
      //       ListTile(
      //         leading: Icon(Icons.account_balance_wallet),
      //         title: Text("Wallet"),
      //         onTap: () => Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => WalletPage())),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.people),
      //         title: Text("Referral"),
      //         onTap: () => Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => ReferralPage())),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.local_taxi),
      //         title: Text("My Rides"),
      //         onTap: () => Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => MyRidesDriver())),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.history),
      //         title: Text("Rides History"),
      //         onTap: () => Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => MyRidesHis())),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.security),
      //         title: Text("Verify Documents"),
      //         onTap: () => Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => KycScreendocument())),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.history),
      //         title: Text("Payments History"),
      //         onTap: () => Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => HistoryPage())),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.settings),
      //         title: Text("Settings"),
      //         onTap: () => Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => SettingsScreen())),
      //       ),
      //       // ListTile(
      //       //   leading: Icon(Icons.exit_to_app),
      //       //   title: Text("Log Out"),
      //       //   onTap: () => setState(
      //       //     () {
      //       //       Navigator.pop(context);
      //       //       signOut();
      //       //       Navigator.push(context,
      //       //           MaterialPageRoute(builder: (context) => LoginScreen()));
      //       //     },
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
      key: _scaffoldKey,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _scaffoldKey.currentState.openDrawer(),
      //   child: Icon(Icons.menu),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
       )
    );
    // }else{
    //   return Awaitingverify();
    // }
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
      preferences.setString("id", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }
}
