import 'package:flutter/material.dart';
import 'package:timey_web/presentation/resources/color_manager.dart';

class AnimatedIconWidget extends StatefulWidget {
  const AnimatedIconWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => IconButton(
        splashColor: ColorManager.primaryContainer,
        highlightColor: ColorManager.primaryContainer,
        icon: AnimatedIcon(icon: AnimatedIcons.add_event, progress: controller),
        onPressed: toggleIcon,
      );

  void toggleIcon() => setState(() {
        controller.forward().then((_) async {
          await Future.delayed(Duration(milliseconds: 300));
          Scaffold.of(context).openEndDrawer();
          controller.reverse();
        });
      });
}
