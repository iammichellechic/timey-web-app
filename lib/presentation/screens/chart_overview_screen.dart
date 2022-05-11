import 'package:flutter/material.dart';
import 'package:timey_web/presentation/pages/charts_monthly_page.dart';
import 'package:timey_web/presentation/pages/charts_weekly_page.dart';

import '../pages/timeblock_adding_page.dart';
import '../widgets/tabbar_widget.dart';
import '/presentation/resources/color_manager.dart';

import '../shared/menu_drawer.dart';

class OverView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;

    return Row(
      children: [
        if (!displayMobileLayout)
          const MenuDrawer(
            permanentlyDisplay: true,
          ),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: ColorManager.grey),
              elevation: 0,
              automaticallyImplyLeading: displayMobileLayout,
              actions: [
                IconButton(
                  icon: Icon(Icons.add, color: ColorManager.grey),
                  hoverColor: ColorManager.blue.withOpacity(0.6),
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                ),
              ],
            ),
            key: _scaffoldKey,
            //endDrawerEnableOpenDragGesture: false,
            extendBodyBehindAppBar: true,
            endDrawer: TimeblockPage(),
            drawer: displayMobileLayout
                ? const MenuDrawer(
                    permanentlyDisplay: false,
                  )
                : null,
            body: buildChartsWidget(context),
          ),
        )
      ],
    );
  }

  Widget buildChartsWidget(BuildContext context) => TabBarWidget(
        // title: 'Time Reports',
        tabs: [
          Tab(icon: Icon(Icons.calendar_month), child: Text('Monthly', style: Theme.of(context).textTheme.subtitle1)),
          Tab(icon: Icon(Icons.calendar_view_week), child: Text('Weekly', style: Theme.of(context).textTheme.subtitle1)),
          Tab(icon: Icon(Icons.receipt), child: Text('Summary', style:Theme.of(context).textTheme.subtitle1 )),
        ],
        children: [
        MonthlyChart(),
        WeeklyChart(),
        Container(),
        ],
      );

}
