import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/widgets/actionbuttons_widget.dart';
import '/viewmodels/timeblocks_viewmodels.dart';
import '../../resources/font_manager.dart';
import '../../resources/formats_manager.dart';
import '../../resources/styles_manager.dart';
import '/presentation/resources/color_manager.dart';

class MyDataTable extends ViewModelWidget<TimeBlocksViewModel> {
  const MyDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TimeBlocksViewModel viewModel) {
    return (viewModel.appointmentData.isNotEmpty)
        ? Container(
            padding: EdgeInsets.only(top: AppPadding.p40),
            child: Column(children: [
              buildSearchField(context),
              const SizedBox(height: AppSize.s30),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                              isNumeric: false,
                            ),
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
                          rows: List.generate(viewModel.appointmentData.length,
                              (index) {
                            final tb = viewModel.appointmentData;
                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Timereport Entry',
                                    style: makeYourOwnRegularStyle(
                                        fontSize: FontSize.s12,
                                        color: ColorManager.grey))),
                                DataCell(Text(
                                    Utils.toDateTime(tb[index].startDate),
                                    style: makeYourOwnRegularStyle(
                                        fontSize: FontSize.s12,
                                        color: ColorManager.grey))),
                                DataCell(Text(
                                    Utils.convertInttoString(tb[index].hours!),
                                    style: makeYourOwnRegularStyle(
                                        fontSize: FontSize.s12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary))),
                                DataCell(Text(
                                    Utils.convertInttoString(
                                        tb[index].minutes!),
                                    style: makeYourOwnRegularStyle(
                                        fontSize: FontSize.s12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary))),
                                DataCell(ActionButtonsWidget(entry: tb[index])),
                              ],
                            );
                          }))))
            ]),
          )
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
