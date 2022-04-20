import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timeblocks.dart';
import '../widgets/table_timeblock_datatable.dart';
import '../widgets/chart_weekly.dart';
import '../screens/add_timeblock_screen.dart';
import '../shared/menu_drawer.dart';



class EditablePage extends StatefulWidget {
  static const routeName = '/user-list';

  @override
  State<EditablePage> createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {


  @override
  Widget build(BuildContext context) {
     final timeblocksData = Provider.of<TimeBlocks>(context);
   
    return Scaffold(
        appBar: AppBar(
          title: Text('My Time Blocks'),
          actions: <Widget>[
            IconButton(
                tooltip: 'Find a time report',
                onPressed: () {},
                icon: const Icon(Icons.search)),
            SizedBox(
              width: 10,
            ),
            IconButton(
              tooltip: 'Add a time report',
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddTimeBlockScreen.routeName);
              },
            ),
          ],
        ),
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
            Chart(timeblocksData.recentEntries),
            MyDataTable(),
          ],
           
            ),
          ),
        );
  }
  


}
