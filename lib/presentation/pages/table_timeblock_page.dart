import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/resources/timeFormat_manager.dart';

import '../../data/providers/timeblocks.dart';
import '../widgets/dialogs_widget.dart';

class MyDataTable extends StatefulWidget {
  const MyDataTable({Key? key}) : super(key: key);

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  int? sortColumnIndex;
  bool isAscending = false;

  final String _query = """
  query {
  timeblocks{
    datetimeStart
    datetimeEnd
    reportedHours
    reportedRemainingMinutes
          } 
  }
  """;

  @override
  Widget build(BuildContext context) {
    // final timeblocksData = Provider.of<TimeBlocks>(context);
    // final timeblocks = timeblocksData.userTimeBlock;

    // //sorting doesnt work
    // //initState list != null sort
    // int compareValues(bool ascending, DateTime value1, DateTime value2) =>
    //     ascending ? value1.compareTo(value2) : value2.compareTo(value1);

    // void onSort(int columnIndex, bool ascending) {
    //   if (columnIndex == 1) {
    //     timeblocks.sort((user1, user2) =>
    //         compareValues(ascending, user1.startDate, user2.startDate));
    //   } else if (columnIndex == 2) {
    //     timeblocks.sort((user1, user2) =>
    //         compareValues(ascending, user1.endDate, user2.endDate));
    //   }

    //   setState(() {
    //     this.sortColumnIndex = columnIndex;
    //     this.isAscending = ascending;
    //   });
    // }

    //ERROR unexpected null value
    //added null check--did not solve the errir

    return Query(
        options: QueryOptions(document: gql(_query)),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }
          if (result.isLoading) {
            return CircularProgressIndicator();
          }

          List timeblocks = result.data!["timeblocks"];
          print(timeblocks);

          return (timeblocks.isNotEmpty)
              ? ListView.builder(
                  itemCount: timeblocks.length,
                  itemBuilder: (context, index) {
                    //final tb = timeblocks[index];
                    return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: DataTable(
                              border: TableBorder.symmetric(
                                  outside:
                                      BorderSide(width: 3, color: Colors.amber),
                                  inside: BorderSide(
                                      width: 2, color: Colors.amberAccent)),
                              columns: [
                                DataColumn(
                                  label: Text('Project',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),

                                  //onSort: onSort,
                                ),
                                DataColumn(
                                  label: Text('Start Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                                DataColumn(
                                  label: Text('End Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                                DataColumn(
                                    label: Text('Edit',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                    tooltip: 'edit an entry'),
                                DataColumn(
                                    label: Text('Delete',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                    tooltip: 'remove an entry'),
                              ],
                              rows: timeblocks
                                  .map((data) => DataRow(cells: [
                                        DataCell(Text(
                                            data[index]['datetimeStart'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption)),
                                        DataCell(Text(
                                            Utils.toDateTime(
                                                data[index]['datetimeStart']),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption)),
                                        DataCell(Text(
                                            Utils.toDateTime(
                                                data[index]['datetimeEnd']),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption)),
                                        DataCell(
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            color: ColorManager.blue,
                                            onPressed: () {
                                              showDialog<EntryEditDialog>(
                                                context: context,
                                                builder: (context) {
                                                  return EntryEditDialog(
                                                    entry: data,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            color: ColorManager.error,
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                        'Remove selected time report?',
                                                      ),
                                                      duration:
                                                          Duration(seconds: 5),
                                                      action: SnackBarAction(
                                                        label: 'CONFIRM',
                                                        textColor:
                                                            ColorManager.blue,
                                                        onPressed: () {
                                                          Provider.of<TimeBlocks>(
                                                                  context,
                                                                  listen: false)
                                                              .deleteTimeBlock(
                                                                  data.id);
                                                        },
                                                      )));
                                            },
                                          ),
                                        )
                                      ]))
                                  .toList(),
                            )));
                  })
              : Container(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("No timeblocks found"),
                  ));
        });
  }
}
