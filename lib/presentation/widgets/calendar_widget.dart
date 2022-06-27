import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class CalendarWidget extends StatelessWidget {
  final CalendarDataSource<Object?>? dataSource;
  final Widget Function(BuildContext, CalendarAppointmentDetails)?
      appointment;
  const CalendarWidget({Key? key, required this.dataSource, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SfCalendar(
        view: CalendarView.month,
        allowedViews: const <CalendarView>[
          CalendarView.week,
          CalendarView.month,
          CalendarView.schedule,
        ],
        allowViewNavigation: true,
        showNavigationArrow: true,
        //showWeekNumber: true,
        firstDayOfWeek: 1,
        dataSource: dataSource,
        initialSelectedDate: DateTime.now(),
        cellBorderColor: Colors.transparent,
        initialDisplayDate: DateTime.now(),
        appointmentBuilder: appointment,

        //MONTHVIEW setting
        monthViewSettings: MonthViewSettings(
            showAgenda: true,
            agendaItemHeight: 150,
            agendaStyle: AgendaStyle(
              dateTextStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
              dayTextStyle: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            )),

        //TIMESLOTVIEW
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 7,
          endHour: 24,
          numberOfDaysInView: sizingInformation.isDesktop ? 7 : 2,
          dayFormat: 'EEE',
          timeFormat: 'HH:mm',
          timeTextStyle: TextStyle(
              fontWeight: FontWeightManager.bold,
              fontFamily: FontConstants.fontFamily,
              fontSize: FontSize.s14,
              color: ColorManager.grey),
        ),

        //SCHEDULEVIEW
        scheduleViewSettings: ScheduleViewSettings(
            appointmentItemHeight: 120, hideEmptyScheduleWeek: true),
      ),
    );
  }
}
