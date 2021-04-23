import 'package:flutter/material.dart';
import 'package:login_dash_animation/models/allavailableridesModel.dart';
import 'package:login_dash_animation/models/allrides.dart';
import 'package:login_dash_animation/screens/allridesScreen.dart';
import 'package:login_dash_animation/screens/driver/location.dart';
import 'package:login_dash_animation/screens/driver/mappage.dart';
import 'package:login_dash_animation/screens/rideShare.dart';
import 'package:login_dash_animation/src/data/allride_data.dart';
import 'package:login_dash_animation/src/data/food_data.dart';
import 'package:login_dash_animation/src/models/food_model.dart';
import 'package:login_dash_animation/src/scoped-model/allride_model.dart';
import 'package:login_dash_animation/widgets/allridesmodel.dart';
import 'package:login_dash_animation/widgets/bought_foods.dart';
import 'package:login_dash_animation/widgets/food_category.dart';
import 'package:login_dash_animation/widgets/headerWidget.dart';
import 'package:login_dash_animation/widgets/home_top_info.dart';
import 'package:login_dash_animation/widgets/search_file.dart';




class HomePage extends StatefulWidget {
  final AllrideModel allrideModel;

  HomePage(this.allrideModel);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AllavailableridesModel> _allavailableridesModel1 = allrides;

  @override
  void initState() {
    // widget.allrideModel.fetchAllrides();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        children: <Widget>[
          HeaderWidget(),
          // FoodCategory(),
          SizedBox(
            height: 10.0,
          ),
          SearchField(),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently Ridez",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("I' pressed");
                },
                child: Text(
                  "View all",
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          // UserDashboard(),
          // RideSHar(),
         
            
        ],
      ),
    );
  }

}
