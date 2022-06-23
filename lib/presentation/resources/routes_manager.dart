import 'package:flutter/material.dart';
import 'package:timey_web/presentation/ui/login/login.dart';
import 'package:timey_web/presentation/ui/payment/payment_screen.dart';
import 'package:timey_web/presentation/ui/signup/signup.dart';
import '../ui/chart/chart_overview_screen.dart';
import '../ui/form/timeblock_adding_page.dart';
import '../ui/calendar/calendar_screen.dart';
import '../ui/settings/settings_screen.dart';
import '../ui/table/table_timeblock_screen.dart';

class Routes {
  //temporary names
  static const String overviewRoute = "dashboard";
  static const String calendarRoute = "timereports";
  static const String tableRoute = "timereports-list";
  static const String formRoute = "edit-timereport";
  static const String loginRoute = "login";
  static const String signupRoute = "signup";
  static const String paymentRoute = "payment";
  static const String settingsRoute = "settings";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.overviewRoute:
        return _GeneratePageRoute(
          widget: DashBoardScreen(),
          routeName: routeSettings.name!,
        );
      case Routes.calendarRoute:
        return _GeneratePageRoute(
          widget: CalendarScreen(),
          routeName: routeSettings.name!,
        );
      case Routes.tableRoute:
        return _GeneratePageRoute(
          widget: TableScreen(),
          routeName: routeSettings.name!,
        );
      case Routes.formRoute:
        return _GeneratePageRoute(
          widget: TimeblockPage(),
          routeName: routeSettings.name!,
        );
      case Routes.loginRoute:
        return _GeneratePageRoute(
          widget: LoginScreen(),
          routeName: routeSettings.name!,
        );
      case Routes.signupRoute:
        return _GeneratePageRoute(
          widget: SignupScreen(),
          routeName: routeSettings.name!,
        );
       case Routes.paymentRoute:
        return _GeneratePageRoute(
          widget: PaymentScreen(),
          routeName: routeSettings.name!,
        );
         case Routes.settingsRoute:
        return _GeneratePageRoute(
          widget: SettingsScreen(),
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
