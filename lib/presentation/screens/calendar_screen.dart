import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/utils/snackbar_utils.dart';

import '../../data/providers/timeblock.dart';
import '../../locator.dart';
import '../../navigation-service.dart';

import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/theme_manager.dart';
import '../resources/timeFormat_manager.dart';
import '../widgets/dialogs_widget.dart';
import '/presentation/resources/color_manager.dart';
import '../../data/providers/timeblocks.dart';

import '../../model/timeblock_data_source.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: buildCalendarWidget(context));
  }

  Widget buildCalendarWidget(BuildContext context) {
    final entries = Provider.of<TimeBlocks>(context).userTimeBlock;

    return SfCalendar(
      view: CalendarView.week,
      allowedViews: const <CalendarView>[
        CalendarView.week,
        CalendarView.month,
        CalendarView.schedule,
      ],
      allowViewNavigation: true,
      showNavigationArrow: true,
      //showWeekNumber: true,
      initialDisplayDate: DateTime.now(),
      appointmentBuilder: appointmentBuilder,
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
      timeSlotViewSettings: TimeSlotViewSettings(
        startHour: 7,
        endHour: 24,
        numberOfDaysInView: 3,
        // nonWorkingDays: <int>[
        //   DateTime.saturday,
        //   DateTime.sunday,
        // ],
        dayFormat: 'EEE',
        timeFormat: 'HH:mm',
        timeTextStyle: TextStyle(
            fontWeight: FontWeightManager.bold,
            fontStyle: FontStyle.italic,
            fontSize: FontSize.s14,
            color: ColorManager.grey),
      ),
      scheduleViewSettings: ScheduleViewSettings(
          appointmentItemHeight: 100, hideEmptyScheduleWeek: true),
      firstDayOfWeek: 1,
      dataSource: EventDataSource(entries),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;

    return Container(
        padding: EdgeInsets.all(AppPadding.p8),
        width: details.bounds.width,
        height: details.bounds.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
          color: ColorManager.blue.withOpacity(0.5),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                selected: true,
                title: Text(
                  event.tag!.name,
                  style: getAppTheme().textTheme.subtitle1,
                ),
                subtitle: Column(children: <Widget>[
                  buildDuration(
                    event!.reportHours.toString() +
                        ' ' +
                        'hrs' +
                        ' ' +
                        event!.remainingMinutes.toString() +
                        ' ' +
                        'mins',
                  ),
                  buildDate('From', event.startDate),
                  buildDate('To', event.endDate),
                ]),
                trailing: buildActionMethods(context, event),
              ),
            ],
          ),
        ));
  }

  Widget buildDate(String title, DateTime date) {
    final styleTitle = getAppTheme().textTheme.bodyText1;
    final styleDate = getAppTheme().textTheme.bodyText2;

    return Container(
      padding: EdgeInsets.only(top: AppPadding.p8),
      child: Row(
        children: [
          Expanded(child: Text(title, style: styleTitle)),
          Text(Utils.toTime(date), style: styleDate),
        ],
      ),
    );
  }

  Widget buildDuration(String text) {
    final styleDate = getAppTheme().textTheme.bodyText2;

    return Container(
      padding: EdgeInsets.only(top: AppPadding.p8),
      child: Text(text, style: styleDate),
    );
  }

  void selectedItem(BuildContext context, item, TimeBlock? entry) {
    switch (item) {
      case 0:
        showGlobalDrawer<EntryEditDialog>(
          context: context,
          direction: AxisDirection.right,
          duration: Duration(seconds: 1),
          builder: (context) {
            return EntryEditDialog(
              entry: entry,
            );
          },
        );
        break;
      case 1:
        showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Delete entry?',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: [
              TextButton(
                child: Text('Cancel',
                    style: Theme.of(context).textTheme.headline4),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text(
                  'Delete',
                  style: Theme.of(context).textTheme.headline5,
                ),
                onPressed: () {
                  final provider =
                      Provider.of<TimeBlocks>(context, listen: false);
                  provider.deleteTimeBlock(entry!.id);
                  //punshNamed vs popUntil??
                  Navigator.of(context)
                      .pop(); //it should pop before redirecting

                  locator<NavigationService>().navigateTo(Routes.calendarRoute);

                  SnackBarUtils.showSnackBar(
                    context: context,
                    text: 'Entry removed',
                    color: ColorManager.primaryWhite.withOpacity(0.7),
                    icons: Icons.delete,
                    iconColor: ColorManager.error
                  );
                },
              )
            ],
          ),
        );
        break;
    }
  }

  Widget buildActionMethods(BuildContext context, TimeBlock? entry) {
    return SizedBox(
      width: 20,
      child: PopupMenuButton(
        iconSize: AppSize.s12,
        color: ColorManager.lightBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            value: 0,
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: Text(
                "Edit",
                // style: TextStyle(color: Colors.white),
              ),
            ),
            // onTap: () async {
            //  // Provider.of<TimeBlocks>(context, listen: true);
            //   Scaffold.of(context).openEndDrawer();
            // }
          ),
          PopupMenuItem<int>(
              value: 1,
              child: ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              )),
        ],
        onSelected: (item) => selectedItem(context, item, entry),
      ),
    );
  }
}
