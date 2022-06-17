import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timey_web/presentation/resources/styles_manager.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/utils/snackbar_utils.dart';
import 'package:timey_web/presentation/widgets/calendar_widget.dart';
import '../../../data/providers/timeblock.dart';
import '../../../locator.dart';
import '../../../model/viewmodels/timeblocks_viewmodels.dart';
import '../../../services/navigation-service.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/theme_manager.dart';
import '../../resources/formats_manager.dart';
import '../../shared/menu_drawer.dart';
import '../../widgets/dialogs_widget.dart';
import '../form/timeblock_adding_page.dart';
import '/presentation/resources/color_manager.dart';
import '../../../data/providers/timeblocks.dart';
import '../../../model/timeblock_data_source.dart';

class CalendarScreen extends StatelessWidget {
  bool isFetched = false;
  CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                        iconTheme: IconThemeData(
                            color: ColorManager.onPrimaryContainer),
                        elevation: 0,
                        automaticallyImplyLeading: sizingInformation.isMobile,
                        actions: [
                          IconButton(
                            icon: Icon(Icons.add,
                                color: ColorManager.onPrimaryContainer),
                            hoverColor: ColorManager.primaryContainer,
                            onPressed: () {
                              _scaffoldKey.currentState!.openEndDrawer();
                            },
                          ),
                        ],
                      ),
                      key: _scaffoldKey,
                      extendBodyBehindAppBar: true,
                      endDrawer: TimeblockPage(),
                      drawer: sizingInformation.isMobile
                          ? const MenuDrawer(
                              permanentlyDisplay: false,
                            )
                          : null,
                      body: Expanded(child: buildCalendarWidget(context))))
            ]));
  }

  Widget buildCalendarWidget(BuildContext context) {
    return ViewModelBuilder<TimeBlocksViewModel>.reactive(
        viewModelBuilder: () => TimeBlocksViewModel(),
        onModelReady: (model) => model.getTimeblocksList(),
        builder: (context, model, child) => Container(
            padding: EdgeInsets.only(top: AppPadding.p40),
            child: (model.appointmentData.isNotEmpty)
                ? CalendarWidget(
                    appointment: appointmentBuilder,
                    dataSource: EventDataSource(model.appointmentData),
                  )
                : Container(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("No data found"),
                    ))));
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
          //color: ColorManager.background,
          border:
              Border(left: BorderSide(color: ColorManager.primary, width: 4))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p4),
              title: Row(children: <Widget>[
                Icon(Icons.av_timer_outlined,
                    color: ColorManager.primary, size: AppSize.s14),
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
    ),
  );
}

Widget buildDate(String title, DateTime date) {
  final styleTitle = getAppTheme().textTheme.bodyText1;
  final styleDate =
      makeYourOwnBoldStyle(fontSize: FontSize.s12, color: ColorManager.primary);

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
  final styleDate =
      makeYourOwnBoldStyle(fontSize: FontSize.s12, color: ColorManager.primary);

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
          });

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
              child:
                  Text('Cancel', style: Theme.of(context).textTheme.headline4),
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
                Navigator.of(context).pop(); //it should pop before redirecting

                SnackBarUtils.showSnackBar(
                  context: context,
                  text: 'Entry removed',
                  color: ColorManager.errorContainer,
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
