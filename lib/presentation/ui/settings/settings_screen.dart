import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSettingsWidget(context);
  }
}

@override
Widget buildSettingsWidget(BuildContext context) {
  return SizedBox(child: Center(child: Text('This is the settings section')));
}
