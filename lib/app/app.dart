import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/data/providers/navigation_items.dart';
import 'package:timey_web/data/providers/theme_provider.dart';
import 'package:timey_web/presentation/pages/base_layout.dart';
import 'package:timey_web/presentation/resources/theme_dark_manager.dart';

import '../locator.dart';
import '../services/navigation_service.dart';
import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_light_manager.dart';

import '../data/providers/tags.dart';
import '../data/providers/timeblocks.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: TimeBlocks(),
          ),
          ChangeNotifierProvider.value(
            value: Tags(),
          ),
          ChangeNotifierProvider.value(
            value: NavigationProvider(),
          ),
          ChangeNotifierProvider.value(
            value: ThemeProvider(),
          ),
        ],
        child: Builder(
          builder: (context) {
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
            );
          }
        ));
  }
}
