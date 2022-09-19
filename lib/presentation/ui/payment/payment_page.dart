import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timey_web/presentation/shared/page/table_page.dart';
import 'package:timey_web/presentation/widgets/button_widget.dart';

import '../../../data/timeblocks.dart';

import '../../../model/timeblock.dart';
import '../../../pdf/invoice_service.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/formats_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class PaymentTable extends StatefulWidget {
  const PaymentTable({Key? key}) : super(key: key);

  @override
  State<PaymentTable> createState() => _PaymentTableState();
}

class _PaymentTableState extends State<PaymentTable> {
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(
            AppPadding.p12, AppPadding.p24, 0, AppPadding.p12),
        child:
            Text('Open Invoices', style: Theme.of(context).textTheme.headline1),
      ),
      SizedBox(height: AppSize.s10),
      Padding(
        padding: const EdgeInsets.only(top: AppPadding.p20),
        child: SizedBox(
          width: 800,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.search),
              title: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Type a date or or company name',
                      border: InputBorder.none),
                  onChanged: (value) {
                    setState(() {
                      _searchResult = value;
                      filteredList = entries
                          .where((user) =>
                              user.tag!.name!
                                  .toLowerCase()
                                  .contains(_searchResult) ||
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
          dataRowHeight: 50,
          tableColumns: [
            buildDataColumn(text: 'Id', context: context, isNumeric: false),
            buildDataColumn(
              text: 'Date',
              context: context,
              isNumeric: false,
            ),
            buildDataColumn(
              text: 'Company',
              context: context,
              isNumeric: false,
            ),
            buildDataColumn(
                text: 'Billable', context: context, isNumeric: false),
            buildDataColumn(text: 'Amount', context: context, isNumeric: false),
            buildDataColumn(text: 'Status', context: context, isNumeric: true),
            buildDataColumn(text: 'View', context: context, isNumeric: false),
          ],
          tableRows: List.generate(filteredList.length, (index) {
            final tb = filteredList;

            return DataRow(
              cells: <DataCell>[
                DataCell(Text(tb[index].id!,
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12, color: ColorManager.grey))),
                DataCell(Text(Utils.toDateTime(tb[index].startDate),
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12, color: ColorManager.grey))),
                DataCell(Text(tb[index].tag!.name!.toString(),
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12, color: tb[index].tag!.color!))),
                DataCell(Text(
                    Utils.convertInttoString(tb[index].reportedMinutes!),
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12,
                        color: Theme.of(context).colorScheme.primary))),
                DataCell(Text(
                    Utils.convertInttoString(tb[index].reportedMinutes! * 200),
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12, color: ColorManager.grey))),
                DataCell(Text('Unpaid',
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12, color: ColorManager.grey))),
                DataCell(ButtonWidget(
                    color: Theme.of(context).colorScheme.primary,
                    text: 'Download Invoice',
                    style: Theme.of(context).textTheme.headline6,
                    onClicked: () async {
                      PdfInvoiceService.createPDF(tb[index]);
                    }))
              ],
            );
          }))
    ]);
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
}
