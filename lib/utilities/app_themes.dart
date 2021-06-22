import 'package:flutter/material.dart';
import 'package:lo_rent/constants.dart';

class AppThemes {
  static ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      primaryColor: kPrimaryColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0, foregroundColor: Colors.white),
      brightness: Brightness.light,
      accentColor: kAccentColor,
      dividerColor: kAccentColor.withOpacity(0.1),
      focusColor: kAccentColor,
      hintColor: kSecondaryColor,
      colorScheme: ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kPrimaryColor,
      ),
      textSelectionTheme: TextSelectionThemeData().copyWith(
        selectionColor: Colors.blue[200],
        selectionHandleColor: Colors.blue[300],
        cursorColor: Colors.blue,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15.0,
          fontWeight: FontWeight.w700,
          color: Colors.deepPurple[400],
          height: 1.3,
        ),
        headline5: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: kSecondaryColor,
            height: 1.3),
        headline4: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: kSecondaryColor,
            height: 1.3),
        headline3: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: kSecondaryColor,
            height: 1.3),
        headline2: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            color: kPrimaryColor,
            height: 1.4),
        headline1: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24.0,
            fontWeight: FontWeight.w300,
            color: kSecondaryColor,
            height: 1.4),
        subtitle2: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            color: kSecondaryColor,
            height: 1.2),
        subtitle1: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            color: kPrimaryColor,
            height: 1.2),
        bodyText2: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: kSecondaryColor,
            height: 1.2),
        bodyText1: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: kSecondaryColor,
            height: 1.2),
        caption: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            color: kHintTextColor,
            height: 1.2),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData.dark().copyWith();
  }
}
