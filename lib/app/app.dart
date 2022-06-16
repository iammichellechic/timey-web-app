import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/data/providers/navigation_items.dart';
import 'package:timey_web/presentation/pages/base_layout.dart';

import '../locator.dart';
import '../services/navigation-service.dart';
import '../presentation/resources/routes_manager.dart';
import '/presentation/resources/theme_manager.dart';

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
        ],
        child: MaterialApp(
          //home: BaseLayout(),
          builder: (context, child) => Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => BaseLayout(child: child!),
              ),
            ],
          ),

          title: 'Timey',
          theme: getAppTheme(),
          // darkTheme: ThemeData(
          //     colorSchemeSeed: Color(0xFFACC7FF),
          //     brightness: Brightness.dark, // dark theme
          //     useMaterial3: true),
          debugShowCheckedModeBanner: false,
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.overviewRoute,
        ));
  }
}
