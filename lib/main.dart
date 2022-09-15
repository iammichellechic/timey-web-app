
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:timey_web/app/app.dart';
import 'package:timey_web/locator.dart';

//NOTE: the orientation this app is set to display is indicated below

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initHiveForFlutter();
  setupLocator();
  runApp(MyApp());
}
