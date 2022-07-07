import 'package:flutter/material.dart';

import 'package:timey_web/presentation/resources/values_manager.dart';

class SnackBarUtils {
  static void showSnackBar(
      {BuildContext? context,
      required String text,
      required Color color,
      IconData? icons,
      TextStyle? style,
      Color? iconColor
      }) {
    final snackBar = SnackBar(
        content: Row(
          children: <Widget>[
            Icon(
              icons,
              color: iconColor,
            ),
            SizedBox(width: AppSize.s16),
            Text(text, style: style),
          ],
        ),
        duration: Duration(seconds: 3),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ));
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }
}
