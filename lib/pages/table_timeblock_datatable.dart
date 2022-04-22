import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timey_web_scratch/pages/timeblock_editing_page.dart';

import '../providers/timeblocks.dart';

class MyDataTable extends StatefulWidget {
  const MyDataTable({Key? key}) : super(key: key);

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  Widget build(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;

    //sorting doesnt work
    //initState list != null sort
    int compareValues(bool ascending, DateTime value1, DateTime value2) =>
        ascending ? value1.compareTo(value2) : value2.compareTo(value1);

    void onSort(int columnIndex, bool ascending) {
       if (columnIndex == 1) {
        timeblocks.sort((user1, user2) =>
            compareValues(ascending, user1.startDate, user2.startDate));
      } else if (columnIndex == 2) {
        timeblocks.sort((user1, user2) =>
            compareValues(ascending, user1.endDate, user2.endDate));
      }

      setState(() {
        this.sortColumnIndex = columnIndex;
        this.isAscending = ascending;
      });
    }

    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: FittedBox(
            child: DataTable(
          border: TableBorder.symmetric(
              outside: BorderSide(width: 3, color: Colors.amber),
              inside: BorderSide(width: 2, color: Colors.amberAccent)),
          columns: [
            DataColumn(
              label: Text('Project'),
              //onSort: onSort,
            ),
            DataColumn(
              label: Text('Start Date'),
              onSort: onSort,
            ),
            DataColumn(
              label: Text('End Date'),
              onSort: onSort,
            ),
            DataColumn(label: Text('Edit'), tooltip: 'edit an entry'),
            DataColumn(label: Text('Delete'), tooltip: 'remove an entry'),
          ],
          rows: timeblocks
              .map((data) => DataRow(cells: [
                    DataCell(Text(data.tag!.name)),
                    DataCell(
                      Text(DateFormat("EEEE, yyyy/MM/dd HH:mm")
                          .format(data.startDate.toLocal())),
                    ),
                    DataCell(Text(DateFormat("EEEE, yyyy/MM/dd HH:mm")
                        .format(data.endDate.toLocal()))),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              TimeblockPage.routeName,
                              arguments: data.id);
                        },
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Remove selected time report?',
                              ),
                              duration: Duration(seconds: 5),
                              action: SnackBarAction(
                                label: 'CONFIRM',
                                onPressed: () {
                                  Provider.of<TimeBlocks>(context,
                                          listen: false)
                                      .deleteTimeBlock(data.id!);
                                },
                              )));
                        },
                      ),
                    )
                  ]))
              .toList(),
        )));
  }
}
