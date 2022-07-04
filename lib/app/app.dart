import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/data/providers/navigation_items.dart';
import 'package:timey_web/data/providers/theme_provider.dart';
import 'package:timey_web/presentation/base_layout.dart';
import 'package:timey_web/presentation/resources/theme_dark_manager.dart';

import '../data/providers/add_timeblock_provider.dart';
import '../data/providers/delete_timeblock_provider.dart';
import '../locator.dart';

import '../navigation/navigator_observer.dart';
import '../services/navigation_service.dart';
import '../navigation/routes_manager.dart';
import '../presentation/resources/theme_light_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AddTimeBlockProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => DeleteTimeBlockProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => NavigationProvider(), //create
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(),   //crete
          ),
        ],
        child: Builder(builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            //home: BaseLayout(),
            builder: (context, child) => Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => BaseLayout(child: child!),
                ),
              ],
            ),
            title: 'Timey',
            theme: getlightAppTheme(),
            themeMode: themeProvider.themeMode,
            darkTheme: getdarkAppTheme(),
            debugShowCheckedModeBanner: false,
            navigatorKey: locator<NavigationService>().navigatorKey,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.overviewRoute,
            navigatorObservers: [NavigationObserver()],
          );
        }));
  }
}
