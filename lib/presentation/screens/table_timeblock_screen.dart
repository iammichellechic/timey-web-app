import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/timeblock_adding_page.dart';
import '../shared/menu_drawer.dart';
import '../../data/providers/timeblocks.dart';


import '../pages/table_timeblock_page.dart';
import '../resources/color_manager.dart';
import '../widgets/chart_weekly.dart';

//right now this screen has no purpose

class EditablePage extends StatefulWidget {
  
  @override
  State<EditablePage> createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {


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
            body: buildTableItems(context),
          ),
        )
      ],
    );
  }

  Widget buildTableItems(BuildContext context){
    final timeblocksData = Provider.of<TimeBlocks>(context);
  
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
               // Chart(timeblocksData.recentEntries), //no prupose
                MyDataTable(),
              ],
               
                ),
            ),
          ),
        );

  }
}

