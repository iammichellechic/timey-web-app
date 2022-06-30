import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timey_web/app/app.dart';
import 'package:timey_web/locator.dart';

void main() async {
  //runApp(MaterialApp(home: MyApp()));
 // WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  // final HttpLink link = HttpLink('http://20.240.2.60/graphql');
  // ValueNotifier<GraphQLClient> client = ValueNotifier(
  //     GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())));
  setupLocator();
  runApp(MyApp());
}
