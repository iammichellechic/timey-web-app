import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web_scratch/presentation/resources/values_manager.dart';
import '../../data/providers/timeblocks.dart';
import '../pages/timeblock_editing_page.dart';

import '../pages/table_timeblock_datatable.dart';
import '../resources/color_manager.dart';
import '../widgets/chart_weekly.dart';
import '../shared/menu_drawer.dart';

class EditablePage extends StatefulWidget {
  
  @override
  State<EditablePage> createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {


  @override
  Widget build(BuildContext context) {
     
      final screenWidth = MediaQuery.of(context).size.width;
    const breakpoint = 600.0;

    if (screenWidth >= breakpoint) {
   
    return Row(
      children: [
        MenuDrawer(),
        VerticalDivider(
           width: 1,
           color: ColorManager.grey,
        ),
        Expanded(
        child:buildTableItems(context))
      ],
    );
  } else {
      return Scaffold(
          body: buildTableItems(context),
          drawer: SizedBox(
            width: 240,
            child: Drawer(child: MenuDrawer()),
          ));
    }
  }

  Widget buildTableItems(BuildContext context){
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
          key: _scaffoldKey,
          //endDrawerEnableOpenDragGesture: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
           actions: [
              IconButton(
                icon: Icon(Icons.add, color: ColorManager.grey),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              ),
            ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        endDrawer: TimeblockPage(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: AppPadding.p20),
            child: Column(
              children: <Widget>[
              Chart(timeblocksData.recentEntries), //no purpose
              MyDataTable(),
            ],
             
              ),
          ),
          ),
        );

  }
}

