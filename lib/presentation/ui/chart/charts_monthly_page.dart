import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:stacked/stacked.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/ui/chart/chart_page.dart';
import 'package:timey_web/presentation/widgets/total_reported_time_widget.dart';
import '/viewmodels/timeblocks_viewmodels.dart';
import '/presentation/utils/chart_utils.dart' as utils;

import '../../resources/formats_manager.dart';

class MonthlyChart extends ViewModelWidget<TimeBlocksViewModel> {
  const MonthlyChart({Key? key}) : super(key: key);

  // static MaterialPageRoute getRoute() => MaterialPageRoute(
  //   settings: RouteSettings(name: 'Monthly'),
  //   builder: (context) => MonthlyChart());

  @override
  Widget build(BuildContext context, TimeBlocksViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          AppPadding.p12, AppPadding.p24, AppPadding.p12, AppPadding.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Center(
          //   child: Text('Monthly Time Report',
          //       style: Theme.of(context).textTheme.headline1),
          // ),
          // const SizedBox(height: AppPadding.p12),
          TotalReportedTimeWidget(
            label: 'Total Reported Time',
            text:
                '${utils.getMonthTotalReportedHours(viewModel.appointmentData)}hrs',
          ),
          buildChartWidget(context, viewModel),
        ],
      ),
    );
  }

  Widget buildChartWidget(BuildContext context, TimeBlocksViewModel viewModel) {
    //DO: id:tags.name

    List<charts.Series<utils.EntryTotal, String>> seriesData = [
      charts.Series(
          id: 'Reported Hours',
          data: utils.entryTotalsByMonth(viewModel.appointmentData),
          domainFn: (entryTotal, _) {
            return Utils.toChartDate(entryTotal.day);
          },
          measureFn: (total, _) {
            return total.value;
          },
          colorFn: (total, __) => charts.ColorUtil.fromDartColor(
              Theme.of(context).colorScheme.primary),
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (total, _) => total.value.toString()),
    ];

    return Expanded(
        child: SizedBox(
            width: double.infinity,
            child: ChartPage(
              seriesData: seriesData,
            )));
  }

 Widget label(String value) {
    return Padding(
        padding: EdgeInsets.fromLTRB(1, 1, 1, 1), child: Text(value));
  }
}
