import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web_scratch/pages/timeblock_editing_page.dart';
import 'package:timey_web_scratch/pages/add_timeblock_screen.dart';
import 'package:timey_web_scratch/screens/table_timeblock_screen.dart';
import 'package:timey_web_scratch/screens/calendar_screen.dart';
import './screens/timeblock_detail_screen.dart';
import './providers/timeblocks.dart';
import 'screens/overview.dart';
import 'providers/tags.dart';

void main() => runApp(const MyApp());

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
          )
        ],
        child: MaterialApp(
          title: 'Timey',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              errorColor: Colors.red,
              fontFamily: 'Quicksand',
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))),
          debugShowCheckedModeBanner: false,
          home: OverView(),
          
          routes: {

            TimeBlockDetailScreen.routeName: (ctx) => TimeBlockDetailScreen(),
            AddTimeBlockScreen.routeName: (ctx) => AddTimeBlockScreen(),
            EditablePage.routeName: (ctx) => EditablePage(),
            CalendarWidget.routeName: (ctx) => CalendarWidget(),
            TimeblockPage.routeName: (ctx) => TimeblockPage(),
          },
          initialRoute: '/',
        ));
  }
}
