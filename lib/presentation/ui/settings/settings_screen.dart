import 'package:flutter/material.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/widgets/switch_theme_button_widget.dart';

import '../../widgets/icon_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          buildHeader(context),
          const SizedBox(height: 32),
          buildUserProfile(context),
          buildDarkMode(context),
        ],
      );

  Widget buildHeader(BuildContext context) => Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text('Settings', style: Theme.of(context).textTheme.headline1),
      ));

  Widget buildDarkMode(BuildContext context) => ListTile(
        leading: IconWidget(
          icon: Icons.light_mode,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text('Theme'),
        trailing: SwitchThemeButtonWidget(),
      );

  Widget buildUserProfile(BuildContext context) => Material(
        child: Center(
          child: Container(
              padding: EdgeInsets.all(AppPadding.p18),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                  ),
                  SizedBox(height: AppSize.s8),
                  Text(
                    'Dev. Obi-Wan',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Full-Stack',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Align(
                    alignment:Alignment.centerRight,
                    child: Icon(Icons.chevron_right_sharp)),
                ],
              )),
        ),
      );
}
