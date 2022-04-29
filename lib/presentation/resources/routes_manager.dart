import 'package:flutter/material.dart';
import 'package:timey_web_scratch/presentation/pages/timeblock_editing_page.dart';
import 'package:timey_web_scratch/presentation/screens/calendar_screen.dart';
import 'package:timey_web_scratch/presentation/screens/overview.dart';
import 'package:timey_web_scratch/presentation/screens/table_timeblock_screen.dart';

import 'strings_manager.dart';

class Routes {
  //temporary names
  static const String overviewRoute = "/";
  static const String calendarRoute = "/timereports";
  static const String tableRoute = "/timereports-list";
  static const String formRoute = "/edit-timereport";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.overviewRoute:
        return MaterialPageRoute(builder: (_) => OverView());
      case Routes.calendarRoute:
        return MaterialPageRoute(builder: (_) => CalendarWidget());
      case Routes.tableRoute:
        return MaterialPageRoute(builder: (_) => EditablePage());
      case Routes.formRoute:
        return MaterialPageRoute(builder: (_) => TimeblockPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound),
              ),
              body: Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
