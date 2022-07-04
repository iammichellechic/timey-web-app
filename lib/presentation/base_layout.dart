
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/widgets/switch_theme_button_widget.dart';

import '../viewmodels/timeblocks_viewmodels.dart';

//TODO: Fix appBar 
class BaseLayout extends StatelessWidget {
  final Widget child;
  const BaseLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeBlocksViewModel>.reactive(
      viewModelBuilder: () => TimeBlocksViewModel(),
      onModelReady: (viewModel) => viewModel.getTimeBlocks(),
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 5,
          leadingWidth: 200,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppPadding.p40, AppPadding.p12, 0, AppPadding.p12),
              child: Text('TIMEY', style: Theme.of(context).textTheme.headline1),
            ),
          ),
          actions: [
           // buildSearchField(context),
             SwitchThemeButtonWidget()],
        ),
        body: CenteredView(
          child: Expanded(
            child: Column(
              children: [
                // NavigationBar(),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      ),
    );
  }
}

Widget buildSearchField(BuildContext context) {
  final controller = TextEditingController();
  final style = controller.text.isEmpty
      ? const TextStyle(color: Colors.black54)
      : const TextStyle(color: Colors.black);
  return ResponsiveBuilder(
      builder: (context, sizingInformation) => Container(
            width: sizingInformation.isDesktop
                ? MediaQuery.of(context).size.width * 0.20
                : MediaQuery.of(context).size.width * 0.30,
            height: 50,
            margin: const EdgeInsets.fromLTRB(100, 16, 100, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.text.isNotEmpty
                    ? GestureDetector(
                        child: Icon(Icons.close, color: style.color),
                        onTap: () {
                          controller.clear();
                          FocusScope.of(context).requestFocus(FocusNode());

                          // searchBook('');
                        },
                      )
                    : null,
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: const BorderSide(color: Colors.black26),
                ),
              ),
              //onChanged: searchBook,
            ),
          ));
}
