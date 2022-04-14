import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timey_web_scratch/screens/add_timeblock_screen.dart';
import 'package:timey_web_scratch/widgets/timeblock_item.dart';

import '../providers/timeblocks.dart';
import '../shared/menu_drawer.dart';

class TimeBlockDetailScreen extends StatelessWidget {
  static const routeName = '/user-timeblocks';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<TimeBlocks>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('My Time Blocks'),
          actions: <Widget>[
            IconButton(
                tooltip: 'Find a time report',
                onPressed: () {},
                icon: const Icon(Icons.search)),
            SizedBox(
              width: 10,
            ),
            IconButton(
              tooltip: 'Add a time report',
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddTimeBlockScreen.routeName);
              },
            ),
          ],
        ),
        drawer: MenuDrawer(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: data.userTimeBlock.isEmpty
                ? Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Add some time blocks',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: data.userTimeBlock.length,
                    itemBuilder: (_, i) => Column(
                      children: [
                        TimeBlockItem(
                          data.userTimeBlock[i].id!,
                          data.userTimeBlock[i].tag,
                          data.userTimeBlock[i].startDate,
                          data.userTimeBlock[i].endDate,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add a time report',
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddTimeBlockScreen.routeName);
          },
        ));
  }
}
