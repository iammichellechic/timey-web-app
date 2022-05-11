import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '/presentation/pages/timeblock_adding_page.dart';
import '/presentation/screens/calendar_screen.dart';
import '/presentation/screens/chart_overview_screen.dart';
import '/presentation/screens/table_timeblock_screen.dart';

class Routes {
  //temporary names
  static const String overviewRoute = "/dashboard";
  static const String calendarRoute = "/timereports";
  static const String tableRoute = "/timereports-list";
  static const String formRoute = "/edit-timereport";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.overviewRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(seconds: 1),
          child: OverView(),
          settings: routeSettings,
        );
      case Routes.calendarRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(seconds: 1),
          child: CalendarWidget(),
          settings: routeSettings,
        );
      case Routes.tableRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(seconds: 1),
          child: EditablePage(),
          settings: routeSettings,
        );
      case Routes.formRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(seconds: 1),
          child: TimeblockPage(),
          settings: routeSettings,
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text("No Route Found"),
              ),
              body: Center(child: Text("No Route Found")),
            ));
  }
}
