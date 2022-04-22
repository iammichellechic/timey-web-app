import 'package:flutter/material.dart';
import 'package:timey_web_scratch/screens/timeblock_detail_screen.dart';
import 'package:timey_web_scratch/screens/table_timeblock_screen.dart';
import 'package:timey_web_scratch/screens/calendar_screen.dart';
import '../screens/overview.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100,
            child: DrawerHeader(
                child: Center(
              child: Text(
                'Timey',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            )),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Overview'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OverView()),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.calendar_month),
          //   title: Text('Calendar view'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => TimeBlockDetailScreen()),
          //     );
          //   },
          // ),
           ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Calendar view'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CalendarWidget()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.table_chart),
            title: Text('Table view'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditablePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payment Overview'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.tune),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
