import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '/viewmodels/timeblocks_viewmodels.dart';
import 'package:timey_web/presentation/resources/styles_manager.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';

import 'package:timey_web/presentation/widgets/actionbuttons_widget.dart';

import 'package:timey_web/presentation/ui/calendar/calendar_page.dart';
import '../../resources/font_manager.dart';
import '../../resources/formats_manager.dart';

import '../../../model/calendar_data_model.dart';

class CalendarScreen extends ViewModelWidget<TimeBlocksViewModel> {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TimeBlocksViewModel viewModel) {
    return buildCalendarWidget(context, viewModel);
  }

  Widget buildCalendarWidget(
      BuildContext context, TimeBlocksViewModel viewModel) {
    return Container(
        padding: EdgeInsets.only(top: AppPadding.p40),
        child: (viewModel.appointmentData.isNotEmpty)
            ? CalendarPage(
                appointment: appointmentBuilder,
                dataSource: EventDataSource(viewModel.appointmentData))
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
                  // Text(
                  //   event.id,
                  //   style: Theme.of(context).textTheme.subtitle1,
                  // )
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
                      context),
                  buildDate('From', event.startDate, context),
                  // buildDate('To', event.endDate, context),
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

Widget buildDuration(String text, BuildContext context) {
  final styleDate = makeYourOwnBoldStyle(
      fontSize: FontSize.s12, color: Theme.of(context).colorScheme.primary);

  return Container(
    padding: EdgeInsets.only(top: AppPadding.p8),
    child: Text(text, style: styleDate),
  );
}
