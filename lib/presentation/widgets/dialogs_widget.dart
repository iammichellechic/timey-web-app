import 'package:flutter/material.dart';
import '../ui/form/timeblock_adding_page.dart';

import '../../data/providers/timeblock.dart';


//becomes a showdialog when desktop
//full width when mobile

class EntryEditDialog extends StatelessWidget {
  final TimeBlock? entry;

  const EntryEditDialog({this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: TimeblockPage(timeBlock: entry,));
  }
}




