import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timey_web/model/timeblock.dart';
import 'package:timey_web/presentation/ui/form/timeblock_form_page.dart';

import '../../data/timeblocks.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import '../utils/snackbar_utils.dart';

class ActionButtonsWidget extends StatelessWidget {
  final TimeBlock? entry;
  const ActionButtonsWidget({Key? key, this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 20,
        child: PopupMenuButton(
          padding: EdgeInsets.all(0),
          iconSize: AppSize.s12,
          color: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              padding: EdgeInsets.all(0),
              value: 0,
              child: Row(children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.edit,
                    color: ColorManager.primaryWhite,
                    size: AppSize.s10,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.all(AppPadding.p6), // <-- Button color
                  ),
                ),
                Text(
                  "Edit",
                  style: Theme.of(context).textTheme.headline4,
                )
              ]),
            ),
            PopupMenuItem<int>(
                padding: EdgeInsets.all(0),
                value: 1,
                child: Row(children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.delete,
                        color: ColorManager.primaryWhite, size: AppSize.s10),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      padding:
                          EdgeInsets.all(AppPadding.p6), // <-- Button color
                    ),
                  ),
                  Text(
                    "Delete",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ])),
          ],
          onSelected: (item) => selectedItem(context, item, entry),
        ),
      );
}

void selectedItem(BuildContext context, item, TimeBlock? entry) {
  switch (item) {
    case 0:
      showGlobalDrawer<TimeblockPage>(
        context: context,
        direction: AxisDirection.right,
        duration: Duration(seconds: 1),
        builder: (context) {
          return TimeblockPage(
            timeBlock: entry,
          );
        },
      );

      break;
    case 1:
      showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Delete entry?',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: [
            TextButton(
              child:
                  Text('Cancel', style: Theme.of(context).textTheme.headline4),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.headline5,
              ),
              onPressed: () {
                // viewModel.getDeleteTimeBlockFxn(entry!.id);

                 Provider.of<TimeBlocks>(context, listen: false)
                    .deleteTimeBlock(entry!.id);

                Navigator.of(context).pop();

                SnackBarUtils.showSnackBar(
                  context: context,
                  text: 'Entry removed',
                  color: Theme.of(context).colorScheme.errorContainer,
                  style: Theme.of(context).textTheme.headline5,
                  icons: Icons.delete,
                  iconColor: ColorManager.error,
                );
              },
            )
          ],
        ),
      );
      break;
  }
}
