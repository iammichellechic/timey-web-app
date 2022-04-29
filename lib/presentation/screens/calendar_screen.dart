import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timey_web_scratch/presentation/resources/color_manager.dart';
import '../../data/providers/timeblocks.dart';
import '../pages/timeblock_editing_page.dart';

import '../../model/timeblock_data_source.dart';
import '../shared/menu_drawer.dart';
import '../widgets/entries_widget.dart';

class CalendarWidget extends StatelessWidget {
  static const routeName = '/calendar-timeblock';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const breakpoint = 600.0;

    if (screenWidth >= breakpoint) {
      return Row(
        children: [
          SizedBox(child: MenuDrawer()),
          VerticalDivider(
             width: 1,
             color: ColorManager.grey,
          ),
          Expanded(
            child: buildCalendarWidget(context),
          ),
        ],
      );
    } else {
      return Scaffold(
          body: buildCalendarWidget(context),
          drawer: SizedBox(
            width: 240,
            child: Drawer(child: MenuDrawer()),
          ));
    }
  }

  Widget buildCalendarWidget(BuildContext context) {
    final entries = Provider.of<TimeBlocks>(context).userTimeBlock;
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
        body: SfCalendar(
          view: CalendarView.month,
          dataSource: EventDataSource(entries),
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.transparent,
          onSelectionChanged: (details) {
            final provider = Provider.of<TimeBlocks>(context, listen: false);

            provider.setDate(details.date!);
          },
          onTap: (details) {
            final provider = Provider.of<TimeBlocks>(context, listen: false);

            if (provider.selectedDate == details.date) {
              showModalBottomSheet(
                context: context,
                builder: (context) => EntriesWidget(),
              );
            }
          },
          onLongPress: (details) {
            final provider = Provider.of<TimeBlocks>(context, listen: false);

            provider.setDate(details.date!);
            showModalBottomSheet(
              context: context,
              builder: (context) => EntriesWidget(),
            );
          },
        ));
  }
}
