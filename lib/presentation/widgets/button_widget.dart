import 'package:flutter/material.dart';
import '../resources/values_manager.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color? color;
  final TextStyle? style;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    required this.color,
    this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>  ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p30, vertical: AppPadding.p14),
            child: Text(text,style: style,),
          ),
          style: ElevatedButton.styleFrom(primary: color),
          onPressed: onClicked,
        
      );
}
