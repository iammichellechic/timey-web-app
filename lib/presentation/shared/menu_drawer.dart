import 'package:flutter/material.dart';
import 'package:timey_web/presentation/resources/routes_manager.dart';
import '/presentation/resources/color_manager.dart';

import '../resources/values_manager.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({required this.permanentlyDisplay, Key? key})
      : super(key: key);

  final bool permanentlyDisplay;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildNavItems(context),
          Spacer(),
          Divider(
            color: ColorManager.grey,
          ),
          buildUserProfile(context),
          const SizedBox(height: 12),
          if (permanentlyDisplay)
            const VerticalDivider(
              width: 1,
            )
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    return Container(
        padding: safeArea,
        height: 100,
        child: DrawerHeader(
            child: Center(
          child: SelectableText('Timey',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1),
        )));
  }

  Widget buildNavItems(BuildContext context) {
    return Container(
        child: Wrap(
      children: [
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Overview', style: Theme.of(context).textTheme.subtitle1),
          onTap: () {
            var currentRoute = ModalRoute.of(context);
            var routeToOpen = Routes.overviewRoute;
            if (currentRoute != null &&
                currentRoute.settings.name != routeToOpen) {
              Navigator.of(context).pushReplacementNamed(routeToOpen);
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.calendar_month),
          title: Text('Calendar view',
              style: Theme.of(context).textTheme.subtitle1),
          onTap: () {
            var currentRoute = ModalRoute.of(context);
            var routeToOpen = Routes.calendarRoute;
            if (currentRoute != null &&
                currentRoute.settings.name != routeToOpen) {
              Navigator.of(context).pushReplacementNamed(routeToOpen);
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.table_chart),
          title:
              Text('Table view', style: Theme.of(context).textTheme.subtitle1),
          onTap: () {
            var currentRoute = ModalRoute.of(context);
            var routeToOpen = Routes.tableRoute;
            if (currentRoute != null &&
                currentRoute.settings.name != routeToOpen) {
              Navigator.of(context).pushReplacementNamed(routeToOpen);
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Payment Overview',
              style: Theme.of(context).textTheme.subtitle1),
          onTap: () => {},
        ),
        Divider(
          color: ColorManager.grey,
        ),
        ListTile(
          leading: Icon(Icons.tune),
          title: Text('Settings', style: Theme.of(context).textTheme.subtitle1),
          onTap: () => {},
        ),
      ],
    ));
  }

  Widget buildUserProfile(BuildContext context) => Material(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(AppPadding.p18),
            child: Row(
              children: [
                Flexible(
                  child: CircleAvatar(
                    radius: 30,
                    // backgroundImage: NetworkImage(),
                  ),
                ),
                SizedBox(width: AppSize.s12),
                Flexible(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SelectableText(
                      'Dev. Waleed H.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SelectableText(
                      'Full-Stack',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      );
}
