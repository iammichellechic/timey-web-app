import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/timeblock_adding_page.dart';
import '../shared/menu_drawer.dart';
import '../../data/providers/timeblocks.dart';

import '../pages/table_timeblock_page.dart';
import '../resources/color_manager.dart';
import '../widgets/chart_weekly.dart';

//right now this screen has no purpose

class EditablePage extends StatefulWidget {
  @override
  State<EditablePage> createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;

    return Container(child: buildTableItems(context));
  }

  Widget buildTableItems(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              // Chart(timeblocksData.recentEntries), //no prupose
              MyDataTable(),
            ],
          ),
        ),
      ),
    );
  }
}
