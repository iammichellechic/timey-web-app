import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/resources/font_manager.dart';
import 'package:timey_web/presentation/resources/styles_manager.dart';

import '../../data/providers/navigation_items.dart';
import '../../locator.dart';
import '../../model/nav_items.dart';
import '../../services/navigation_service.dart';
import '../../navigation/routes_manager.dart';
import '/presentation/resources/color_manager.dart';

import '../resources/values_manager.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({required this.permanentlyDisplay, Key? key})
      : super(key: key);

  final bool permanentlyDisplay;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) => Container(
              color: ColorManager.background,
              width: sizingInformation.isDesktop
                  ? MediaQuery.of(context).size.width * 0.15
                  : MediaQuery.of(context).size.width,
              child: Drawer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildHeader(context),
                    buildNavItems(context),
                    Spacer(),
                    Divider(
                      indent: AppMargin.m12,
                      endIndent: AppMargin.m12,
                    ),
                    buildUserProfile(context),
                    const SizedBox(height: 12),
                    if (permanentlyDisplay)
                      VerticalDivider(
                        width: 1,
                      ),
                  ],
                ),
              ),
            ));
  }

  Widget buildNavItems(BuildContext context) {
    return Wrap(
      runSpacing: AppSize.s12,
      children: [
        buildMenuItem(
          context,
          item: NavigationItem.dashboard,
          text: 'Overview',
          icon: Icons.home,
        ),
        buildMenuItem(
          context,
          item: NavigationItem.calendar,
          text: 'Calendar',
          icon: Icons.calendar_month,
        ),
        buildMenuItem(
          context,
          item: NavigationItem.table,
          text: 'Table',
          icon: Icons.table_chart,
        ),
        buildMenuItem(
          context,
          item: NavigationItem.payments,
          text: 'Payment',
          icon: Icons.payment,
        ),
        Divider(
          indent: AppMargin.m12,
          endIndent: AppMargin.m12,
        ),
        buildMenuItem(
          context,
          item: NavigationItem.settings,
          text: 'Settings',
          icon: Icons.tune,
        ),
      ],
    );
  }

  Widget buildMenuItem(
    BuildContext context, {
    required NavigationItem item,
    required String text,
    required IconData icon,
  }) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;

    final color =
        isSelected ? Theme.of(context).colorScheme.primary : ColorManager.grey;
    final shape = isSelected
        ? Border(
            left: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 5))
        : null;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        shape: shape,
        selected: isSelected,
        selectedTileColor: Colors.white24,
        leading: Icon(icon, color: color, size: FontSize.s16),
        title: Text(text,
            style:
                makeYourOwnRegularStyle(fontSize: FontSize.s16, color: color)),
        onTap: () => selectItem(context, item),
      ),
    );
  }

  dynamic selectItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);

    switch (provider.navigationItem) {
      case NavigationItem.header:
        return locator<NavigationService>().navigateTo(Routes.overviewRoute);
      case NavigationItem.dashboard:
        return locator<NavigationService>().navigateTo(Routes.overviewRoute);
      case NavigationItem.calendar:
        return locator<NavigationService>().navigateTo(Routes.calendarRoute);
      case NavigationItem.table:
        return locator<NavigationService>().navigateTo(Routes.tableRoute);
      case NavigationItem.settings:
        return locator<NavigationService>().navigateTo(Routes.settingsRoute);
      case NavigationItem.login:
        return locator<NavigationService>().navigateTo(Routes.loginRoute);
      case NavigationItem.payments:
        return locator<NavigationService>().navigateTo(Routes.paymentRoute);
    }
  }

  Widget buildHeader(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) =>
          Container(
              padding: safeArea,
              height: 100,
              child: DrawerHeader(
                  child: SizedBox(
                child: Column(
                  children: [
                    if (sizingInformation.isMobile)
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              //_navigationService.goBack();
                              Scaffold.of(context).closeDrawer();
                            }),
                      ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppPadding.p12),
                        child: Text('ZERO8 AB',
                            style: Theme.of(context).textTheme.headline1),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

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
                ],
              )),
        ),
      );
}
