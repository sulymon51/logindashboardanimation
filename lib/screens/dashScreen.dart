import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:login_dash_animation/animations/fadeAnimation.dart';
import 'package:login_dash_animation/screens/ReferralScreen.dart';
import 'package:login_dash_animation/screens/allridesScreen.dart';
import 'package:login_dash_animation/screens/historyScreen.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:login_dash_animation/screens/rideShare.dart';
import 'package:login_dash_animation/screens/walletScreen.dart';
import 'package:login_dash_animation/src/scoped-model/allride_model.dart';
import 'package:login_dash_animation/widgets/AllRides.dart';
import 'package:login_dash_animation/widgets/headerWidget.dart';
import 'package:login_dash_animation/widgets/popularBeaches.dart';
import 'package:login_dash_animation/widgets/searchWidget.dart';
import 'package:login_dash_animation/widgets/videoWidget.dart';
import 'package:login_dash_animation/screens/ProfileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashScreen extends StatefulWidget {

  final AllrideModel allrideModel;
   DashScreen({this.allrideModel});

// final VoidCallback signOut;

//   DashScreen(this.signOut);

  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  // int pageIndex = 1;

  //   signOut() {
  //   setState(() {
  //     widget.signOut();
  //   });
  // }

  final LoginScreen _dashScreen =  LoginScreen();
  final ProfilePage _profilePage = new ProfilePage();
  final ReferralPage _referralPage = new ReferralPage();
  final WalletPage _walletPage = new WalletPage();

   Widget _showPage = new LoginScreen();



  SharedPreferences sharedPreferences;

  String name = "", phone = "", email = "";


  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
       widget.allrideModel.fetchAllrides();
      name = sharedPreferences.getString("name");
      email= sharedPreferences.getString("email");
      phone= sharedPreferences.getString("phone");
    });
  //  print(email);
  //  print(name);

  }



  Widget _pageChooser(int page){
        switch (page) {
            case 0:
            return _dashScreen;
            break;
             case 1:
            return _profilePage;
            break;
             case 2:
            return _referralPage;
            break;
             case 3:
            return _walletPage;
            break;
            default: 
            return new Container(
              child:  new Center(
                child: new Text(
                  ' Noosafdo ', 
                  style: new TextStyle(fontSize: 30),
                 ),
              ),
            );
        }
  }


  // int _cIndex = 0;

  // void _incrementTab(index) {
  //   setState(() {
  //     _cIndex = index;
  //   });
  // }

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // appConfig = AppConfig(context);
       getCredential();
    final drawerHeader = UserAccountsDrawerHeader(
      // accountName: Text('User Name'),
      // accountEmail: Text('user.name@email.com'),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 42.0),
        backgroundColor: Colors.white,
      ),
      otherAccountsPictures: <Widget>[
        CircleAvatar(
          child: Text('A'),
          backgroundColor: Colors.yellow,
        ),
        CircleAvatar(
          child: Text('B'),
          backgroundColor: Colors.red,
        )
      ],
    );
    final drawerItems = ListView(
      children: <Widget>[   
        drawerHeader,
        ListTile(
          title: Text('To page 1'),
          onTap: () => [],
        ),
        ListTile(
          title: Text('To page 2'),
          onTap: () =>[],
        ),
        ListTile(
          title: Text('other drawer item'),
          onTap: () {},
        ),
      ],
    );
    return Scaffold(
      body: SafeArea(
        // child: _showPage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeAnimation(1.4, HeaderWidget()),
            SizedBox(height: 15),
            FadeAnimation(1.6,SearchWidget()),
            SizedBox(height: 15),
            FadeAnimation(1.8,RideSHar()),
            SizedBox(height: 15),
            
            // FadeAnimation(2,VideoWidget())
          ],
        ),
        
      ),
     key: _scaffoldKey,
      
      

      //  bottomNavigationBar:BottomNavigationBar(
      //   currentIndex: _cIndex,
      //   type: BottomNavigationBarType.fixed ,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home,color: Color.fromARGB(255, 0, 0, 0)),
      //       title: new Text('Home')
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person,color: Color.fromARGB(255, 0, 0, 0)),
      //       title: new Text('profile')
      //     )
      //   ],
      //   onTap: (index){
      //       _incrementTab(index);
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: new FloatingActionButton(
      //   onPressed:() => _scaffoldKey.currentState.openDrawer(),
      //   tooltip: 'Increment',
      //   child: new Icon(Icons.more),
      // ), 

      

      // floatingActionButton: FloatingActionButton(
      //   // onPressed: (){},
      //   onPressed: () => _scaffoldKey.currentState.openDrawer(),
      //   child:Icon(Icons.menu),
      // ),  
    );
  }
  
}