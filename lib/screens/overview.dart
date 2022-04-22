import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../utils.dart';
import '../providers/timeblock.dart';
import '../shared/menu_drawer.dart';
import '../providers/timeblocks.dart';

class OverView extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;
    //final chartItems = timeblocksData.recentEntries;

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
      appBar: AppBar(
        title: Text('Timey'),
        actions: [
          IconButton(
              tooltip: 'Search',
              onPressed: () {},
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: MenuDrawer(),
      body: Container(
        height: 600,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Reported Hours',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
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
        ),
      ),
    );
  }
}
