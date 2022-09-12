import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/model/filtertag.dart';

import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/shared/page/table_page.dart';
import 'package:timey_web/presentation/widgets/actionbuttons_widget.dart';

import '../../../data/timeblocks.dart';
import '../../resources/font_manager.dart';
import '../../resources/formats_manager.dart';
import '../../resources/styles_manager.dart';
import '/presentation/resources/color_manager.dart';

//DO: Paginated datatable and sort dates

class MyDataTable extends StatelessWidget {
  const MyDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<TimeBlocks>(context).userTimeBlock;
    return (entries.isNotEmpty)
        ? TablePage(
            dataRowHeight: 40,
            tableColumns: [
              buildDataColumn(
                  text: 'Title', context: context, isNumeric: false),
              buildDataColumn(
                text: 'Date',
                context: context,
                isNumeric: false,
              ),
              buildDataColumn(text: 'Hours', context: context, isNumeric: true),
              buildDataColumn(
                  text: 'Minutes', context: context, isNumeric: true),
             
              buildDataColumn(
                  text: 'Actions',
                  context: context,
                  isNumeric: true,
                  tooltipText: 'edit or remove an entry'),
            ],
            tableRows: List.generate(entries.length, (index) {
              final tb = entries;
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text('Timereport Entry',
                      style: makeYourOwnRegularStyle(
                          fontSize: FontSize.s12, color: ColorManager.grey))),
                  DataCell(Text(Utils.toDateTime(tb[index].startDate),
                      style: makeYourOwnRegularStyle(
                          fontSize: FontSize.s12, color: ColorManager.grey))),
                  DataCell(Text(Utils.convertInttoString(tb[index].hours!),
                      style: makeYourOwnRegularStyle(
                          fontSize: FontSize.s12,
                          color: Theme.of(context).colorScheme.primary))),
                  DataCell(Text(Utils.convertInttoString(tb[index].minutes!),
                      style: makeYourOwnRegularStyle(
                          fontSize: FontSize.s12,
                          color: Theme.of(context).colorScheme.primary))),
               
                  DataCell(ActionButtonsWidget(entry: tb[index])),
                ],
              );
            }))
        : Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            ),
          );
  }
}

DataColumn buildDataColumn(
        {required String text,
        String? tooltipText,
        void Function(int, bool)? onSort,
        required bool isNumeric,
        required BuildContext context}) =>
    DataColumn(
      label: Container(
          padding: EdgeInsets.fromLTRB(
              AppPadding.p12, AppPadding.p6, AppPadding.p12, AppPadding.p6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              color: Theme.of(context).colorScheme.primaryContainer),
          child: Text(text, style: Theme.of(context).textTheme.subtitle1)),
      numeric: isNumeric,
      tooltip: tooltipText,
      onSort: onSort,
    );
