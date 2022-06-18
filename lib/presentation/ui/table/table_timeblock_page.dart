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
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          margin: EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 20.0),
                          decoration: BoxDecoration(
                              color: ColorManager.background,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ]),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: DataTable(
                              //settings//
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: ColorManager.primary,
                                          width: 4))),
                              dataRowHeight: 60,
                              showCheckboxColumn: false,
                              dividerThickness: 0,
                              columnSpacing: 80,

                              columns: [
                                buildDataColumn(
                                    text: 'Title', context: context),
                                buildDataColumn(text: 'Date', context: context),
                                buildDataColumn(
                                    text: 'Hours', context: context),
                                buildDataColumn(
                                    text: 'Minutes', context: context),
                                buildDataColumn(
                                    text: 'Edit',
                                    context: context,
                                    tooltipText: 'edit an entry'),
                                buildDataColumn(
                                    text: 'Delete',
                                    context: context,
                                    tooltipText: 'remove an entry'),
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
                                            Utils.convertStringFromInt(
                                                data.reportHours),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption)),
                                        DataCell(Text(
                                            Utils.convertStringFromInt(
                                                data.remainingMinutes),
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
                                                  duration:
                                                      Duration(seconds: 1),
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

DataColumn buildDataColumn(
        {required String text,
        String? tooltipText,
        required BuildContext context}) =>
    DataColumn(
      label: Container(
          padding: EdgeInsets.fromLTRB(
              AppPadding.p12, AppPadding.p6, AppPadding.p12, AppPadding.p6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              color: ColorManager.primaryContainer),
          child: Text(text, style: Theme.of(context).textTheme.subtitle1)),
      tooltip: tooltipText,
    );

Widget buildSearchField(BuildContext context) {
  final controller = TextEditingController();
  final style = controller.text.isEmpty
      ? const TextStyle(color: Colors.black54)
      : const TextStyle(color: Colors.black);
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
        hintText: 'Book Title',
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
