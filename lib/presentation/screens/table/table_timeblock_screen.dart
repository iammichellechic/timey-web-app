import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/screens/table/table_timeblock_page.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';

import '../../resources/color_manager.dart';
import '../../shared/menu_drawer.dart';
import '../form/timeblock_adding_page.dart';


class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return ResponsiveBuilder(
        builder: (context, sizingInformation) => Row(children: <Widget>[
              if (sizingInformation.isDesktop)
                const MenuDrawer(
                  permanentlyDisplay: true,
                ),
              Expanded(
                  child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        iconTheme: IconThemeData(
                            color: ColorManager.onPrimaryContainer),
                        elevation: 0,
                        automaticallyImplyLeading: sizingInformation.isMobile,
                        actions: [
                          IconButton(
                            icon: Icon(Icons.add,
                                color: ColorManager.onPrimaryContainer),
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
                      drawer: sizingInformation.isMobile
                          ? const MenuDrawer(
                              permanentlyDisplay: false,
                            )
                          : null,
                      body: Expanded(child: buildTableItems(context))))
            ]));
  }

  Widget buildTableItems(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: AppPadding.p30),
          child: MyDataTable()
          // child: Column(
          //   mainAxisSize: MainAxisSize.max,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const <Widget>[
          //     //Chart(timeblocksData.recentEntries), //no prupose
          //     MyDataTable()
          //   ],
          // ),
        ),
      ),
    );
  }
}
