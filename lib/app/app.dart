import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/pages/base_layout.dart';
import 'package:timey_web/presentation/screens/chart/chart_overview_screen.dart';

import '../locator.dart';
import '../navigation-service.dart';
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
        ],
              child: MaterialApp(
              //home: BaseLayout(),
              builder: (context, child) =>
                Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) => BaseLayout(child: child!),
                  ),
                ],),
              
              title: 'Timey',
              theme: getAppTheme(),
              debugShowCheckedModeBanner: false,
              navigatorKey: locator<NavigationService>().navigatorKey,
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: Routes.overviewRoute,
            ));
  }
}
