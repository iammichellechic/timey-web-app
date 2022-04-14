import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../screens/add_timeblock_screen.dart';
import '../shared/menu_drawer.dart';
import '../providers/timeblocks.dart';

class EditablePage extends StatelessWidget {
  
  static const routeName = '/user-list';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<TimeBlocks>(context);

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
      body: Center(
        child: ChangeNotifierProvider<TimeBlocks>(
            create: (context) => TimeBlocks(),
            child: Consumer<TimeBlocks>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..//change this
                  child: SingleChildScrollView(
                    child: DataTable(
                      border: TableBorder.symmetric(
                          outside:
                              BorderSide(width: 2, color: Colors.deepOrange),
                          inside: BorderSide(width: 2, color: Colors.amber)),
                      
                      columns: [
                        DataColumn(
                          label: Text('Project'),
                        ),
                        DataColumn(
                          label: Text('Start Date'),
                        ),
                        DataColumn(
                          label: Text('End Date'),
                        ),
                        DataColumn(
                            label: Text('Edit'), tooltip: 'edit an entry'),
                        DataColumn(
                            label: Text('Delete'), tooltip: 'remove an entry'),
                      ],
                      rows: data.userTimeBlock
                          .map((data) => DataRow(cells: [
                                DataCell(Text(data.tag)),
                                DataCell(
                                  Text(DateFormat("EEEE, yyyy/MM/dd HH:mm")
                                      .format(data.startDate.toLocal())),
                                ),
                                DataCell(Text(
                                    DateFormat("EEEE, yyyy/MM/dd HH:mm")
                                        .format(data.endDate.toLocal()))),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    color: Colors.orange,
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          AddTimeBlockScreen.routeName,
                                          arguments: data.id);
                                    },
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Theme.of(context).errorColor,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                'Remove selected time report?',
                                              ),
                                              duration: Duration(seconds: 5),
                                              action: SnackBarAction(
                                                label: 'CONFIRM',
                                                onPressed: () {
                                                  Provider.of<TimeBlocks>(
                                                          context,
                                                          listen: false)
                                                      .deleteTimeBlock(data.id);
                                                },
                                              )));
                                    },
                                  ),
                                )
                              ]))
                          .toList(),
                    ),
                  ),
                );
              },
            )),
      ),
  
    );
    
  }
}
