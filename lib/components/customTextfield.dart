import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String label;
  final String hintText;
  final Widget icon;
  final bool isPassword;
  final TextEditingController isControll;
  final TextInputType iskeyboardType;
  final  isonChanged;
  final String initialValue;

  const CustomTextField({Key key, this.label, this.isControll, this.iskeyboardType, this.isonChanged, this.initialValue, this.hintText, this.icon, this.isPassword = false}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(color: Color(0xFFF234253),fontWeight: FontWeight.bold),
        obscureText: isPassword,
        controller: isControll,
        keyboardType: iskeyboardType,
        onChanged: isonChanged,
        initialValue: initialValue,
        decoration: InputDecoration(
          
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)
          ),
           enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)
          ),
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFFF234253),fontWeight: FontWeight.bold),
          suffixIcon: icon
        ),
        
    );
  }
}