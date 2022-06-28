import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '../../model/viewmodels/timeblocks_viewmodels.dart';
import '../shared/menu_drawer.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  const BaseLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeBlocksViewModel>.nonReactive(
      viewModelBuilder: () => TimeBlocksViewModel(),
      onModelReady: (viewModel) => viewModel.getList(),
      builder: (context, viewModel, _) => ResponsiveBuilder(
          builder: (context, sizingInformation) => Scaffold(
              drawer: sizingInformation.isMobile
                  ? MenuDrawer(permanentlyDisplay: false)
                  : null,
              body: CenteredView(
                child: Column(
                  children: [
                    //NavigationBar(), //does not have a navigator so the form doesnt work
                    Expanded(child: child),
                  ],
                ),
              ))),
    );
  }
}

class CenteredView extends StatelessWidget {
  final Widget child;
  const CenteredView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: child,
      ),
    );
  }
}

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
