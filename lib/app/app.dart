import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/pages/base_layout.dart';

import '/presentation/resources/theme_manager.dart';

import '../data/providers/tags.dart';
import '../data/providers/timeblocks.dart';

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const MyApp({Key? key, required this.client}) : super(key: key);

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
        child: GraphQLProvider(
            client: client,
            child: CacheProvider(
              child: MaterialApp(
              home: BaseLayout(),
              // builder: (context, child) =>
              //   Overlay(
              //   initialEntries: [
              //     OverlayEntry(
              //       builder: (context) => BaseLayout(child: child),
              //     ),
              //   ],
              // ),
              title: 'Timey',
              theme: getAppTheme(),
              debugShowCheckedModeBanner: false,
              // navigatorKey: locator<NavigationService>().navigatorKey,
              // onGenerateRoute: RouteGenerator.getRoute,
              // initialRoute: Routes.overviewRoute,
            ))));
  }
}
