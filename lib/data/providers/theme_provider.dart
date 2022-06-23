import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  // use ThemeMode.system to set the thememode system on mobile
  //as default
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
