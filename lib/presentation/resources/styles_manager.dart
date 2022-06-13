import 'package:flutter/material.dart';
import 'font_manager.dart';


TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color, double? height, double? letterSpacing ) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing);
}

TextStyle getBoldStyle({double fontSize = FontSize.s14, required Color color, double? height, double? letterSpacing}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.bold, color,height, letterSpacing);
}

TextStyle makeYourOwnBoldStyle({required double fontSize, required Color color,
    double? height,
    double? letterSpacing}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.bold, color, height, letterSpacing);
}

TextStyle getRegularStyle({double fontSize = FontSize.s14, required Color color,
    double? height,
    double? letterSpacing}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color, height, letterSpacing);
}

TextStyle makeYourOwnRegularStyle(
    {required double fontSize, required Color color,
    double? height,
    double? letterSpacing}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color, height, letterSpacing);
}


