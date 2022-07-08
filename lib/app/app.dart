import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/providers/navigation_items.dart';
import '../data/providers/theme_provider.dart';
import '../presentation/base_layout.dart';
import '../presentation/resources/theme_dark_manager.dart';
import '../navigation/navigator_observer.dart';

import '../presentation/resources/theme_light_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  //NOTE: placing the navigator key ,ongenerateroute, initialroute renders the url
  //then this is passed to the baselayout using a builder

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => NavigationProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(), 
          ),
        ],
        child: Builder(builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            home: BaseLayout(),
            title: 'Timey',
            theme: getlightAppTheme(),
            themeMode: themeProvider.themeMode,
            darkTheme: getdarkAppTheme(),
            debugShowCheckedModeBanner: false,
            navigatorObservers: [NavigationObserver()],
          );
        }));
  }
}
