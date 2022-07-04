import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timey_web/app/app.dart';
import 'package:timey_web/locator.dart';

void main() async {
 
  await initHiveForFlutter();

 
  setupLocator();
  runApp(MyApp());
}
