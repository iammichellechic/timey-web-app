import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryWhite = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#101010");
  static Color grey = HexColor.fromHex("#A8AFBD");
  static Color blue = HexColor.fromHex("#2984FF");
  static Color red = HexColor.fromHex("#E61f34"); // red color
  static Color lightBlue = HexColor.fromHex("#F0FFFF"); //scaffold background
  static Color orange = HexColor.fromHex("#FE774E");

  //colors from color theme builder
  //light theme
  static Color primary = Color(0xFF005BBD);
  static Color onPrimary = Color(0xFFFFFFFF);
  static Color primaryContainer = Color(0xFFD7E2FF); //drawer
  static Color onPrimaryContainer = Color(0xFF001A40); //icons and text
  static Color secondary = Color(0xFF565E71);
  static Color onSecondary = Color(0xFFFFFFFF);
  static Color secondaryContainer = Color(0xFFDAE2F9);
  static Color onSecondaryContainer = Color(0xFF131C2C);
  static Color tertiary = Color(0xFF705574);
  static Color onTertiary = Color(0xFFFFFFFF);
  static Color tertiaryContainer = Color(0xFFFBD7FC);
  static Color onTertiaryContainer = Color(0xFF29132E);
  static Color error = Color(0xFFBA1A1A);
  static Color errorContainer = Color(0xFFFFDAD6);
  static Color onError = Color(0xFFFFFFFF);
  static Color onErrorContainer = Color(0xFF410002);
  static Color background = Color(0xFFFEFBFF);
  static Color onBackground = Color(0xFF1B1B1F);
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
