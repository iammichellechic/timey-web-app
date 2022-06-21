import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/widgets/chart_widget.dart';
import 'package:timey_web/presentation/widgets/total_reported_time_widget.dart';
import '/presentation/utils/chart_utils.dart' as utils;
import '../../../data/providers/timeblocks.dart';
import '../../resources/formats_manager.dart';

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({Key? key}) : super(key: key);

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
            child: Text('Monthly Time Report',
                style: Theme.of(context).textTheme.headline1),
          ),
          const SizedBox(height: AppPadding.p6),
          Padding(
            padding: EdgeInsets.only(left: AppPadding.p20),
            child: TotalReportedTimeWidget(
              label: 'Total Reported Time',
              text: '${utils.getMonthTotalReportedHours(timeblocks)}hrs',
            ),
          ),
          buildChartWidget(context),
        ],
      ),
    );
  }

  Widget buildChartWidget(BuildContext context) {
    //can also use consumer here than provider.of
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks =
        timeblocksData.getResponseFromQuery(); //list of timeblocks

    //DO: id:tags.name

    List<charts.Series<utils.EntryTotal, String>> seriesData = [
      charts.Series(
          id: 'Reported Hours',
          data: utils.entryTotalsByMonth(timeblocks),
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
            child: ChartWidget(
              seriesData: seriesData,
            )));
  }
}
