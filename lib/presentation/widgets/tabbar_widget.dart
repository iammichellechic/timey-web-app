import 'package:flutter/material.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';

import '../resources/color_manager.dart';

class TabBarWidget extends StatelessWidget {
  //final String title;
  final List<Tab> tabs;
  final List<Widget> children;

  const TabBarWidget({
    Key? key,
    //required this.title,
    required this.tabs,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 1,
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              isScrollable: true,
              tabs: tabs,
              indicator: 
              BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s50), // Creates border
                      color: ColorManager.blue.withOpacity(0.6)), 
            ),
            elevation: 0,

          ),
          body: TabBarView(children: children),
        ),
      );
}