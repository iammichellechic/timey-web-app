import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/pages/base_layout.dart';

import '/presentation/resources/theme_manager.dart';

import '../data/providers/tags.dart';
import '../data/providers/timeblocks.dart';
import '../presentation/resources/routes_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); // private named constructor
  int appState = 0;
  static final MyApp instance =
      MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; // factory for the class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          )
        ],
        child: MaterialApp(
          title: 'Timey',
          theme: getAppTheme(),
          debugShowCheckedModeBanner: false,
          home: BaseLayout(),
         
        ));
  }
}
