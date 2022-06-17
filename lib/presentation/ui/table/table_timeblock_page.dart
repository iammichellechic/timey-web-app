import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import '../../resources/formats_manager.dart';

import '../../widgets/dialogs_widget.dart';

import '/presentation/resources/color_manager.dart';
import '../../../data/providers/timeblocks.dart';

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
    return Consumer<TimeBlocks>(builder: (context, task, child) {
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
                        scrollDirection: Axis.vertical,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: DataTable(
                            //settings//
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: ColorManager.primary,
                                        width: 4))),
                            dataRowHeight: 100,
                            showCheckboxColumn: false,
                            dividerThickness: 0,
                            columnSpacing: 80,

                            columns: [
                              DataColumn(
                                label: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      AppPadding.p12,
                                      AppPadding.p6,
                                      AppPadding.p12,
                                      AppPadding.p6),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s20),
                                      color: ColorManager.primaryContainer),
                                  child: Text('Title',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                              ),
                              DataColumn(
                                label: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      AppPadding.p12,
                                      AppPadding.p6,
                                      AppPadding.p12,
                                      AppPadding.p6),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s20),
                                      color: ColorManager.primaryContainer),
                                  child: Text('Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                              ),
                              DataColumn(
                                label: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      AppPadding.p12,
                                      AppPadding.p6,
                                      AppPadding.p12,
                                      AppPadding.p6),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s20),
                                      color: ColorManager.primaryContainer),
                                  child: Text('Hours',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                              ),
                                DataColumn(
                                label: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      AppPadding.p12,
                                      AppPadding.p6,
                                      AppPadding.p12,
                                      AppPadding.p6),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s20),
                                      color: ColorManager.primaryContainer),
                                  child: Text('Minutes',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                              ),
                              DataColumn(
                                  label: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        AppPadding.p12,
                                        AppPadding.p6,
                                        AppPadding.p12,
                                        AppPadding.p6),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s20),
                                        color: ColorManager.primaryContainer),
                                    child: Text('Edit',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ),
                                  tooltip: 'edit an entry'),
                              DataColumn(
                                  label: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        AppPadding.p12,
                                        AppPadding.p6,
                                        AppPadding.p12,
                                        AppPadding.p6),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s20),
                                        color: ColorManager.primaryContainer),
                                    child: Text('Delete',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ),
                                  tooltip: 'remove an entry'),
                            ],
                            rows: tb
                                .map<DataRow>((data) => DataRow(cells: [
                                      DataCell(Text(data.id,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption)),
                                      DataCell(Text(
                                          Utils.toDateTime(data.startDate),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption)),
                                      DataCell(Text(
                                         Utils.convertStringFromInt(data.reportHours),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption)),
                                      DataCell(Text(
                                         Utils.convertStringFromInt(data.remainingMinutes),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption)),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          color: ColorManager.blue,
                                          onPressed: () {
                                            showGlobalDrawer<EntryEditDialog>(
                                                direction: AxisDirection.left,
                                                context: context,
                                                duration: Duration(seconds: 1),
                                                builder: (context) {
                                                  return EntryEditDialog(
                                                    entry: data,
                                                  );
                                                });
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
                          ),
                        ));
                  })
              : Container(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("No timeblocks found"),
                  )));
    });
  }
}
