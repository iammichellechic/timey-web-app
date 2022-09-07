import 'package:flutter/material.dart';
import '../presentation/base_onboarding_layout.dart';
import '../presentation/ui/login/login.dart';
import '../presentation/ui/payment/payment_screen.dart';
import '../presentation/ui/signup/signup.dart';
import '../presentation/ui/chart/chart_overview_screen.dart';
import '../presentation/ui/form/timeblock_form_page.dart';
import '../presentation/ui/calendar/calendar_screen.dart';
import '../presentation/ui/onboarding/onboarding_screen.dart';
import '../presentation/ui/settings/settings_screen.dart';
import '../presentation/ui/table/table_timeblock_screen.dart';

class Routes {
  //temporary names
  static const String overviewRoute = "Dashboard";
  static const String calendarRoute = "Calendar";
  static const String tableRoute = "Table";
  static const String formRoute = "Edit-Timereport";
  static const String loginRoute = "Login";
  static const String signupRoute = "Signup";
  static const String paymentRoute = "Payment";
  static const String settingsRoute = "Settings";
  static const String onboardingRoute = "Onboarding";
  static const String baseLayoutRoute = "Dashboards";
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
      case Routes.onboardingRoute:
        return _GeneratePageRoute(
          widget: OnBoardingScreen(),
          routeName: routeSettings.name!,
        );
      case Routes.baseLayoutRoute:
        return _GeneratePageRoute(
          widget: OnboardingBaseLayout(),
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
