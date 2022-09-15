import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:timey_web/presentation/ui/table/table_timeblock_page.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTableItems(context);
  }

  Widget buildTableItems(BuildContext context) {
    final ScrollController controller = ScrollController();

    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: Scaffold(
            body: ResponsiveBuilder(
          builder: (context, sizingInformation) => SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Center(
                child: SizedBox(
                    width: sizingInformation.isDesktop
                        ? MediaQuery.of(context).size.width* 0.9
                        : 1000,
                    height: 800,
                    child: MyDataTable())),
          ),
        )));
  }
}
