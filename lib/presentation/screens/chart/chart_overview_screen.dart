import 'package:flutter/material.dart';
import 'package:timey_web/presentation/pages/charts_monthly_page.dart';
import 'package:timey_web/presentation/pages/charts_weekly_page.dart';
import 'package:timey_web/presentation/pages/sample_chart.dart';

import '../../widgets/tabbar_widget.dart';

class OverView extends StatelessWidget {
  const OverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildChartsWidget(context),
    );
  }

  Widget buildChartsWidget(BuildContext context) => TabBarWidget(
        // title: 'Time Reports',
        tabs: [
          Tab(
              icon: Icon(Icons.calendar_month),
              child: Text('Month',
                  style: Theme.of(context).textTheme.subtitle1)),
          Tab(
              icon: Icon(Icons.calendar_view_week),
              child:
                  Text('Week', style: Theme.of(context).textTheme.subtitle1)),
          Tab(
              icon: Icon(Icons.receipt),
              child: Text('Summary',
                  style: Theme.of(context).textTheme.subtitle1)),
        ],
        children: const[
          MonthlyChart(),
          WeeklyChart(),
          SampleChart(),
        ],
      );
}
