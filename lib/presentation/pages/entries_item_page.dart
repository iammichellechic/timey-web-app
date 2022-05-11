import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/resources/routes_manager.dart';


import '/presentation/resources/color_manager.dart';
import '/presentation/resources/theme_manager.dart';
import '/presentation/resources/values_manager.dart';

import '../../data/providers/timeblock.dart';
import '../../data/providers/timeblocks.dart';

import '../resources/timeFormat_manager.dart';
import '../widgets/dialogs_widget.dart';

//THIS IS NO LONGER NEEDED//

class TimeBlockItem extends StatelessWidget {
  final TimeBlock? entry;

  const TimeBlockItem({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   leading: CloseButton(color: ColorManager.grey),
        //   actions: buildViewingActions(context, entry),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: Column(
          // scrollDirection: Axis.horizontal,
          children: <Widget>[
            buildDateTime(entry),
            SizedBox(height: AppPadding.p8),
            Text(
              entry!.tag!.name,
              style: getAppTheme().textTheme.subtitle1,
            )
          ],
        ),
        //floatingActionButton: LinearFlowWidget(),
        //floatingActionButtonLocation: ,
      );

  Widget buildDateTime(TimeBlock? entry) {
    return Column(children: [
      Container(child: buildDate('From', entry!.startDate)),
      buildDate('To', entry.endDate),
      buildDuration('Duration'),
      // buildDuration('Remaining(mins)', entry.remainingMinutes)
    ]);
  }

  Widget buildDuration(String title) {
    final styleTitle = getAppTheme().textTheme.bodyText1;
    final styleDate = getAppTheme().textTheme.bodyText2;

    return Container(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        children: [
          Expanded(child: Text(title, style: styleTitle)),
          Text(
              entry!.reportHours.toString() +
                  ' ' +
                  'hrs' +
                  ' ' +
                  entry!.remainingMinutes.toString() +
                  ' ' +
                  'mins',
              style: styleDate),
        ],
      ),
    );
  }

  Widget buildDate(String title, DateTime date) {
    final styleTitle = getAppTheme().textTheme.bodyText1;
    final styleDate = getAppTheme().textTheme.bodyText2;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(title, style: styleTitle)),
          Text(Utils.toDateTime(date), style: styleDate),
        ],
      ),
    );
  }

  List<Widget> buildViewingActions(BuildContext context, TimeBlock? entry) => [
        IconButton(
          icon: Icon(Icons.edit),
          color: ColorManager.blue,
          onPressed: () {
            showDialog<EntryEditDialog>(
              context: context,
              builder: (context) {
                return EntryEditDialog(
                  entry: entry,
                );
              },
            );
            // Navigator.of(context)
            //    .pushReplacementNamed(Routes.formRoute, arguments: entry!.id);
          },
        ),
        IconButton(
            icon: Icon(Icons.delete),
            color: ColorManager.error,
            onPressed: () {
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
                              content: Text('Entry Removed',
                                  style:
                                      Theme.of(context).textTheme.headline4)),
                        );
                      },
                    )
                  ],
                ),
              );
            })
      ];
}
