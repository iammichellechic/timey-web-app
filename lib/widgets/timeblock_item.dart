import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../screens/add_timeblock_screen.dart';
import '../providers/timeblocks.dart';

class TimeBlockItem extends StatelessWidget {
  final String id;
  final String tag;
  final DateTime startDate;
  final DateTime endDate;

  TimeBlockItem(this.id, this.tag, this.startDate, this.endDate);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 60),
          //selectedTileColor: Colors.orange,
          title: Text(
            tag,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Start Date: ${DateFormat("EEEE, yyyy/MM/dd HH:mm").format(startDate.toLocal())}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'End Date: ${DateFormat("EEEE, yyyy/MM/dd HH:mm").format(endDate.toLocal())}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ]),
          trailing: Wrap(
            spacing: 12,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddTimeBlockScreen.routeName, arguments: id);
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
                          Provider.of<TimeBlocks>(context, listen: false)
                              .deleteTimeBlock(id);
                        },
                      )));
                },
              ),
            ],
          ),
        ));
  }
}
