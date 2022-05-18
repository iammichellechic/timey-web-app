import 'package:flutter/material.dart';
import 'package:timey_web/presentation/pages/charts_monthly_page.dart';
import 'package:timey_web/presentation/pages/charts_weekly_page.dart';

import '../widgets/tabbar_widget.dart';

class OverView extends StatelessWidget {
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
              child: Text('Monthly',
                  style: Theme.of(context).textTheme.subtitle1)),
          Tab(
              icon: Icon(Icons.calendar_view_week),
              child:
                  Text('Weekly', style: Theme.of(context).textTheme.subtitle1)),
          Tab(
              icon: Icon(Icons.receipt),
              child: Text('Summary',
                  style: Theme.of(context).textTheme.subtitle1)),
        ],
        children: [
          MonthlyChart(),
          WeeklyChart(),
          Container(),
        ],
      );
}
