import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:timey_web/presentation/shared/page/table_page.dart';
import 'package:timey_web/presentation/widgets/button_widget.dart';

import '../../../viewmodels/timeblocks_viewmodels.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/formats_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class PaymentScreen extends ViewModelWidget<TimeBlocksViewModel> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TimeBlocksViewModel viewModel) {
    return buildPaymentWidget(context, viewModel);
  }
}

Widget buildPaymentWidget(BuildContext context, TimeBlocksViewModel viewModel) {
  return (viewModel.appointmentData.isNotEmpty)
      ? TablePage(
          dataRowHeight: 80,
          tableColumns: [
            buildDataColumn(text: 'Id', context: context, isNumeric: false),
            buildDataColumn(
              text: 'Date',
              context: context,
              isNumeric: false,
            ),
            buildDataColumn(text: 'Hours', context: context, isNumeric: true),
            buildDataColumn(text: 'Minutes', context: context, isNumeric: true),
            buildDataColumn(text: 'Amount', context: context, isNumeric: true),
            buildDataColumn(text: 'Status', context: context, isNumeric: false),
            buildDataColumn(text: 'View', context: context, isNumeric: false),
          ],
          tableRows: List.generate(viewModel.appointmentData.length, (index) {
            final tb = viewModel.appointmentData;
            return DataRow(
              cells: <DataCell>[
                DataCell(Text(tb[index].id!,
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
                DataCell(Text('4000SEK',
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12, color: ColorManager.grey))),
                DataCell(Text('Unpaid',
                    style: makeYourOwnRegularStyle(
                        fontSize: FontSize.s12, color: ColorManager.grey))),
                DataCell(ButtonWidget(
                    color: Theme.of(context).colorScheme.primary,
                    text: 'Open Invoice',
                    style: Theme.of(context).textTheme.headline6,
                    onClicked: () {}))
              ],
            );
          }))
      : Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ),
        );
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
