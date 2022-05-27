import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/resources/font_manager.dart';
import '/presentation/utils/chart_utils.dart' as utils;
import '../../data/providers/timeblocks.dart';
import '../resources/timeFormat_manager.dart';
import '../resources/values_manager.dart';

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
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (total, _) => '${total.value}hrs'),
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
                  barRendererDecorator: charts.BarLabelDecorator<String>(
                      insideLabelStyleSpec: charts.TextStyleSpec(
                          fontFamily: FontConstants.fontFamily,
                          fontSize: 10,
                          color: charts.MaterialPalette.white),
                      outsideLabelStyleSpec: charts.TextStyleSpec(
                          fontFamily: FontConstants.fontFamily,
                          fontSize: 10,
                          color: charts.MaterialPalette.blue.shadeDefault)),
                  domainAxis: charts.OrdinalAxisSpec(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
