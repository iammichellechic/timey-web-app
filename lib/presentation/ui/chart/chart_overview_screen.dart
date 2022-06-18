import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/ui/chart/charts_monthly_page.dart';
import 'package:timey_web/presentation/ui/chart/charts_weekly_page.dart';
import 'package:timey_web/presentation/resources/color_manager.dart';

import '../../shared/menu_drawer.dart';
import '../../widgets/tabbar_widget.dart';
import '../form/timeblock_adding_page.dart';

class OverView extends StatelessWidget {
  const OverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return  ResponsiveBuilder(
          builder: (context, sizingInformation) =>Row(children: <Widget>[
      if (sizingInformation.isDesktop)
        const MenuDrawer(
          permanentlyDisplay: true,
        ),
      Expanded(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: ColorManager.onPrimaryContainer),
                elevation: 0,
                automaticallyImplyLeading: sizingInformation.isMobile,
                actions: [
                  IconButton(
                    icon:
                        Icon(Icons.add, color: ColorManager.onPrimaryContainer),
                    hoverColor: ColorManager.primaryContainer,
                    onPressed: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                  ),
                ],
              ),
              key: _scaffoldKey,
              extendBodyBehindAppBar: true,
              endDrawer: TimeblockPage(),
              drawer:sizingInformation.isMobile
                  ? const MenuDrawer(
                      permanentlyDisplay: false,
                    )
                  : null,
              body:  buildChartsWidget(context)))
    ]));
  }

  Widget buildChartsWidget(BuildContext context) => TabBarWidget(
        // title: 'Time Reports',
        tabs: [
          Tab(
              icon: Icon(
                Icons.calendar_month,
                color: ColorManager.onPrimaryContainer,
              ),
              child:
                  Text('Month', style: Theme.of(context).textTheme.subtitle1)),
          Tab(
              icon: Icon(
                Icons.calendar_view_week,
                color: ColorManager.onPrimaryContainer,
              ),
              child:
                  Text('Week', style: Theme.of(context).textTheme.subtitle1)),
          // Tab(
          //     icon: Icon(
          //       Icons.receipt,
          //       color: ColorManager.onPrimaryContainer,
          //     ),
          //     child: Text('Summary',
          //         style: Theme.of(context).textTheme.subtitle1)),
        ],
        children: const [
          MonthlyChart(),
          WeeklyChart(),
         
        ],
      );
}
