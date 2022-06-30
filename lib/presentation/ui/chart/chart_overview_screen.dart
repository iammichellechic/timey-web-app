import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/ui/chart/charts_monthly_page.dart';
import 'package:timey_web/presentation/ui/chart/charts_weekly_page.dart';
import 'package:timey_web/presentation/resources/color_manager.dart';
import '../../shared/menu_drawer.dart';
import '../../widgets/animatedicon_widget.dart';
import '../../widgets/tabbar_widget.dart';
import '../form/timeblock_adding_page.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) => 
        Row(
          children: <Widget>
          [
              if (sizingInformation.isDesktop)
                const MenuDrawer(
                  permanentlyDisplay: true,
                ),
              Expanded(
                  child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  iconTheme: Theme.of(context).iconTheme,
                  elevation: 0,
                  automaticallyImplyLeading: sizingInformation.isMobile,
                  actions: const [
                    AnimatedIconWidget(),
                  ],
                ),
                //extendBodyBehindAppBar: true,
                endDrawer: TimeblockPage(),
                drawer: sizingInformation.isMobile
                    ? const MenuDrawer(
                        permanentlyDisplay: false,
                      )
                    : null,
                body: 
                   // BreadCrumbNavigator(),
                   buildChartsWidget(context),
              ))
            ]));
  }

  Widget buildChartsWidget(BuildContext context) =>

      SingleChildScrollView(
        child: Column(
           mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Time Reports',
                  style: Theme.of(context).textTheme.headline1),
            ),
          SizedBox(height: AppSize.s10),
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
                        Text('Month', style: Theme.of(context).textTheme.subtitle1)
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
