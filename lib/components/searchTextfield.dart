import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        style: TextStyle(color: Color(0xFFF234253),fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: "Search By Location",
          labelStyle: TextStyle(color: Color(0xFFF234353),fontWeight: FontWeight.bold),
          prefixIcon: Icon(Icons.search,size: 28),
          fillColor: Color(0xFFFeaf2f4),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(15)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12)
          )
        ),
    );
  }
}