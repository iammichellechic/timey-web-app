import './color_manager.dart';
import 'package:flutter/material.dart';
import 'styles_manager.dart';
import './font_manager.dart';
import 'values_manager.dart';

//light theme
ThemeData getdarkAppTheme() {
  return ThemeData(
      //main color of the app
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.darkPrimary,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.grey.shade900,

      //icon theme
      iconTheme: IconThemeData(color: ColorManager.darkOnPrimaryContainer),

      //
      buttonTheme: ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: ColorManager.darkPrimaryContainer,
        buttonColor: ColorManager.darkPrimary,
      ),

      //text theme
      textTheme: TextTheme(
          //menu drawer
          headline1: getBoldStyle(
              color: ColorManager.darkOnPrimaryContainer,
              fontSize: FontSize.s24),
          headline2: getBoldStyle(
              color: ColorManager.darkOnPrimaryContainer,
              fontSize: FontSize.s20),
          headline3: getBoldStyle(
              color: ColorManager.darkOnPrimaryContainer,
              fontSize: FontSize.s20),
          headline4:
              getRegularStyle(color: ColorManager.darkOnPrimaryContainer),
          headline5: getRegularStyle(color: ColorManager.darkError),
          headline6: getRegularStyle(color: ColorManager.darkOnPrimary),
          subtitle1: getBoldStyle(
              color: ColorManager.darkOnPrimaryContainer,
              fontSize: FontSize.s16),
          subtitle2:
              getBoldStyle(color: ColorManager.grey, fontSize: FontSize.s16),
          caption: getRegularStyle(color: ColorManager.darkPrimary),
          bodyText1: getBoldStyle(
              color: ColorManager.darkOnPrimaryContainer,
              fontSize: FontSize.s14),
          bodyText2:
              getBoldStyle(color: ColorManager.grey, fontSize: FontSize.s12)),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getBoldStyle(
            color: ColorManager.darkSecondary, fontSize: FontSize.s16),

        // label style
        labelStyle: getBoldStyle(
            color: ColorManager.darkSecondary, fontSize: FontSize.s16),
        // error style
        errorStyle:
            getBoldStyle(color: ColorManager.darkError, fontSize: FontSize.s16),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.darkOnSecondaryContainer,
                width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.darkSecondary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.darkError, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.darkOnErrorContainer, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
