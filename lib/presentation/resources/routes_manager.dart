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
        return _GeneratePageRoute(
          widget: OverView(),
          routeName: routeSettings.name!,
        );
      case Routes.calendarRoute:
        return _GeneratePageRoute(
          widget: CalendarWidget(),
          routeName: routeSettings.name!,
        );
      case Routes.tableRoute:
        return _GeneratePageRoute(
          widget: EditablePage(),
          routeName: routeSettings.name!,
        );
      case Routes.formRoute:
        return _GeneratePageRoute(
          widget: TimeblockPage(),
          routeName: routeSettings.name!,
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

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 200),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                textDirection: TextDirection.ltr,
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
