import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/shared/page/table_page.dart';
import 'package:timey_web/presentation/widgets/actionbuttons_widget.dart';

import '../../../data/timeblocks.dart';

import '../../../model/timeblock.dart';
import '../../resources/font_manager.dart';
import '../../resources/formats_manager.dart';
import '../../resources/styles_manager.dart';

import '/presentation/resources/color_manager.dart';

//DO: Paginated datatable and sort dates

class MyDataTable extends StatefulWidget {
  const MyDataTable({Key? key}) : super(key: key);

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  _getLists() async {
    entries = Provider.of<TimeBlocks>(context, listen: false).userTimeBlock;

    filteredList = entries;
  }

  late List<TimeBlock> entries;
  List<TimeBlock> filteredList = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();
    _getLists();
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: AppPadding.p20),
        child: SizedBox(
          width: 800,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.search),
              title: TextField(
                  controller: controller,
                  decoration:
                      InputDecoration(hintText: 'Type a date or company name', border: InputBorder.none),
                  onChanged: (value) {
                    setState(() {
                      _searchResult = value;
                      filteredList = entries
                          .where((user) =>
                              user.tag!.name!.toLowerCase().contains(_searchResult) ||
                              user.startDate.toString().contains(_searchResult)) 
                          .toList();
                    });
                  }),
              trailing: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  setState(() {
                    controller.clear();
                    _searchResult = '';
                    filteredList = entries;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      TablePage(
          dataRowHeight: 40,
          tableColumns: [
            
            buildDataColumn(
              text: 'Date',
              context: context,
              isNumeric: false,
            ),
            buildDataColumn(
                text: 'Company', context: context, isNumeric: false),
            buildDataColumn(text: 'Hours', context: context, isNumeric: true),
            buildDataColumn(text: 'Minutes', context: context, isNumeric: true),
            buildDataColumn(
                text: 'Tag', context: context, isNumeric: false),
            buildDataColumn(
                text: 'Actions',
                context: context,
                isNumeric: true,
                tooltipText: 'edit or remove an entry'),
          ],
          tableRows: List.generate(filteredList.length, (index) {
            final tb = filteredList;
            return DataRow(
              cells: <DataCell>[
                
                DataCell(Text(Utils.toDateTime(tb[index].startDate),
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12, color: ColorManager.grey))),

                DataCell(Text(tb[index].tag!.name!.toString(),
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12,
                        color: tb[index].tag!.color!))),

                DataCell(Text(Utils.convertInttoString(tb[index].hours!),
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12,
                        color: Theme.of(context).colorScheme.primary))),
                DataCell(Text(Utils.convertInttoString(tb[index].minutes!),
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12,
                        color: Theme.of(context).colorScheme.primary))),

                DataCell(Text(tb[index].filterTags!.label.toString(),
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12,
                        color: tb[index].filterTags!.color!))),

                DataCell(ActionButtonsWidget(entry: tb[index])),
              ],
            );
          }))
    ]);
  }

  // void onSort(int columnIndex, bool ascending) {
  //   if (columnIndex == 1) {
  //     entries.sort((user1, user2) =>
  //         compareString(ascending, user1.startDate, user2.startDate));
  //   }

  //   setState(() {
  //     this.sortColumnIndex = columnIndex;
  //     this.isAscending = ascending;
  //   });
  // }

  // int compareString(bool ascending, DateTime? value1, DateTime? value2) =>
  //     ascending ? value1!.compareTo(value2!) : value2!.compareTo(value1!);
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
