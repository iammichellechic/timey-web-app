import 'package:flutter/material.dart';
import 'package:timey_web_scratch/screens/timeblock_detail_screen.dart';
import '../widgets/overview.dart';


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
              child:Center(
                child: Text(
                  'Timey',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ),
          )
      ,
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
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Calendar'),
             onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TimeBlockDetailScreen()),
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
