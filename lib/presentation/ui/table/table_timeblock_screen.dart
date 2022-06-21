import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/ui/table/table_timeblock_page.dart';
import '../../resources/color_manager.dart';
import '../../shared/menu_drawer.dart';
import '../../widgets/animatedicon_widget.dart';
import '../form/timeblock_adding_page.dart';


class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
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
                        actions: const [
                          AnimatedIconWidget(),
                        ],
                      ),
                      extendBodyBehindAppBar: true,
                      endDrawer: TimeblockPage(),
                      drawer: sizingInformation.isMobile
                          ? const MenuDrawer(
                              permanentlyDisplay: false,
                            )
                          : null,
                      body:  buildTableItems(context)))
            ]));
  }

  Widget buildTableItems(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: MyDataTable()
        ),
      ),
    );
  }
}
