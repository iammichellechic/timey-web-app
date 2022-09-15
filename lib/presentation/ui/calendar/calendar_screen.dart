import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../data/timeblocks.dart';
import 'package:timey_web/presentation/resources/styles_manager.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/widgets/actionbuttons_widget.dart';
import 'package:timey_web/presentation/ui/calendar/calendar_page.dart';

import '../../resources/font_manager.dart';
import '../../resources/formats_manager.dart';

import '../../../model/calendar_data_model.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCalendarWidget(context);
  }

  Widget buildCalendarWidget(BuildContext context) {
    final entries = Provider.of<TimeBlocks>(context).userTimeBlock;
    return Container(
        padding: EdgeInsets.only(top: AppPadding.p40),
        child: (entries.isNotEmpty)
            ? CalendarPage(
                appointment: appointmentBuilder,
                dataSource: EventDataSource(entries))
            : Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              ));
  }
}

Widget appointmentBuilder(
  BuildContext context,
  CalendarAppointmentDetails details,
) {
  final event = details.appointments.first;

  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Container(
      padding: EdgeInsets.all(AppPadding.p8),
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          border: Border(
              left: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 4,
          ))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p4),
                title: Row(children: <Widget>[
                  Icon(Icons.av_timer_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: AppSize.s14),
                  Text(event.tag.name,
                      style: makeYourOwnRegularStyle(
                          fontSize: FontSize.s12, color: event.tag!.color!))
                ]),
                subtitle: Column(children: <Widget>[
                  buildDuration(
                      event!.hours.toString() +
                          ' ' +
                          'hrs' +
                          ' ' +
                          event!.minutes.toString() +
                          ' ' +
                          'mins',
                      context,
                      Theme.of(context).colorScheme.primary),
                  buildDate('From', event.startDate, context),
                  Row(children: <Widget>[
                    Icon(Icons.local_offer,
                        color: event!.filterTags.color!.withOpacity(0.5),
                        size: AppSize.s14),
                    Text(event!.filterTags.label.toString(),
                        style: makeYourOwnRegularStyle(
                            fontSize: FontSize.s12,
                            color: event!.filterTags.color!))
                  ]),
                ]),
                trailing: ActionButtonsWidget(entry: event)),
          ],
        ),
      ),
    ),
  );
}

Widget buildDate(String title, DateTime date, BuildContext context) {
  final styleTitle = Theme.of(context).textTheme.bodyText1;
  final styleDate = makeYourOwnBoldStyle(
      fontSize: FontSize.s12, color: Theme.of(context).colorScheme.primary);

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

Widget buildDuration(String text, BuildContext context, Color color) {
  final styleDate = makeYourOwnBoldStyle(fontSize: FontSize.s12, color: color);

  return Container(
    padding: EdgeInsets.only(top: AppPadding.p8),
    child: Text(text, style: styleDate),
  );
}
