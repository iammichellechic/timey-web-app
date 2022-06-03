import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/pages/timeblock_adding_page.dart';
import '../resources/color_manager.dart';
import '../shared/menu_drawer.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  const BaseLayout({Key? key, required this.child}) : super(key: key);

//temporary solution
//use adaptive scaffold.dart in the future
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;

    //ERROR: incorrect use of parentdatawidget
    //expanded is already a direct descendant of row, column or flex

    //ERROR:Navigator operation requested with a context that does not include a Navigator.
    //fixed when a: main.dart //runApp(MaterialApp(home: MyApp()));
    //fixed when b: app.dart //home:Baselayout() then Navigator is passed here in body
    //however both solutions results to routename not rendering in thr URL
    //already tried wrapping in builder


    return Row(children: <Widget>[
      if (!displayMobileLayout)
        const MenuDrawer(
          permanentlyDisplay: true,
        ),
      Expanded(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: ColorManager.grey),
          elevation: 0,
          automaticallyImplyLeading: displayMobileLayout,
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: ColorManager.grey),
              hoverColor: ColorManager.blue,
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          ],
        ),
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        endDrawer: TimeblockPage(),
        drawer: displayMobileLayout
            ? const MenuDrawer(
                permanentlyDisplay: false,
              )
            : null,
        body: Expanded(child: child)))
      
    ]);
  }
}

class CenteredView extends StatelessWidget {
  final Widget child;
  const CenteredView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: child,
      ),
    );
  }
}

// class BaseLayout extends StatelessWidget {
//   final Widget child;
//   const BaseLayout({Key? key, required this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(
//         builder: (context, sizingInformation) => Scaffold(
//             drawer: MenuDrawer(),
//             endDrawer: TimeblockPage(),
//             body: CenteredView(
//               child: Column(
//                 children: [
//                   NavigationBar(), //does not have a navigator
//                   Expanded(child: child),
//                 ],
//               ),
//             )));
//   }
// }

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(),
      tablet: NavigationBarTabletDesktop(),
      desktop: NavigationBarTabletDesktop(),
    );
  }
}

class NavigationBarMobile extends StatelessWidget {
  const NavigationBarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () async => Scaffold.of(context).openDrawer(),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async => Scaffold.of(context).openEndDrawer(),
          )
          //NavBarLogo()
        ],
      ),
    );
  }
}

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //const MenuDrawer(permanentlyDisplay: true),
            SizedBox(),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async => Scaffold.of(context).openEndDrawer(),
            )
          ]),
    );
  }
}
