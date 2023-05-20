import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: kPrimaryColor,
      accentColor: kSecondaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        headline1: GoogleFonts.poppins().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
        headline6: GoogleFonts.poppins().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
        bodyText1: GoogleFonts.poppins().copyWith(
          fontSize: 16,
          color: kPrimaryColor,
        ),
        bodyText2: GoogleFonts.poppins().copyWith(
          fontSize: 14,
          color: kPrimaryColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: kPrimaryColor,
      accentColor: kSecondaryColor,
      scaffoldBackgroundColor: kBlackColor,
      appBarTheme: AppBarTheme(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        headline1: GoogleFonts.poppins().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline6: GoogleFonts.poppins().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyText1: GoogleFonts.poppins().copyWith(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyText2: GoogleFonts.poppins().copyWith(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
