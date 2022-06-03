import 'package:flutter/material.dart';
import 'package:timey_web/presentation/resources/color_manager.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';

class SnackBarUtils {
  static void showSnackBar(
      {BuildContext? context,
      required String text,
      required Color color,
      IconData? icons,
      }) {
    final snackBar = SnackBar(
        content: Row(
          children: <Widget>[
            Icon(
              icons,
              color: ColorManager.error,
            ),
            SizedBox(width: AppSize.s16),
            Text(text, style: Theme.of(context!).textTheme.headline5),
          ],
        ),
        duration: Duration(seconds: 3),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
