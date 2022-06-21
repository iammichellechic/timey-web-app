import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../../resources/values_manager.dart';
import '../../widgets/chart_widget.dart';
import '../../widgets/total_reported_time_widget.dart';
import '/presentation/utils/chart_utils.dart' as utils;
import '../../../data/providers/timeblocks.dart';
import '../../resources/formats_manager.dart';


class WeeklyChart extends StatelessWidget {
  const WeeklyChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.getResponseFromQuery();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text('Weekly Time Report',
                style: Theme.of(context).textTheme.headline1),
          ),
          const SizedBox(height: AppPadding.p6),
          Padding(
            padding: EdgeInsets.only(left: AppPadding.p20),
            child: TotalReportedTimeWidget(
              label: 'Total Reported Time',
              text: '${utils.getWeekTotalReportedHours(timeblocks)}hrs',
            ),
          ),
          buildChartWeeklyWidget(context),
        ],
      ),
    );
  }

  Widget buildChartWeeklyWidget(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.getResponseFromQuery();

    List<charts.Series<utils.EntryTotal, String>> seriesData = [
      charts.Series(
          id: 'Reported Hours',
          data: utils.entryTotalsByWeek(timeblocks),
          domainFn: (entryTotal, _) {
            return Utils.toChartDate(entryTotal.day);
          },
          measureFn: (total, _) {
            return total.value;
          },
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(
              Theme.of(context).colorScheme.secondary),
          labelAccessorFn: (total, _) => total.value.toString())
    ];

     return Expanded(
        child: SizedBox(
            width: double.infinity,
            child: ChartWidget(
              seriesData: seriesData,
            )));
  }
}
