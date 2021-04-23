import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_dash_animation/components/ink_well_custom.dart';
import 'package:login_dash_animation/components/listMenu.dart';
import 'package:login_dash_animation/models/profilePicmodel.dart';
import 'package:login_dash_animation/screens/Message/MessageScreen.dart';
import 'package:login_dash_animation/screens/Message/chatMessage.dart';
import 'package:login_dash_animation/screens/MyProfile/profile.dart';
import 'package:login_dash_animation/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'inviteFriends.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final String screenName = "SETTINGS";


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepOrange,
        title: Text('Settings',style: TextStyle(color: Colors.white),),
      ),
      // drawer: new MenuScreens(activeScreenName: screenName),
      body: 
      FutureBuilder(

        future: alridezpp(),
        builder: (context, snapshot) {
         if (snapshot.hasData) {
        return ListView.builder(
        // scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.length, 
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index){
        ProfilePic profilePic = snapshot.data[index];
         return
      SingleChildScrollView(
        child: InkWellCustom(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            color: backgroundColor,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return Profile();
                        },
                    ));
                  },
                  child: Container(
                    color: whiteColor,
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                    child: Row(
                      //mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(50.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: CachedNetworkImage(
                              imageUrl: '${profilePic.profilePic}',
                              fit: BoxFit.cover,
                              width: 50.0,
                              height: 50.0,
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.width-70 ,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text('${profilePic.fatherName}'+" "+'${profilePic.name}',style: textBoldBlack,),
                                    ),
                                    Container(
                                        child: Text("${profilePic.type}",style: TextStyle(
                                          fontSize: 12,
                                          color: greyColor2
                                        ),)
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.arrow_forward_ios,color: CupertinoColors.lightBackgroundGray,)
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
//                ListsMenu(
//                  title: "100 Point * Member",
//                  onPress: (){
//
//                  },
//                ),
                ListsMenu(
                  title: "Reviews",
                  icon: Icons.star,
                  backgroundIcon: Colors.cyan,
                  onPress: (){

                  },
                ),
                ListsMenu(
                  title: "Invite Friends",
                  icon: Icons.people,
                  backgroundIcon: primaryColor,
                  onPress: (){
                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return InviteFriends();
                        },
                        fullscreenDialog: true));
                  },
                ),
                ListsMenu(
                  title: "Notification",
                  icon: Icons.notifications_active,
                  backgroundIcon: primaryColor,
                  onPress: (){

                  },
                ),
                ListsMenu(
                  title: "Messages",
                  icon: Icons.description,
                  backgroundIcon: Colors.deepPurple,
                  onPress: () {
                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return Bubble();
                        },
                        fullscreenDialog: true));
                  },
                  
                  
                  
                ),
                ListsMenu(
                  title: "Contact us",
                  icon: Icons.help,
                  backgroundIcon: primaryColor,
                  onPress: (){

                  },
                ),
              ],
            )
          ),
        ),
      );
       }
     );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
                //return  a circular progress indicator.
                return Center(child: new CircularProgressIndicator());
              },
    )
    );
  }
    SharedPreferences sharedPreferences;

  String name = "", phone = "", email = "", id="", profilepic="";

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString("name");
       phone= sharedPreferences.getString("phone");
      email= sharedPreferences.getString("email");
       id= sharedPreferences.getString("id");
       profilepic= sharedPreferences.getString("profilepic");
    });
  }

  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCredential();
  }


 
Future<List<ProfilePic>>  alridezpp() async {
  String url = "https://ridezmyway.com/apiall/profilepic.php?id="+id;
  final response = await http.get(url);
    print(response.body);
  return profilePicFromJson(response.body);
 }
}
