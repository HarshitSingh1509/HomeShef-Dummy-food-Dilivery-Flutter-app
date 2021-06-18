import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: AppColors.black,
        primaryColorLight: AppColors.lightGray,
        accentColor: AppColors.red,
        bottomAppBarColor: AppColors.lightGray,
        backgroundColor: AppColors.background,
        dialogBackgroundColor: AppColors.backgroundLight,
        errorColor: AppColors.red,
        dividerColor: Colors.transparent);
  }
}

class AppColors {
  static const primaryColor = Color.fromRGBO(74,83,151, 1);
  static const toolbarColor = Color.fromRGBO(255, 255, 255, 1);
  static const appbarColor = Color.fromRGBO(249, 249, 249, 0.9);
  static const statusBarColor = Color.fromRGBO(255, 255, 255, 1);
  static const tabBarColor = Color.fromRGBO(255,105,105,1);
  static const darkGreen = Color.fromRGBO(90,150,160, 1);
  static const accentColor = Color(0xFFDB3022);
  static const bottomnavColor = Color(0xFFDB3022);
  static const snakBarBackErrorColor = Color(0xFFDB3022);
  static const snakBarBackColor = Color(0xFF222222);
  static const red = Color(0xFFDB3022);
  static const black = Colors.black;
  static const lightGray = Color(0xFFEEEEEE);
  static const darkGray = Color(0xFF979797);
  static const white = Color(0xFFFFFFFF);
  static const orange = Color(0xFFFFBA49);
  static const background = Color(0xFFE5E5E5);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const green =Color.fromRGBO( 121 ,200, 166,1);
  static const blue =Color.fromRGBO( 130, 198, 230,1);
  static const darkblue =Color.fromRGBO(9,107,145,1);
  static const clockIcon =Color.fromRGBO(85,157,236,1);
  static const lightpink =Color.fromRGBO(255,35,78,0.17);
  static const darkestGray =const Color(0xff515c6f);
  static const dark_grey=Color.fromRGBO(112, 112, 112, 1.0);
}

class FontFamily {
  static const String OpenSansRegular ='OpenSans-Regular';
  static const String OpenSansBold='OpenSans-Bold';
}