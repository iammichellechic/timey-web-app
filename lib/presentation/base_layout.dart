import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:timey_web/navigation/breadcrumb_navigation.dart';
import 'package:timey_web/presentation/widgets/switch_theme_button_widget.dart';

import '../viewmodels/timeblocks_viewmodels.dart';
import 'shared/menu_drawer.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  const BaseLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeBlocksViewModel>.reactive(
      viewModelBuilder: () => TimeBlocksViewModel(),
      onModelReady: (viewModel) => viewModel.getTimeblocksList(),
      builder: (context, viewModel, _) => ResponsiveBuilder(
          builder: (context, sizingInformation) => Scaffold(
                drawer: sizingInformation.isMobile
                    ? MenuDrawer(permanentlyDisplay: false)
                    : null,
                body: CenteredView(
                  child: Expanded(
                    child: Column(
                      children: [
                       // NavigationBar(), //does not have a navigator so the form doesnt work
                        Expanded(child: child),
                      ],
                    ),
                  ),
                ),
              )),
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
      mobile: NavigationBarTabletDesktop(),
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
            Text('TIMEY', style: Theme.of(context).textTheme.headline1),
            SizedBox(height: 50,
            width: 500,
            child: BreadCrumbNavigator()),
            SwitchThemeButtonWidget()
          ]),
    );
  }
}
