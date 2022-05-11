import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/pages/timeblock_adding_page.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';

import '../../locator.dart';
import '../../navigation-service.dart';
import '../resources/routes_manager.dart';
import '../shared/menu_drawer.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
            drawer: MenuDrawer(
              permanentlyDisplay: !sizingInformation.isMobile,
            ),
            endDrawer: TimeblockPage(),
            body: CenteredView(
              child: Column(
                children: [
                  NavigationBar(),
                  Expanded(
                    child: Navigator(
                      key: locator<NavigationService>().navigatorKey,
                      onGenerateRoute: RouteGenerator.getRoute,
                      initialRoute: Routes.overviewRoute,
                    ),
                  ),
                ],
              ),
            )));
  }
}

class CenteredView extends StatelessWidget {
  final Widget child;
  const CenteredView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: child,
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(),
      tablet: NavigationBarTabletDesktop(),
      desktop: NavigationBarTabletDesktop(),
    );
  }
}

class NavigationBarMobile extends StatelessWidget {
  const NavigationBarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () async => Scaffold.of(context).openDrawer(),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async => Scaffold.of(context).openEndDrawer(),
          )
          //NavBarLogo()
        ],
      ),
    );
  }
}

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async => Scaffold.of(context).openEndDrawer(),
            )
          ]),
    );
  }
}
