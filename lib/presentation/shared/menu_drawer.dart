import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/resources/font_manager.dart';
import 'package:timey_web/presentation/resources/styles_manager.dart';
import 'package:timey_web/presentation/widgets/switch_theme_button_widget.dart';

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
                  ? MediaQuery.of(context).size.width * 0.18
                  : MediaQuery.of(context).size.width,
              child: Drawer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(context),
                    buildNavItems(context),
                    Spacer(),
                    Divider(
                      indent: AppMargin.m12,
                      endIndent: AppMargin.m12,
                    ),
                    buildUserProfile(context),
                    SwitchThemeButtonWidget(),
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
        leading: Icon(icon, color: color),
        title: Text(text,
            style: makeYourOwnBoldStyle(fontSize: FontSize.s16, color: color)),
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

    return Container(
        padding: safeArea,
        height: 100,
        child: DrawerHeader(
            child: Container(
          padding: EdgeInsets.only(left: AppPadding.p30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('ZERO8', style: Theme.of(context).textTheme.headline1),
          ),
        )));
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
                  ),
                ),
                SizedBox(width: AppSize.s12),
                Flexible(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SelectableText(
                      'Dev. Rick Morty.',
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
