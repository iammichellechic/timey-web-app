import './values_manager.dart';
import './color_manager.dart';
import './font_manager.dart';
import './styles_manager.dart';

import 'package:flutter/material.dart';

ThemeData getAppTheme() {
  return ThemeData(
      //main colors of the app
      primaryColor: ColorManager.primaryWhite,
      primaryColorDark: ColorManager.black,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),

      //app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primaryWhite,
          titleTextStyle:
              getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20)),
      //sign up
      buttonTheme: ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: ColorManager.grey,
        buttonColor: ColorManager.black,
      ),

      //form button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
      //         primary: ColorManager.blue,
          textStyle: getBoldStyle(color: ColorManager.primaryWhite),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero))),

      //text theme
      textTheme: TextTheme(
        //menu drawer
        headline1:
            getBoldStyle(color: ColorManager.black, fontSize: FontSize.s24),
        headline2: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s20),
        headline3: getBoldStyle(color: ColorManager.grey,fontSize: FontSize.s20),
        subtitle1:
            getBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
        subtitle2: getBoldStyle(color: ColorManager.grey, fontSize: FontSize.s16),
        caption: getRegularStyle(color: ColorManager.grey),
        bodyText1:  getBoldStyle(color: ColorManager.black),
        bodyText2:  getBoldStyle(color: ColorManager.grey)
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getBoldStyle(color: ColorManager.grey, fontSize: FontSize.s16),

        // label style
        labelStyle: getBoldStyle(color: ColorManager.grey, fontSize: FontSize.s16),
        // error style
        errorStyle: getBoldStyle(color: ColorManager.error, fontSize: FontSize.s16),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.blue, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.blue, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
