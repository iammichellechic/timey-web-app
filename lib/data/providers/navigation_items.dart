import 'package:flutter/material.dart';
import '../../model/nav_items.dart';


class NavigationProvider extends ChangeNotifier {
  NavigationItem _navigationItem = NavigationItem.dashboard;
  NavigationItem get navigationItem => _navigationItem;

  void setNavigationItem(NavigationItem navigationItem) {
    _navigationItem = navigationItem;

    notifyListeners();
  }
}
