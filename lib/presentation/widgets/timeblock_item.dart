import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web_scratch/presentation/resources/color_manager.dart';
import 'package:timey_web_scratch/presentation/resources/theme_manager.dart';
import 'package:timey_web_scratch/presentation/resources/values_manager.dart';

import '../../data/providers/timeblock.dart';
import '../../data/providers/timeblocks.dart';

import '../resources/routes_manager.dart';
import '../resources/timeFormat_manager.dart';

class TimeBlockItem extends StatelessWidget {
  final TimeBlock? entry;

  const TimeBlockItem({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: CloseButton(color: ColorManager.error),
          actions: buildViewingActions(context, entry),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.all(AppPadding.p30),
          children: <Widget>[
            buildDateTime(entry),
            SizedBox(height: AppPadding.p30),
            Text(
              entry!.tag!.name,
              style:  getAppTheme().textTheme.headline1,
    
            )
          ],
        ),
      );

  Widget buildDateTime(TimeBlock? entry) {
    return Column(children: [
      buildDate('From', entry!.startDate),
      buildDate('To', entry.endDate),
      buildDuration('Duration'),
      // buildDuration('Remaining(mins)', entry.remainingMinutes)
    ]);
  }

  Widget buildDuration(String title) {
   final styleTitle = getAppTheme().textTheme.headline2;
    final styleDate = getAppTheme().textTheme.headline3;

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
          // Text(time, style: styleDate),
        ],
      ),
    );
  }

  Widget buildDate(String title, DateTime date) {
    final styleTitle = getAppTheme().textTheme.headline2;
    final styleDate = getAppTheme().textTheme.headline3;

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
            Navigator.of(context)
                .pushReplacementNamed(Routes.formRoute, arguments: entry!.id);
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => AddTimeBlockScreen(entry!.id),
            //   ),
            // );
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          color: ColorManager.error,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Remove selected time report?',
                ),
                duration: Duration(seconds: 5),
                action: SnackBarAction(
                  label: 'CONFIRM',
                  textColor: ColorManager.blue,
                  onPressed: () {
                    final provider =
                        Provider.of<TimeBlocks>(context, listen: false);

                    provider.deleteTimeBlock(entry!.id);
                    Navigator.of(context).pop();
                  },
                )));
          },
        ),
      ];
}
