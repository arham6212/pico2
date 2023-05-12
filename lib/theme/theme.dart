import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextTheme buildTextTheme(TextTheme base) {
  var newBase = GoogleFonts.poppinsTextTheme();
  return newBase
      .copyWith(
        headline3: newBase.headline3
            ?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
        headline1: newBase.headline1?.copyWith(color: Colors.white),
        headline2: newBase.headline2?.copyWith(color: Colors.white),
        headline4: newBase.headline4?.copyWith(color: Colors.white),
        headline5: newBase.headline5
            ?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
        bodyText2: newBase.bodyText2?.copyWith(color: Colors.white),
        headline6: newBase.headline6?.copyWith(fontSize: 18.0),
        caption: newBase.caption?.copyWith(
            fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.white),
        subtitle1: newBase.subtitle1?.copyWith(
            fontWeight: FontWeight.w400, fontSize: 16.0, color: Colors.white),
        subtitle2: newBase.subtitle2?.copyWith(
            fontWeight: FontWeight.w400, fontSize: 12.0, color: Colors.white),
        button: newBase.button?.copyWith(
            fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.white),
      )
      .copyWith(
        headline1: GoogleFonts.poppinsTextTheme()
            .headline1
            ?.copyWith(color: Colors.white),
        headline2: GoogleFonts.poppinsTextTheme().headline2?.copyWith(),
        headline5: GoogleFonts.poppinsTextTheme().headline5?.copyWith(),
        headline6: GoogleFonts.poppinsTextTheme().headline6?.copyWith(),
      );
}

ThemeData buildDarkTheme() {
  final base = ThemeData.dark().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  return base.copyWith(
      brightness: Brightness.dark,
      cardColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      errorColor: Colors.red,
      textTheme: buildTextTheme(base.textTheme),
      primaryTextTheme: buildTextTheme(base.primaryTextTheme),
      hintColor: Colors.black26,
      backgroundColor: Colors.black87,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: kBlackColor,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: kPrimaryColor,
          toolbarTextStyle: const TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
          ).bodyText2,
          titleTextStyle: const TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
          ).headline6),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      }),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: kThemeOrangeColor,
        selectionColor: Colors.white,
        selectionHandleColor: kThemeOrangeColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: kThemeOrangeColor, foregroundColor: Colors.white),
      tabBarTheme: TabBarTheme(
        labelColor: kBlackColor,
        unselectedLabelColor: kBlackColor,
        labelPadding: EdgeInsets.zero,
        labelStyle: const TextStyle(fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontSize: 13),
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: kBlackColor));
}
