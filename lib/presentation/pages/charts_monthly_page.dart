import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '/presentation/utils/chart_utils.dart' as utils;

import '../../data/providers/timeblocks.dart';
import '../resources/timeFormat_manager.dart';

import '../resources/values_manager.dart';

//detwrmines how many days before will render in the vhart
const _daysBefore = 30;

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(body:buildChartWidget(context)
      
    );
  }

   Widget buildChartWidget(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;

    print(timeblocks.first.reportHours);
    print(timeblocks.first.remainingMinutes);

    List<charts.Series<utils.EntryTotal, String>> seriesData = [
      charts.Series(
        id: 'Reported Hours',
        data: utils.entryTotalsByDay(timeblocks, _daysBefore),
        domainFn: (entryTotal, _) {
          return Utils.toChartDate(entryTotal.day);
        },
        measureFn: (total, _) {
          return total.value;
        },
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];

    return Scaffold(
      body: Container(
        // height: 600,
        padding: EdgeInsets.all(AppPadding.p12),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Monthly Time Report',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: AppSize.s5),
              Expanded(
                child: charts.BarChart(
                  seriesData,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.grouped,
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