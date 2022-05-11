import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import '../../data/providers/timeblock.dart';
import '../pages/timeblock_adding_page.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/theme_manager.dart';
import '../resources/timeFormat_manager.dart';
import '../widgets/dialogs_widget.dart';
import '/presentation/resources/color_manager.dart';
import '../../data/providers/timeblocks.dart';

import '../../model/timeblock_data_source.dart';
import '../shared/menu_drawer.dart';

class CalendarWidget extends StatelessWidget {
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
            //extendBodyBehindAppBar: true,
            endDrawer: TimeblockPage(),
            drawer: displayMobileLayout
                ? const MenuDrawer(
                    permanentlyDisplay: false,
                  )
                : null,
            body: buildCalendarWidget(context),
          ),
        )
      ],
    );
  }

  Widget buildCalendarWidget(BuildContext context) {
    final entries = Provider.of<TimeBlocks>(context).userTimeBlock;

    return Scaffold(
        body: SfCalendar(
      view: CalendarView.week,
      allowedViews: <CalendarView>[
        //CalendarView.day,
        CalendarView.week,
        CalendarView.month,
      ],
      allowViewNavigation: true,
      showNavigationArrow: true,
      showWeekNumber: true,
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
        dayFormat: 'EEE',
        timeFormat: 'HH:mm',
        timeTextStyle: TextStyle(
            fontWeight: FontWeightManager.bold,
            fontStyle: FontStyle.italic,
            fontSize: FontSize.s14,
            color: ColorManager.grey),
      ),
      firstDayOfWeek: 1,
      dataSource: EventDataSource(entries),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      // onSelectionChanged: (details) {
      //   final provider = Provider.of<TimeBlocks>(context, listen: false);

      //   provider.setDate(details.date!);
      // },
    ));
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(top: AppPadding.p12),
            width: details.bounds.width,
            height: details.bounds.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s10),
              color: ColorManager.blue.withOpacity(0.5),
            ),
            //spacing issues//
            child: ListTile(
              selected: true,
                title: Text(
                  event.tag!.name,
                  style: getAppTheme().textTheme.subtitle1,
                ),
                
                subtitle: Column(
                    children: <Widget>[
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
                  trailing: SizedBox(
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
                            )),
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
                      onSelected: (item) => selectedItem(context, item, event),
                    ),
                  ),
                )
               ));
  }

  Widget buildDate(String title, DateTime date) {
    final styleTitle = getAppTheme().textTheme.bodyText1;
    final styleDate = getAppTheme().textTheme.bodyText2;

    return Container(
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
      //padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
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
                  Navigator.of(context).pushNamed(Routes.calendarRoute);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: ColorManager.primaryWhite,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Text('Entry Removed',
                            style: Theme.of(context).textTheme.headline4)),
                  );
                },
              )
            ],
          ),
        );
        break;
    }
  }
}
