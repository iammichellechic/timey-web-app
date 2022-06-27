import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timey_web/model/viewmodels/timeblocks_viewmodels.dart';
import 'package:timey_web/presentation/resources/styles_manager.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';

import 'package:timey_web/presentation/widgets/actionbuttons_widget.dart';
import 'package:timey_web/presentation/widgets/animatedicon_widget.dart';
import 'package:timey_web/presentation/widgets/calendar_widget.dart';
import '../../resources/font_manager.dart';
import '../../resources/formats_manager.dart';
import '../../shared/menu_drawer.dart';
import '../form/timeblock_adding_page.dart';
import '../../../model/timeblock_data_source.dart';


class CalendarScreen extends 
ViewModelWidget<TimeBlocksViewModel> {
  //bool isFetched = false;
 const  CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TimeBlocksViewModel viewModel) {
    
    return ResponsiveBuilder(
        builder: (context, sizingInformation) => Row(children: <Widget>[
              if (sizingInformation.isDesktop)
                const MenuDrawer(
                  permanentlyDisplay: true,
                ),
              Expanded(
                  child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        iconTheme: Theme.of(context).iconTheme,
                        elevation: 0,
                        automaticallyImplyLeading: sizingInformation.isMobile,
                        actions: const [
                          AnimatedIconWidget(),
                        ],
                      ),
                      extendBodyBehindAppBar: true,
                      endDrawer: TimeblockPage(),
                      drawer: sizingInformation.isMobile
                          ? const MenuDrawer(
                              permanentlyDisplay: false,
                            )
                          : null,
                      body:buildCalendarWidget(context, viewModel)))
            ]));
  }

  Widget buildCalendarWidget(BuildContext context, TimeBlocksViewModel viewModel) {
    return Container(
        padding: EdgeInsets.only(top: AppPadding.p40),
        child: CalendarWidget(
                  appointment: appointmentBuilder,
                  dataSource: EventDataSource(viewModel.appointmentData))
                    
    );
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
          border:
              Border(left: BorderSide(color: Theme.of(context).colorScheme.primary, width: 4,))),
      child: Expanded(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p4),
              title: Row(children: <Widget>[
                Icon(Icons.av_timer_outlined,
                    color: Theme.of(context).colorScheme.primary, size: AppSize.s14),
                // Text(
                //   event.id,
                //   style: Theme.of(context).textTheme.subtitle1,
                // )
              ]),
              subtitle: Column(children: <Widget>[
                buildDuration(
                  event!.reportedMinutes.toString() +
                      ' ' +
                      // 'hrs' +
                      // ' ' +
                      // event!.remainingMinutes.toString() +
                      // ' ' +
                      'mins',
                      context
                ),
                buildDate('From', event.startDate, context),
               // buildDate('To', event.endDate, context),
              ]),
              trailing: ActionButtonsWidget(entry: event)
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildDate(String title, DateTime date, BuildContext context) {
  final styleTitle = Theme.of(context).textTheme.bodyText1;
  final styleDate =
      makeYourOwnBoldStyle(fontSize: FontSize.s12, color: Theme.of(context).colorScheme.primary);

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
  final styleDate =
      makeYourOwnBoldStyle(fontSize: FontSize.s12, color: Theme.of(context).colorScheme.primary);

  return Container(
    padding: EdgeInsets.only(top: AppPadding.p8),
    child: Text(text, style: styleDate),
  );
}


