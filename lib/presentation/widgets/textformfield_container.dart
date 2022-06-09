import 'package:flutter/material.dart';


//add validator, controller, onfieldsubmit/onsavde
class TextFormFieldContainer extends StatelessWidget {
final String text;
  final TextStyle? style;

  const TextFormFieldContainer({
    required this.text,
    this.style,
  
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
      border: InputBorder.none,
      disabledBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      labelText: text,
      labelStyle: style,
    ));
  }
}
