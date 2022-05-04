import 'package:flutter/material.dart';
import 'package:timey_web_scratch/presentation/pages/timeblock_editing_page.dart';
import 'package:timey_web_scratch/presentation/widgets/timeblock_item.dart';

import '../../data/providers/timeblock.dart';

bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= 600;

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;

//becomes a showdialog when desktop 
//full width when mobile

class EntryItemDialog extends StatelessWidget {
  final TimeBlock? entry;

  const EntryItemDialog({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(
          child: Text('Entry Information',
              style: Theme.of(context).textTheme.headline1)),
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            height: MediaQuery.of(context).size.height * 0.8,
            width: isDesktop(context)
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width,
            child: TimeBlockItem(entry: entry)),
      ],
    );
  }
}

class EntryEditDialog extends StatelessWidget {
    final TimeBlock? entry;

   const EntryEditDialog({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(
          child:
              Text('Edit Entry', style: Theme.of(context).textTheme.headline1)),
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            height: MediaQuery.of(context).size.height * 0.8,
            width: isDesktop(context)
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width,
            child: TimeblockPage(timeBlock: entry,)),
      ],
    );
  }
}
