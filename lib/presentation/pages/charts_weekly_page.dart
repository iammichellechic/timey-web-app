import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '/presentation/utils/chart_utils.dart' as utils;

import '../../data/providers/timeblocks.dart';
import '../resources/timeFormat_manager.dart';

import '../resources/values_manager.dart';

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildChartWeeklyWidget(context));
  }

  Widget buildChartWeeklyWidget(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;


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
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        labelAccessorFn: (total, _) =>
              '${total.value.toString()}hrs')
      
    ];

    return Scaffold(
      body: Container(
        // height: 600,
        padding: EdgeInsets.all(AppPadding.p12),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Weekly Time Report',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: AppSize.s5),
              Expanded(
                child: charts.BarChart(
                  seriesData,
                  animate: true,
                  barRendererDecorator: charts.BarLabelDecorator<String>(),
                  domainAxis: charts.OrdinalAxisSpec(),
                  barGroupingType: charts.BarGroupingType.groupedStacked,
                  animationDuration: Duration(milliseconds: 500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
