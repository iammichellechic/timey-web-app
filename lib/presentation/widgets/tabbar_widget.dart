import 'package:flutter/material.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';

class TabBarWidget extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> children;

  const TabBarWidget({
    Key? key,
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
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(AppSize.s50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    tabs: tabs,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppSize.s50), // Creates border
                        color: Theme.of(context).colorScheme.primaryContainer),
                  ),
                )),
            elevation: 0,
          ),
          body: TabBarView(children: children),
        ),
      );
}
