import 'package:flutter/material.dart';
import 'package:login_dash_animation/models/allavailableridesModel.dart';
import 'package:login_dash_animation/src/data/allride_data.dart';
import 'package:login_dash_animation/src/data/food_data.dart';
import 'package:login_dash_animation/src/models/food_model.dart';
import 'package:login_dash_animation/widgets/bought_foods.dart';
import 'package:login_dash_animation/widgets/food_category.dart';
import 'package:login_dash_animation/widgets/home_top_info.dart';
import 'package:login_dash_animation/widgets/search_file.dart';




class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  List<AllavailableridesModel> _allavailableridesModel = allrides;
  

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        children: <Widget>[
          HomeTopInfo(),
          FoodCategory(),
          SizedBox(height: 20.0,),
          SearchField(),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently Bought Foods",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: (){},
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
          Column(
            children: _allavailableridesModel.map(_buildFoodItems).toList(),
          ),
        ],
      ),
    );
  }

    Widget _buildFoodItems(AllavailableridesModel allavailableridesModel){
    // return Container(
    //     margin: EdgeInsets.only(bottom: 20.0),
    //     child: BoughtFood(
    //      id: allavailableridesModel.id,
    //     name: allavailableridesModel.driverName,
    //     imagePath: allavailableridesModel.driverImage,
    //     category: allavailableridesModel.carModel,
    //     discount: allavailableridesModel.driverNumber,
    //     price: allavailableridesModel.seatCost,
    //     ),
    //   );
  }

}