import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class TotalReportedTimeWidget extends StatelessWidget {
  final String label;
  final String text;

  const TotalReportedTimeWidget({Key? key,required this.label, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
        width: AppSize.s250,
        height: AppSize.s60,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ]),
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 15),
          title: Text(label,
              style: makeYourOwnRegularStyle(
                  letterSpacing: 1.2,
                  fontSize: FontSize.s12,
                  color: ColorManager.grey)),
          subtitle: Text(text,
              style: makeYourOwnBoldStyle(
                  fontSize: FontSize.s16,
                  color: Theme.of(context).colorScheme.onSecondaryContainer)),
        ));
  }
}
