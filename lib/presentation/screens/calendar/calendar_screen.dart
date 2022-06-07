import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/utils/snackbar_utils.dart';

import '../../../data/providers/timeblock.dart';
import '../../../locator.dart';
import '../../../navigation-service.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/theme_manager.dart';
import '../../resources/timeFormat_manager.dart';
import '../../widgets/dialogs_widget.dart';
import '/presentation/resources/color_manager.dart';
import '../../../data/providers/timeblocks.dart';
import '../../../model/timeblock_data_source.dart';

class CalendarWidget extends StatelessWidget {
  bool isFetched = false;
  CalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: buildCalendarWidget(context));
  }

  Widget buildCalendarWidget(BuildContext context) {
    //final entries = Provider.of<TimeBlocks>(context).getList;

    return Container(
        padding: EdgeInsets.only(top: AppPadding.p40),
        child: Consumer<TimeBlocks>(builder: (context, task, child) {
          if (isFetched == false) {
            ///Fetch the data
            task.getTimeblocks(true);

            Future.delayed(const Duration(seconds: 3), () => isFetched = true);
          }
          return RefreshIndicator(
            onRefresh: () {
              task.getTimeblocks(false);
              return Future.delayed(const Duration(seconds: 3));
            },
            child: SfCalendar(
              view: CalendarView.week,
              allowedViews: const <CalendarView>[
                CalendarView.week,
                CalendarView.month,
                CalendarView.schedule,
              ],
              allowViewNavigation: true,
              showNavigationArrow: true,
              //showWeekNumber: true,
              firstDayOfWeek: 1,
              dataSource: EventDataSource(task.getResponseFromQuery()),
              initialSelectedDate: DateTime.now(),
              cellBorderColor: Colors.transparent,
              initialDisplayDate: DateTime.now(),
              appointmentBuilder: appointmentBuilder,
             

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
                numberOfDaysInView: 5,
                // nonWorkingDays: <int>[
                //   DateTime.saturday,
                //   DateTime.sunday,
                // ],
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
        }));
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
          color: ColorManager.blue.withOpacity(0.4),
          border: Border(left: BorderSide(color: ColorManager.blue, width: 4))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p4),
              selected: true,
              title: Row(children: <Widget>[
                Icon(Icons.av_timer_outlined,
                    color: ColorManager.grey, size: AppSize.s14),
                Text(
                  event.id,
                  style: getAppTheme().textTheme.subtitle1,
                )
              ]),
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
      ),
    );
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

  Widget buildActionMethods(BuildContext context, TimeBlock? entry) {
    return SizedBox(
      width: 20,
      child: PopupMenuButton(
        padding: EdgeInsets.all(0),
        iconSize: AppSize.s12,
        color: ColorManager.lightBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            padding: EdgeInsets.all(0),
            value: 0,
            child: Row(children: [
              ElevatedButton(
                onPressed: () {},
                child: Icon(
                  Icons.edit,
                  color: ColorManager.primaryWhite,
                  size: AppSize.s10,
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(AppPadding.p6),
                  primary: Colors.blue, // <-- Button color
                ),
              ),
              Text(
                "Edit",
                style: Theme.of(context).textTheme.headline4,
              )
            ]),
          ),
          PopupMenuItem<int>(
              padding: EdgeInsets.all(0),
              value: 1,
              child: Row(children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.delete,
                      color: ColorManager.primaryWhite, size: AppSize.s10),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(AppPadding.p6),
                    primary: Colors.red, // <-- Button color
                  ),
                ),
                Text(
                  "Delete",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ])),
        ],
        onSelected: (item) => selectedItem(context, item, entry),
      ),
    );
  }

  void selectedItem(BuildContext context, item, TimeBlock? entry) {
    switch (item) {
      case 0:
        showAlignedDialog<EntryEditDialog>(
          avoidOverflow: true,
          context: context,
          followerAnchor: Alignment.topRight,
          targetAnchor: Alignment.bottomRight,
          barrierColor: Colors.transparent,
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
                    color: ColorManager.error.withOpacity(0.2),
                    icons: Icons.delete,
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
