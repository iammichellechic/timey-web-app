import 'package:flutter/material.dart';
import 'package:timey_web/presentation/resources/color_manager.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
        color: ColorManager.primaryWhite,
        border: Border.all(color: ColorManager.black),
        borderRadius: BorderRadius.circular(AppSize.s30),
      ),
      child: child,
    );
  }
}
