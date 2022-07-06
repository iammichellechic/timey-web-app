import 'package:flutter/material.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/widgets/switch_theme_button_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSettingsWidget(context);
  }
}

@override
Widget buildSettingsWidget(BuildContext context) {
  return SizedBox(
      child: Align(
        alignment: Alignment.center,
      child: Row(
    children: [
      Text('Theme'),
      const SizedBox(width: AppSize.s30),
      SwitchThemeButtonWidget(),
    ],
  )));
}
