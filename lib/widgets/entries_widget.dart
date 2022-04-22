import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:timey_web_scratch/widgets/timeblock_item.dart';

import '../model/timeblock_data_source.dart';
import '../providers/timeblocks.dart';


class EntriesWidget extends StatefulWidget {
  @override
  _EntriesWidgetState createState() => _EntriesWidgetState();
}

class _EntriesWidgetState extends State<EntriesWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeBlocks>(context);
    final selectedEvents = provider.entriesOfSelectedDate;
    final entries = provider.userTimeBlock;
    

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text(
          'No Entries found!',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: TextStyle(fontSize: 16, color: Colors.black),
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(entries),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        onTap: (details) {
          if (details.appointments == null) return;

          final event = details.appointments!.first;

          Navigator.of(context).push(MaterialPageRoute(
          
            builder: (context) => TimeBlockItem(entry: event),
          ));
        },
      ),
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        //color:event.tag!.color
        color: Colors.blue.withOpacity
        (0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          event.tag!.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
