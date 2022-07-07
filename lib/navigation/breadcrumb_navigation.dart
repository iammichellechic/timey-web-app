import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';

import '../navigation/navigator_observer.dart';

//TODO: fix so this does not become  a history trail 

class BreadCrumbNavigator extends StatelessWidget {
  final List<Route> currentRouteStack;
 

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BreadCrumbNavigator() : currentRouteStack = routeStack.toList();

  @override
  Widget build(BuildContext context) {
    return RowSuper(
      children: List<Widget>.from(currentRouteStack
          .asMap()
          .map(
            (index, value) => MapEntry(
                index,
                GestureDetector(
                    onTap: () {
                      //_navigationService.goTothisScreen(index);
                      navigatorKey.currentState!.popUntil(
                          (route) => route == currentRouteStack[index]);
                    },
                    child: _BreadButton(
                        currentRouteStack[index].settings.name, index == 0))),
          )
          .values),
      mainAxisSize: MainAxisSize.max,
      innerDistance: -16,
    );
  }
}

class _BreadButton extends StatelessWidget {
  final String? text;
  final bool isFirstButton;

  const _BreadButton(this.text, this.isFirstButton);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _TriangleClipper(!isFirstButton),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              start: isFirstButton ? 8 : 20, end: 28, top: 8, bottom: 8),
          child: Text(
            text!,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  final bool twoSideClip;

  _TriangleClipper(this.twoSideClip);

  @override
  Path getClip(Size size) {
    final Path path = Path();
    if (twoSideClip) {
      path.moveTo(20, 0.0);
      path.lineTo(0.0, size.height / 2);
      path.lineTo(20, size.height);
    } else {
      path.lineTo(0, size.height);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 20, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
