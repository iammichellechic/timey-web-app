import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../shared/menu_drawer.dart';
import '../../widgets/animatedicon_widget.dart';
import '../form/timeblock_adding_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
                        iconTheme: Theme.of(context).iconTheme,
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
                      body: buildSettingsWidget(context)))
            ]));
  }
}



  @override
  Widget buildSettingsWidget(BuildContext context) {
    return SizedBox(child: Center(child: Text('This is the settings section')));
  }

