import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import '../resources/timeFormat_manager.dart';
import '/presentation/resources/color_manager.dart';
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
  bool isFetched = false;

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

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        height: 650,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Consumer<TimeBlocks>(builder: (context, task, child) {
          if (isFetched == false) {
            ///Fetch the data
            task.getTimeblocks(true);

            Future.delayed(const Duration(seconds: 3), () => isFetched = true);
          }
          return RefreshIndicator(
              onRefresh: () {
                task.getTimeblocks(false);
                return Future.delayed(const Duration(seconds: 3));
              },
              child: (task.getResponseData().isNotEmpty)
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: task.getResponseData().length,
                      itemBuilder: (context, index) {
                        final tb = task.getResponseFromQuery();

                        return SingleChildScrollView(
                            //physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: DataTable(
                                //settings//
                                border: TableBorder.symmetric(),
                                dataRowHeight: AppSize.s80,
                                // dataRowColor: MaterialStateColor.resolveWith(
                                //     (Set<MaterialState> states) =>
                                //         states.contains(MaterialState.selected)
                                //             ? ColorManager.blue.withOpacity(0.6)
                                //             : ColorManager.lightBlue),
                                showCheckboxColumn: false,
                                dividerThickness: 0,

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
                                rows: tb
                                    .map<DataRow>((data) => DataRow(
                                            // selected: data.isSelected,
                                            // onSelectChanged: (bool? isSelected) {
                                            //   if (isSelected != null) {
                                            //     data.isSelected = isSelected;

                                            //     setState(() {});
                                            //   }
                                            // },
                                            cells: [
                                              DataCell(Text(data.id,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption)),
                                              DataCell(Text(
                                                  Utils.toDateTime(
                                                      data.startDate),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption)),
                                              DataCell(Text(
                                                  Utils.toDateTime(
                                                      data.endDate),
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
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                              'Remove selected time report?',
                                                            ),
                                                            duration: Duration(
                                                                seconds: 5),
                                                            action:
                                                                SnackBarAction(
                                                              label: 'CONFIRM',
                                                              textColor:
                                                                  ColorManager
                                                                      .blue,
                                                              onPressed: () {
                                                                Provider.of<TimeBlocks>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .deleteTimeBlock(
                                                                        data.id);
                                                              },
                                                            )));
                                                  },
                                                ),
                                              )
                                            ]))
                                    .toList(),
                              ),
                            ));
                      })
                  : Container(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text("No timeblocks found"),
                      )));
        }));
  }
}
