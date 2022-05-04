import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:timey_web_scratch/presentation/resources/color_manager.dart';

import '../../data/providers/timeblocks.dart';
import '../../model/timeblock_data_source.dart';
import '../resources/font_manager.dart';
import 'dialogs.dart';

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
          style: Theme.of(context).textTheme.headline1,
        ),
      );
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(
          timeTextStyle: Theme.of(context).textTheme.subtitle1),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(entries),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: ColorManager.black,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        onTap: (details) {
          if (details.appointments == null) return;

          final event = details.appointments!.first;

          showDialog<EntryItemDialog>(
            context: context,
            builder: (context) {
              return EntryItemDialog(
                entry: event,
              );
            },
          );

          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => TimeBlockItem(entry: event),
          //));
        },
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 7,
          endHour: 24,
          timeIntervalWidth: 100,
          dayFormat: 'EEE',
          timeFormat: 'HH:mm',
          timeTextStyle: TextStyle(
              fontWeight: FontWeightManager.bold,
              fontStyle: FontStyle.italic,
              fontSize: FontSize.s16,
              color: ColorManager.blue),
        ),
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
        color: ColorManager.blue.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(event.tag!.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}
