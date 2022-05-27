

import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
}
