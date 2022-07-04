import './values_manager.dart';
import './color_manager.dart';
import './font_manager.dart';
import './styles_manager.dart';

import 'package:flutter/material.dart';

//light theme
ThemeData getlightAppTheme() {
  return ThemeData(
      //main color of the app
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.primary,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: ColorManager.lightBlue.withOpacity(0.5),

      //icon theme
      iconTheme: IconThemeData(color: ColorManager.onPrimaryContainer),

      //app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          titleTextStyle: getBoldStyle(
              color: ColorManager.onPrimary, fontSize: FontSize.s20)),
      //
      buttonTheme: ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: ColorManager.primaryContainer,
        buttonColor: ColorManager.primary,
      ),

      //form button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: ColorManager.primary,
              textStyle: getBoldStyle(color: ColorManager.onPrimary),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero))),

      //text theme
      textTheme: TextTheme(
        //menu drawer
        headline1: getBoldStyle(
            color: ColorManager.onPrimaryContainer, fontSize: FontSize.s24,letterSpacing: 1.3),

        headline2: getBoldStyle(
            color: ColorManager.onPrimaryContainer, fontSize: FontSize.s20),
        headline3: getBoldStyle(
            color: ColorManager.onPrimaryContainer, fontSize: FontSize.s20),

        headline4: getRegularStyle(color: ColorManager.onPrimaryContainer),
        headline5: getRegularStyle(color: ColorManager.error),
        headline6: getRegularStyle(color: ColorManager.onPrimary),
        subtitle1: getBoldStyle(
            color: ColorManager.onPrimaryContainer, fontSize: FontSize.s16),
        subtitle2:
            getBoldStyle(color: ColorManager.grey, fontSize: FontSize.s16),
        caption: getRegularStyle(color: ColorManager.primary),
        bodyText1:
            getBoldStyle(color: ColorManager.onPrimaryContainer, fontSize: FontSize.s14),
        bodyText2:
            getBoldStyle(color: ColorManager.grey, fontSize: FontSize.s12),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle:
            getBoldStyle(color: ColorManager.secondary, fontSize: FontSize.s16),

        // label style
        labelStyle:
            getBoldStyle(color: ColorManager.secondary, fontSize: FontSize.s16),
        // error style
        errorStyle:
            getBoldStyle(color: ColorManager.error, fontSize: FontSize.s16),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.onSecondaryContainer, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.secondary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.onErrorContainer, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
