import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timey_web_scratch/pages/timeblock_editing_page.dart';

import 'package:timey_web_scratch/providers/timeblocks.dart';
import '../model/timeblock_data_source.dart';
import '../shared/menu_drawer.dart';
import '../widgets/entries_widget.dart';

class CalendarWidget extends StatelessWidget {
  static const routeName = '/calendar-timeblock';

  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<TimeBlocks>(context).userTimeBlock;

    return Scaffold(
      appBar: AppBar(
          title: Text('My Time Blocks'),
          actions: <Widget>[
            IconButton(
                tooltip: 'Find a time report',
                onPressed: () {},
                icon: const Icon(Icons.search)),
            SizedBox(
              width: 10,
            ),
            IconButton(
              tooltip: 'Add a time report',
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(TimeblockPage.routeName);
              },
            ),
          ],
        ),
        drawer: MenuDrawer(),
    body:SfCalendar(
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
