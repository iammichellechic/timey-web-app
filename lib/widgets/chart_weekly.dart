import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_weekly_bar.dart';
import '../providers/timeblock.dart';

class Chart extends StatelessWidget {
  final List<TimeBlock> recentEntries;

  Chart(this.recentEntries);

  List<Map<String, Object>> get groupedEntriesValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      
      var totalHours =0;

      for (var i = 0; i < recentEntries.length; i++) {
        if (recentEntries[i].startDate.day == weekDay.day &&
            recentEntries[i].startDate.month == weekDay.month &&
            recentEntries[i].startDate.year == weekDay.year) {
          totalHours += recentEntries[i].reportHours;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
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
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedEntriesValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'] as String,
                data['reportHours'] as int,
                totalHours == 0.0
                    ? 0.0
                    : (data['reportHours'] as int) / totalHours,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
