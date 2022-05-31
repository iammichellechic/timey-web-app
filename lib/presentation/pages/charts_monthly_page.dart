import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/resources/color_manager.dart';
import 'package:timey_web/presentation/widgets/chart_widget.dart';
import '/presentation/utils/chart_utils.dart' as utils;
import '../../data/providers/timeblocks.dart';
import '../resources/timeFormat_manager.dart';

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildChartWidget(context));
  }

  Widget buildChartWidget(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock; //list of timeblocks

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
          colorFn: (total, __) =>
              charts.ColorUtil.fromDartColor(ColorManager.blue),
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (total, _) => '${total.value}hrs'),
    ];

    return ChartWidget(
        seriesData: seriesData,
        text: 'Monthly Time Report',
        style: Theme.of(context).textTheme.headline1);
  }
}
