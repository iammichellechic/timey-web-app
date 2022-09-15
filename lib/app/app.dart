import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/base_layout.dart';

import '../data/providers/navigation_items.dart';
import '../data/providers/tags.dart';
import '../data/providers/theme_provider.dart';

import '../data/timeblocks.dart';
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
          ChangeNotifierProvider.value(
            value: TimeBlocks(),
          ),
          ChangeNotifierProvider.value(
            value: Tags(),
          ),
        ],
        child: Builder(builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            // builder: (context, child) => OnboardingBaseLayout(child: child),
            // navigatorKey: locator<AuthenticationService>().navigatorKey,
            // onGenerateRoute: RouteGenerator.getRoute,
            // initialRoute: Routes.onboardingRoute,

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
