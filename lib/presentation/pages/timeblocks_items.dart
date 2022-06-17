import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';

import '../../data/providers/timeblock.dart';
import '../../data/providers/timeblocks.dart';
import '../resources/color_manager.dart';
import '../resources/theme_manager.dart';
import '../resources/formats_manager.dart';

//NO PURPOSE
class TimeBlocksItems extends StatefulWidget {
  const TimeBlocksItems({Key? key}) : super(key: key);

  @override
  State<TimeBlocksItems> createState() => _TimeBlocksItemsState();
}

class _TimeBlocksItemsState extends State<TimeBlocksItems> {
  @override
  Widget build(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;
    String temporaryKey = "Timeblocks";

    return Container(
      height: 200,
      margin: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: ExpansionTile(
          key: PageStorageKey(temporaryKey),
          title: Text(temporaryKey),
          children: timeblocks.map(buildItemsWidget).toList(),
        ),
      ),
    );
  }

//wrong datas
//should be a list of timeblocks ---another entity
  Widget buildItemsWidget(TimeBlock? entry) {
    return ListTile(
      selected: true,
      title: Text(
        entry!.tag!.name,
        style: getAppTheme().textTheme.subtitle1,
      ),
      subtitle: Column(children: <Widget>[
        Text(
           'From: ${Utils.toTime(entry.startDate)}',
          style: getAppTheme().textTheme.bodyText2
        ),
        Text( 'To: ${Utils.toTime(entry.endDate)}',
            style: getAppTheme().textTheme.bodyText2),
        Text(
           'Duration: ${  entry.reportHours.toString() +
              ' ' +
              'hrs' +
              ' ' +
              entry.remainingMinutes.toString() +
              ' ' +
              'mins'}',

         style: getAppTheme().textTheme.bodyText2
        ),
      ]),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        color: ColorManager.error,
        iconSize: AppSize.s12,
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
                  Provider.of<TimeBlocks>(context, listen: false)
                      .deleteTimeBlock(entry.id);
                },
              )));
        },
      ),
    );
  }
}
