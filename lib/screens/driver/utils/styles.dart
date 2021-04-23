import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStyles {
  static final smallTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Color(0xff303030),
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );

  static final mediumTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Color(0xff303030),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  );

  static final normalTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Color(0xff303030),
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardBoldTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardBoldDarkTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardNormalTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  static final cardNormalDarkTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
}
