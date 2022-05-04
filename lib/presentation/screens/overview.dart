import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:timey_web_scratch/presentation/resources/color_manager.dart';

import '../../data/providers/timeblock.dart';
import '../../data/providers/timeblocks.dart';
import '../resources/timeFormat_manager.dart';

import '../resources/values_manager.dart';
import '../shared/menu_drawer.dart';


class OverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const breakpoint = 600.0;

    if (screenWidth >= breakpoint) {
      return Row(
        children: [
          SizedBox(child: MenuDrawer()),
          VerticalDivider(
            width: 1,
            color: ColorManager.grey,
          ),
          Expanded(
            child: buildChartWidget(context),
          )
        ],
      );
    } else {
      return Scaffold(
          body: buildChartWidget(context),
          drawer: SizedBox(
            width: 240,
            child: Drawer(child: MenuDrawer()),
          ));
    }
  }

  Widget buildChartWidget(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;

    print(timeblocks.first.reportHours);
    print(timeblocks.first.remainingMinutes);

    List<charts.Series<TimeBlock, String>> seriesData = [
      charts.Series(
        id: 'Reported Hours',
        data: timeblocks,
        domainFn: (TimeBlock tb, _) => Utils.toDateAbbrLabel(tb.startDate),
        measureFn: (TimeBlock tb, _) => tb.reportHours,
        colorFn: (TimeBlock tb, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
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
                'Reported Hours',
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
