import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timey_web_scratch/presentation/resources/values_manager.dart';

import '../../data/providers/timeblock.dart';
import '../resources/timeFormat_manager.dart';
import './chart_weekly_bar.dart';

class Chart extends StatelessWidget {
  final List<TimeBlock> recentTimeEntries;

  Chart(this.recentTimeEntries);

  List<Map<String, Object>> get groupedEntriesValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalHours = 0;

      for (var i = 0; i < recentTimeEntries.length; i++) {
        if (recentTimeEntries[i].startDate.day == weekDay.day &&
            recentTimeEntries[i].startDate.month == weekDay.month &&
            recentTimeEntries[i].startDate.year == weekDay.year) {
          totalHours += recentTimeEntries[i].reportHours;
        }
      }
      return {
        'day': Utils.toDateAbbrLabel(weekDay),
        'reportHours': totalHours,
      };
    }).reversed.toList();
  }

  int get totalHours {
    return groupedEntriesValues.fold(0, (total, item) {
      return total + (item['reportHours'] as int);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedEntriesValues);
    // return Card(
    //   elevation: 6,
    //   margin: EdgeInsets.all(20),
    //   child: Padding(
    //     padding: EdgeInsets.all(10),
    return Padding(
        padding: EdgeInsets.all(AppPadding.p12),
        child: Column(children: <Widget>[
          Text(
            'Weekly Reported Hours',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: AppSize.s5),
          Container(
              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(AppSize.s10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: this.groupedEntriesValues.map((data) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      data['day'] as String,
                      data['reportHours'] as int,
                      totalHours == 0
                          ? 0
                          : (data['reportHours'] as int) / totalHours,
                    ),
                  );
                }).toList(),
              )),
        ]));
  }
}
