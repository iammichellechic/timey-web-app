import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryWhite = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#101010");
  static Color grey = HexColor.fromHex("#A8AFBD");
  static Color blue = HexColor.fromHex("#2984FF");
  static Color error = HexColor.fromHex("#E61f34"); // red color
  static Color lightBlue = HexColor.fromHex("#F0FFFF"); //scaffold background
  static Color orange = HexColor.fromHex("#FE774E");

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
