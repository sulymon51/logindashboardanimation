import 'package:flutter/material.dart';
// import 'package:flutter_taxi_app_driver/theme/style.dart';
import 'package:flutter/services.dart';
import 'package:login_dash_animation/models/profilePicmodel.dart';
import 'package:login_dash_animation/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InviteFriends extends StatefulWidget {
  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  final keyScaffold = new GlobalKey<ScaffoldState>();
  SharedPreferences sharedPreferences;

  String name = "", phone = "", email = "", id = "", profilepic = "";

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString("name");
      phone = sharedPreferences.getString("phone");
      email = sharedPreferences.getString("email");
      id = sharedPreferences.getString("id");
      profilepic = sharedPreferences.getString("profilepic");
    });
  }

  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    getCredential();
    super.initState();
    
  }

  Future<List<ProfilePic>> alridezpp() async {
    String url = "https://ridezmyway.com/apiall/profilepic.php?id=" + id;
    final response = await http.get(url);
    print(response.body);
    return profilePicFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Invite Friends',
          style: TextStyle(color: whiteColor),
        ),
//        leading: IconButton(
//          icon: Icon(Icons.arrow_back_ios,color: blackColor,),
//          onPressed: () => Navigator.of(context).pushReplacement(
//              new MaterialPageRoute(builder: (context) => LoginScreen2())),
//        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            screenSize.width * 0.13, 0.0, screenSize.width * 0.13, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(100.0),
                child: new ClipRRect(
                    borderRadius: new BorderRadius.circular(100.0),
                    child: new Container(
                        color: Colors.deepOrange,
                        height: 180.0,
                        width: 180.0,
                        child: Icon(
                          Icons.supervisor_account,
                          color: whiteColor,
                          size: 100.0,
                        ))),
              ),
            ),
            Container(
              child: Text(
                "Invite Family & Friends",
                style: headingBlack,
              ),
            ),
            Container(
              child: Text(
                "Earn up to 5% of their transactions to build your wallet amount",
                style: heading18Black,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
              child: Text(
                "When your family & friends sign up with your referral code, you can earn up to 5% of their transactions amount always.", 
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            FutureBuilder(
              future: alridezpp(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        ProfilePic profilePic = snapshot.data[index];
                        return Container(
                          width: double.infinity,
                          height: 45.0,
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onLongPress: () {
                                Clipboard.setData(new ClipboardData(
                                    text: '"${profilePic.referralId}"'));
                              },
                              child: Text(
                                "${profilePic.referralId}",
                                style: heading18Black,
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                //return  a circular progress indicator.
                return Center(child: new CircularProgressIndicator());
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            new ButtonTheme(
              height: 45.0,
              minWidth: MediaQuery.of(context).size.width,
              child: RaisedButton.icon(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                elevation: 0.0,
                color: Colors.deepOrange,
                icon: new Text(''),
                label: new Text(
                  'INVITE',
                  style: headingWhit,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
