import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../utils/chart_utils.dart';
import '../../resources/values_manager.dart';

class ChartPage extends StatelessWidget {
  final List<charts.Series<EntryTotal, String>> seriesData;


  const ChartPage(
      {Key? key, required this.seriesData})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Container(
        //height: 100,
        padding: EdgeInsets.all(AppPadding.p12),
        child: Center(
          child: Column(
            children: <Widget>[
             
              Expanded(
                  child: charts.BarChart(
                seriesData,
                animate: true,
                barGroupingType: charts.BarGroupingType.grouped,
                behaviors: [charts.SeriesLegend()],
                animationDuration: Duration(milliseconds: 500),
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      lineHeight: 3,
                      fontSize: 11,
                      color: charts.ColorUtil.fromDartColor(ColorManager.grey),
                    ),
                    lineStyle: charts.LineStyleSpec(
                        color:
                            charts.ColorUtil.fromDartColor(Colors.transparent)),
                  ),
                ),
                defaultRenderer: charts.BarRendererConfig(
                    cornerStrategy: charts.ConstCornerStrategy(10),
                    barRendererDecorator: charts.BarLabelDecorator<String>(
                      labelPadding: 10,
                        insideLabelStyleSpec: charts.TextStyleSpec(
                            fontFamily: FontConstants.fontFamily,
                            fontSize: 10,
                            lineHeight: 2 ,
                            color: charts.ColorUtil.fromDartColor(
                                Theme.of(context).colorScheme.onPrimary)
                                ),
                        outsideLabelStyleSpec: charts.TextStyleSpec(
                            fontFamily: FontConstants.fontFamily,
                            fontSize: 10,
                            color: charts.ColorUtil.fromDartColor(
                                Theme.of(context).colorScheme.primary)))),
                primaryMeasureAxis: charts.NumericAxisSpec(
                  tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                      (num? value) => "$value \u{1F551}"),
                  renderSpec: charts.GridlineRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      fontSize: 12,
                      color: charts.ColorUtil.fromDartColor(
                          Theme.of(context).colorScheme.primaryContainer),
                    ),
                    labelAnchor: charts.TickLabelAnchor.after,
                  ),
                ),
              )),
            ],
          ),
        ),
      ));
}
