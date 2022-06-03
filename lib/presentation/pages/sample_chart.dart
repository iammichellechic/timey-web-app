import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/resources/color_manager.dart';
import '../resources/values_manager.dart';
import '/presentation/utils/chart_utils.dart' as utils;
import '../../data/providers/timeblocks.dart';
import '../resources/timeFormat_manager.dart';


//NOT DONE
class SampleChart extends StatelessWidget {
  const SampleChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildChartMonthlyPie(context));
  }

  Widget buildChartMonthlyPie(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;
    double _totalTime = 0;

    List<charts.Series<utils.EntryTotal, int>> seriesData= [
      charts.Series(
        id: 'Total Monthly Reported Hours',
        data: utils.entryTotalsByWeek(timeblocks),
        domainFn: (entryTotal, _) {
          return entryTotal.day as int;
        },
        measureFn: (total, _) {
          return total.value;
        },
        // colorFn: (total, __) =>
        //     charts.ColorUtil.fromDartColor(ColorManager.blue),
        // Set a label accessor to control the text of the bar label.
      )
    ];

    return  Card(
      child: SizedBox(
        height: 450,
        child: Stack(
          children: [ 
            
                  Expanded(
                    child: charts.PieChart(
                      seriesData,
                      animate: false,
                      defaultRenderer: charts.ArcRendererConfig(
                        arcWidth: 60,
                      ),
                    ),
                  )])));
        

               
                }

           
  }

  Widget _buildLabel({String? label, double? money}) {
    return Center(
      child: SizedBox(
        width: 150,
        child: Text(
          '$label\n$money',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
