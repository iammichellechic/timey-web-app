import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/widgets/actionbuttons_widget.dart';
import '../../resources/font_manager.dart';
import '../../resources/formats_manager.dart';

import '../../resources/styles_manager.dart';
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
          child: (task.getResponseFromQuery().isNotEmpty)
              ? Container(
                  padding: EdgeInsets.only(top: AppPadding.p40),
                  child: Column(children: [
                    buildSearchField(context),
                    const SizedBox(height: AppSize.s30),
                    Container(
                        decoration: BoxDecoration(
                            color: ColorManager.background,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 6.0,
                              ),
                            ]),
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            clipBehavior: Clip.hardEdge,
                            child: DataTable(
                                //settings//
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: ColorManager.primary,
                                            width: 2))),
                                dataRowHeight: 40,
                                showCheckboxColumn: false,
                                dividerThickness: 0,
                                columnSpacing: 80,
                                //headingRowColor: MaterialStateColor.resolveWith((states) {return ColorManager.primaryContainer;}),

                                columns: [
                                  buildDataColumn(
                                      text: 'Title',
                                      context: context,
                                      isNumeric: false),
                                  buildDataColumn(
                                      text: 'Date',
                                      context: context,
                                      isNumeric: false),
                                  buildDataColumn(
                                      text: 'Hours',
                                      context: context,
                                      isNumeric: true),
                                  buildDataColumn(
                                      text: 'Minutes',
                                      context: context,
                                      isNumeric: true),
                                  buildDataColumn(
                                      text: 'Actions',
                                      context: context,
                                      isNumeric: true,
                                      tooltipText: 'edit or remove an entry'),
                                ],
                                rows: List.generate(
                                    task.getResponseFromQuery().length,
                                    (index) {
                                  final tb = task.getResponseFromQuery();
                                  return DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(tb[index].id,
                                          style: makeYourOwnRegularStyle(
                                              fontSize: FontSize.s12,
                                              color: ColorManager.grey))),
                                      DataCell(Text(
                                          Utils.toDateTime(tb[index].startDate),
                                          style: makeYourOwnRegularStyle(
                                              fontSize: FontSize.s12,
                                              color: ColorManager.grey))),
                                      DataCell(Text(
                                          Utils.convertStringFromInt(
                                              tb[index].reportHours),
                                          style: makeYourOwnRegularStyle(
                                              fontSize: FontSize.s12,
                                              color: ColorManager.primary))),
                                      DataCell(Text(
                                          Utils.convertStringFromInt(
                                              tb[index].remainingMinutes),
                                          style: makeYourOwnRegularStyle(
                                              fontSize: FontSize.s12,
                                              color: ColorManager.primary))),
                                      DataCell(ActionButtonsWidget(
                                          entry: tb[index])),
                                    ],
                                  );
                                }))))
                  ]),
                )
              : Container(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("No timeblocks found"),
                  )));
    });
  }
}

DataColumn buildDataColumn(
        {required String text,
        String? tooltipText,
        required bool isNumeric,
        required BuildContext context}) =>
    DataColumn(
      label: Container(
          padding: EdgeInsets.fromLTRB(
              AppPadding.p12, AppPadding.p6, AppPadding.p12, AppPadding.p6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              color: ColorManager.primaryContainer),
          child: Text(text, style: Theme.of(context).textTheme.subtitle1)),
      numeric: isNumeric,
      tooltip: tooltipText,
    );

Widget buildSearchField(BuildContext context) {
  final controller = TextEditingController();
  final style = controller.text.isEmpty
      ? const TextStyle(color: Colors.black54)
      : const TextStyle(color: Colors.black);
  return Container(
    margin: const EdgeInsets.fromLTRB(100, 16, 100, 16),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty
            ? GestureDetector(
                child: Icon(Icons.close, color: style.color),
                onTap: () {
                  controller.clear();
                  FocusScope.of(context).requestFocus(FocusNode());

                  // searchBook('');
                },
              )
            : null,
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black26),
        ),
      ),
      //onChanged: searchBook,
    ),
  );
}

// void searchBook(String query) {
//   final suggestions = allBooks.where((book) {
//     final bookTitle = book.title.toLowerCase();
//     final input = query.toLowerCase();

//     return bookTitle.contains(input);
//   }).toList();

//   setState(() => books = suggestions);
// }
