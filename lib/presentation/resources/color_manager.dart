import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryWhite = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#000000");
  static Color grey = HexColor.fromHex("#8B8989");
  static Color blue = HexColor.fromHex("#1A72F8");
  static Color error = HexColor.fromHex("#e61f34"); // red color
  static Color lightBlue = HexColor.fromHex("#F0FFFF");
  static Color blueAccent = HexColor.fromHex("#42C2FF");
  static Color lighterBlue = HexColor.fromHex("#B8FFF9");
  
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
