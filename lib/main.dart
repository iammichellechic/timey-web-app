import 'package:flutter/material.dart';
import 'app/app.dart';


void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {

//   MyApp._internal(); // private named constructor
//   int appState = 0;
//   static final MyApp instance =
//       MyApp._internal(); // single instance -- singleton

//   factory MyApp() => instance; // factory for the class instance

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
    
//     return MultiProvider(
//         providers: [
//           ChangeNotifierProvider.value(
//             value: TimeBlocks(),
//           ),
//           ChangeNotifierProvider.value(
//             value: Tags(),
//           )
//         ],
//         child: MaterialApp(
//           title: 'Timey',
//           theme: ThemeData(
//               primarySwatch: Colors.blue,
//               errorColor: Colors.red,
//               fontFamily: 'Quicksand',
//               textTheme: ThemeData.light().textTheme.copyWith(
//                       headline6: TextStyle(
//                     fontFamily: 'OpenSans',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ))),
//           debugShowCheckedModeBanner: false,
//           home: OverView(),
          
//           routes: {

//             TimeBlockDetailScreen.routeName: (ctx) => TimeBlockDetailScreen(),
//             AddTimeBlockScreen.routeName: (ctx) => AddTimeBlockScreen(),
//             EditablePage.routeName: (ctx) => EditablePage(),
//             CalendarWidget.routeName: (ctx) => CalendarWidget(),
//             TimeblockPage.routeName: (ctx) => TimeblockPage(),
//           },
//           initialRoute: '/',
//         ));
//   }
// }
