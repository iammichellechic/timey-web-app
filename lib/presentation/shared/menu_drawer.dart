import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timey_web_scratch/presentation/resources/color_manager.dart';
import 'package:timey_web_scratch/presentation/screens/calendar_screen.dart';
import 'package:timey_web_scratch/presentation/screens/overview.dart';
import 'package:timey_web_scratch/presentation/screens/table_timeblock_screen.dart';
import '../resources/values_manager.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //drawer icon doesnt show up on mobile
    //swiping from left works

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildNavItems(context),
          Spacer(),
          Divider(
            color: ColorManager.grey,
          ),
          buildUserProfile(context),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    return Container(
        padding: safeArea,
        height: 100,
        child: DrawerHeader(
            child: Center(
          child: Text('Timey',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1),
        )));
  }

  Widget buildNavItems(BuildContext context) {
    return Container(
        //padding: const EdgeInsets.all(24),
        child: Wrap(
      children: [
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Overview', style: Theme.of(context).textTheme.subtitle1),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(seconds: 1),
                  child: OverView(),
                ));
          },
        ),
        ListTile(
          leading: Icon(Icons.calendar_month),
          title: Text('Calendar view',
              style: Theme.of(context).textTheme.subtitle1),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(seconds: 1),
                  child: CalendarWidget(),
                  // MaterialPageRoute(builder: (context) =>
                  //CalendarWidget()),
                ));
          },
        ),
        ListTile(
          leading: Icon(Icons.table_chart),
          title:
              Text('Table view', style: Theme.of(context).textTheme.subtitle1),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(seconds: 1),
                  child:EditablePage(),
                ));
          },
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Payment Overview',
              style: Theme.of(context).textTheme.subtitle1),
          onTap: () => {Navigator.of(context).pop()},
        ),
        Divider(
          color: ColorManager.grey,
        ),
        ListTile(
          leading: Icon(Icons.tune),
          title: Text('Settings', style: Theme.of(context).textTheme.subtitle1),
          onTap: () => {Navigator.of(context).pop()},
        ),
      ],
    ));
  }

  Widget buildUserProfile(BuildContext context) => Material(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(AppPadding.p18),
            child: Row(
              children: [
                Flexible(
                  child: CircleAvatar(
                    radius: 30,
                    // backgroundImage: NetworkImage(),
                  ),
                ),
                SizedBox(width: AppSize.s12),
                Flexible(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Dev. Waleed H.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      'Full-Stack',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      );
}
