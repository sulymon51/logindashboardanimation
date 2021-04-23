import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:login_dash_animation/Settings/inviteFriends.dart';
import 'package:login_dash_animation/animations/fadeAnimation.dart';
import 'package:login_dash_animation/screens/History/history_screen.dart';
import 'package:login_dash_animation/screens/History/requesthis.dart';
import 'package:login_dash_animation/screens/MyProfile/profile.dart';
import 'package:login_dash_animation/screens/ReferralScreen.dart';
import 'package:login_dash_animation/screens/dashScreen.dart';
import 'package:login_dash_animation/screens/historyScreen.dart';
import 'package:login_dash_animation/screens/kycScreen.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/myridesScreen.dart';
import 'package:login_dash_animation/screens/walletScreen.dart';
import 'package:login_dash_animation/src/data/allride_data.dart';
import 'package:login_dash_animation/src/scoped-model/allride_model.dart';
import 'package:login_dash_animation/widgets/AllRides.dart';
import 'package:login_dash_animation/widgets/headerWidget.dart';
import 'package:login_dash_animation/widgets/popularBeaches.dart';
import 'package:login_dash_animation/widgets/searchWidget.dart';
import 'package:login_dash_animation/widgets/videoWidget.dart';
import 'package:login_dash_animation/screens/ProfileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomScreen extends StatefulWidget {
  final AllrideModel allrideModel;
  WelcomScreen({this.allrideModel});

  @override
  _WelcomScreenState createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  SharedPreferences sharedPreferences;

  String name = "", phone = "", email = "", type = "", profilepic="";

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      //
      name = sharedPreferences.getString("name");
      email = sharedPreferences.getString("email");
      phone = sharedPreferences.getString("phone");
      type = sharedPreferences.getString("type");
      profilepic= sharedPreferences.getString("profilepic");
    });
    //  print(type);
    //  print(name);
  }

  int pageIndex = 1;

  final AllrideModel allrideModel = AllrideModel();

  final DashScreen _dashScreen = DashScreen();
  final Profile _profilePage = new Profile();
  final HistoryScreena _myRides = new HistoryScreena();
  final WalletPage _walletPage = new WalletPage();

  Widget _showPage = new DashScreen();
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _profilePage;
        break;
      case 1:
        return _dashScreen;
        break;
      case 2:
        return _myRides;
        break;
      case 3:
        return _walletPage;
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text(
              ' Noosafdo ',
              style: new TextStyle(fontSize: 30),
            ),
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    getCredential();
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(
          index: pageIndex,
          color: Colors.deepOrange,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.deepOrange,
          height: 50,

          items: <Widget>[
            Icon(
              Icons.person,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              Icons.local_taxi,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              Icons.history,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              Icons.account_balance_wallet,
              size: 20,
              color: Colors.white,
            ),
          ],
          animationDuration: Duration(milliseconds: 200),
          // index: 1,
          animationCurve: Curves.easeIn,
          onTap: (int tappedIndex) {
            setState(() {
              _showPage = _pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
          child: _showPage,
        ),
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
              accountName: Text('Phone'" " + phone),
              accountEmail: Text('email:'" " + email),
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
                      MaterialPageRoute(builder: (context) => LoginScreen()))),
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
                title: Text("My Riquest"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RequesthScreen())),
              ),
              ListTile(
                leading: Icon(Icons.local_taxi),
                title: Text("Rides History"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryScreena())),
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: Text("Upload KYC"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KycScreen())),
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
                    // Navigator.pop(context);
                    signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
          child: Icon(Icons.menu),
        ),
      ),
    );
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
