import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:stacked/stacked.dart';

import 'chart_page.dart';
import '/viewmodels/timeblocks_viewmodels.dart';
import '../../resources/values_manager.dart';

import '../../widgets/total_reported_time_widget.dart';
import '/presentation/utils/chart_utils.dart' as utils;

import '../../resources/formats_manager.dart';

class WeeklyChart extends ViewModelWidget<TimeBlocksViewModel> {
  const WeeklyChart({Key? key}) : super(key: key);

    // static MaterialPageRoute getRoute() => MaterialPageRoute(
    //   settings: RouteSettings(name: 'Weekly'),
    //   builder: (context) => WeeklyChart());

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
          //   child: Text('Weekly Time Report',
          //       style: Theme.of(context).textTheme.headline1),
          // ),
          // const SizedBox(height: AppPadding.p12),
          TotalReportedTimeWidget(
            label: 'Total Reported Time',
            text:
                '${utils.getWeekTotalReportedHours(viewModel.appointmentData)}hrs',
          ),
          buildChartWeeklyWidget(context, viewModel),
        ],
      ),
    );
  }

  Widget buildChartWeeklyWidget(
      BuildContext context, TimeBlocksViewModel viewModel) {
    List<charts.Series<utils.EntryTotal, String>> seriesData = [
      charts.Series(
          id: 'Reported Hours',
          data: utils.entryTotalsByWeek(viewModel.appointmentData),
          domainFn: (entryTotal, _) {
            return Utils.toChartDate(entryTotal.day);
          },
          measureFn: (total, _) {
            return total.value;
          },
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              Theme.of(context).colorScheme.secondary),
          labelAccessorFn: (total, _) => total.value.toString())
    ];

    return Expanded(
        child: SizedBox(
            width: double.infinity,
            child: ChartPage(
              seriesData: seriesData,
            )));
  }
}
