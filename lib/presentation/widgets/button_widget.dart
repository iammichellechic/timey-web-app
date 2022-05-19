import 'package:flutter/material.dart';

import '../resources/values_manager.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DecoratedBox(
  
        decoration: BoxDecoration(
        gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color.fromRGBO(187, 222, 251, 1),
                Color.fromRGBO(13, 71, 161, 1),
              ]),
        ),
        child: ElevatedButton(
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: Text(text),
          ),
          onPressed: onClicked,
        ),
      );
}
