import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../navigation/navigator_observer.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final List<Route> currentRouteStack = routeStack.toList();

  Future<dynamic> navigateTo(String routeName) {
    var curr = ModalRoute.of(navigatorKey.currentContext!);
    if (curr != null) {
      print(ModalRoute.of(navigatorKey.currentContext!)!.settings.name);
    
    }
    
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  goBack() {
    navigatorKey.currentState!.pop();
  }

  void goTothisScreen(int index) {
    navigatorKey.currentState!
        .popUntil((route) => route == currentRouteStack[index]);
  }
}
