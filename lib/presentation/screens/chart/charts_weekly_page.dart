import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import '../../resources/color_manager.dart';
import '../../widgets/chart_widget.dart';
import '/presentation/utils/chart_utils.dart' as utils;
import '../../../data/providers/timeblocks.dart';
import '../../resources/timeFormat_manager.dart';


class WeeklyChart extends StatelessWidget {
  const WeeklyChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildChartWeeklyWidget(context));
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
              charts.ColorUtil.fromDartColor(ColorManager.secondary),
          labelAccessorFn: (total, _) => '${total.value.toString()}hrs')
    ];

    return ChartWidget(
        seriesData: seriesData,
        text: 'Weekly Time Report',
        style: Theme.of(context).textTheme.headline1);
  }
}
