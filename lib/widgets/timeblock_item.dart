import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/timeblock_editing_page.dart';
import '../providers/timeblock.dart';
import '../providers/timeblocks.dart';
import '../utils.dart';

class TimeBlockItem extends StatelessWidget {
  
  final TimeBlock? entry;

  const TimeBlockItem({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
 Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildViewingActions(context, entry),
        ),
        body: ListView(
          padding: EdgeInsets.all(32),
          children: <Widget>[
            buildDateTime(entry),
            SizedBox(height: 32),
            Text(
              entry!.tag!.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
    final styleTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    final styleDate = TextStyle(fontSize: 18);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(title, style: styleTitle)),
          Text(
              entry!.reportHours.toString() +
                  ' ' +
                  'hrs' + ' '+
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
    final styleTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    final styleDate = TextStyle(fontSize: 18);

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
          color: Colors.orange,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
                TimeblockPage.routeName,
                arguments: entry!.id);
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => AddTimeBlockScreen(entry!.id),
            //   ),
            // );
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Remove selected time report?',
                ),
                duration: Duration(seconds: 5),
                action: SnackBarAction(
                  label: 'CONFIRM',
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
