import 'package:flutter/material.dart';

import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/ui/chart/charts_monthly_page.dart';
import 'package:timey_web/presentation/ui/chart/charts_weekly_page.dart';
import 'package:timey_web/presentation/resources/color_manager.dart';

import '../../widgets/tabbar_widget.dart';


class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildChartsWidget(context);
  }

  Widget buildChartsWidget(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Time Reports',
                  style: Theme.of(context).textTheme.headline1),
            ),
            SizedBox(height: AppSize.s20),
            SizedBox(
              height: 600,
              child: TabBarWidget(
                tabs: [
                  Tab(
                      icon: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      SizedBox(width: AppSize.s12),
                      Text('Month',
                          style: Theme.of(context).textTheme.subtitle1)
                    ],
                  )),
                  Tab(
                      icon: Row(
                    children: [
                      Icon(
                        Icons.calendar_view_week,
                        color: ColorManager.onPrimaryContainer,
                      ),
                      SizedBox(width: AppSize.s12),
                      Text('Week', style: Theme.of(context).textTheme.subtitle1)
                    ],
                  )),
                ],
                children: const [
                  MonthlyChart(),
                  WeeklyChart(),
                ],
              ),
            ),
          ],
        ),
      );
}
