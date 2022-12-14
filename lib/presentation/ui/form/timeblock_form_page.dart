import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/resources/styles_manager.dart';

import 'package:timey_web/presentation/utils/constant_duration_values.dart';
import 'package:timey_web/presentation/utils/snackbar_utils.dart';
import 'package:timey_web/presentation/widgets/button_widget.dart';
import 'package:timey_web/viewmodels/timeblocks_viewmodels.dart';

import '../../resources/font_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../../model/tag.dart';
import '../../../data/providers/tags.dart' as companies;
import '../../../model/timeblock.dart';
import '../../resources/formats_manager.dart';

import 'package:flutter_tags/flutter_tags.dart';

class TimeblockPage extends StatefulWidget {
  final TimeBlock? timeBlock;

  const TimeblockPage({Key? key, this.timeBlock}) : super(key: key);

  @override
  State<TimeblockPage> createState() => _TimeblockPageState();
}

class _TimeblockPageState extends State<TimeblockPage> {
  final _form = GlobalKey<FormState>();

  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();

  late List tags;

  List<int> itemHours = constantValues.hoursItem;
  List<int> itemMinutes = constantValues.minutesItem;
  List<Tag> availableTags = companies.Tags().tags;

  Tag? selectedTag;
  late DateTime startDate;
  //late DateTime endDate;
  int? hours;
  int? minutes;
  int? userId;

  @override
  void initState() {
    if (widget.timeBlock == null) {
      startDate = DateTime.now();
      //endDate = DateTime.now().add(Duration(hours: 2));
      selectedTag = companies.Tags().tags.first;
      hours = itemHours.first;
      minutes = itemMinutes.first;
    } else {
      final timeBlock = widget.timeBlock!;

      startDate = timeBlock.startDate;
      //endDate = timeBlock.endDate!;
      hours = timeBlock.hours;
      minutes = timeBlock.minutes;
      selectedTag = timeBlock.tag;
    }

    if (availableTags.isNotEmpty) {
      selectedTag = availableTags.first;
    }

    for (var t in companies.Tags().tags) {
      tags = t as List<dynamic>;
    }

    super.initState();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();

    if (isValid) {
      final timeBlock = TimeBlock(
          startDate: startDate,
          userId: userId = 1,
          hours: hours,
          minutes: minutes,
          reportedMinutes: (hours! * 60) + minutes!);

      if (widget.timeBlock != null) {
        //TODO: edit

      } else {
        TimeBlocksViewModel().getCreateTimeBlockFxn(timeBlock);
        SnackBarUtils.showSnackBar(
            text: 'Your time report has been added',
            color: Theme.of(context).colorScheme.secondary,
            context: context,
            icons: Icons.check,
            iconColor: Theme.of(context).colorScheme.onSecondary,
            style: makeYourOwnRegularStyle(
                fontSize: FontSize.s14,
                color: Theme.of(context).colorScheme.onSecondary));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SizedBox(
        width: sizingInformation.isDesktop
            ? MediaQuery.of(context).size.width * 0.23
            : MediaQuery.of(context).size.width,
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p30),
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    buildDateTimePickers(),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ButtonWidget(
                              color: Theme.of(context).colorScheme.primary,
                              text: 'Report',
                              style: Theme.of(context).textTheme.headline6,
                              onClicked: () {
                                _saveForm();
                              }),
                        ]),
                    SizedBox(
                      height: AppSize.s50,
                    ),
                    buildCloseButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCloseButton(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: "Close", style: Theme.of(context).textTheme.caption),
      WidgetSpan(
          child: Align(
              alignment: FractionalOffset.bottomLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })))
    ]));
  }

// as of this moment we dont need end date
/*
  Widget buildEndDate() => buildHeader(
        header: 'End date and time',
        icon: Icons.calendar_month,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(endDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(endDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

    Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      endDate,
      pickDate: pickDate,
      firstDate: pickDate ? startDate : null,
    );
    if (date == null) return;

    setState(() {
      endDate = date;
    });
  }
  */

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      startDate,
      pickDate: pickDate,
    );
    if (date == null) return;

    // if (date.isAfter(endDate)) {
    //   endDate = DateTime(
    //       date.year, date.month, date.day, endDate.hour, endDate.minute);
    // }

    setState(() {
      startDate = date;
    });
  }

  Widget buildHeader(
          {required String header, required Widget child, IconData? icon}) =>
      Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            Text(
              header,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(height: AppSize.s5),
            child,
          ],
        ),
      );

  //Date and time
  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
    Widget? leadingIcon,
  }) =>
      ListTile(
        leading: leadingIcon,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  //Refactor
  //Hours
  Widget buildHoursDropDown() => SizedBox(
          child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.av_timer_outlined),
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        value: hours,
        items: itemHours
            .map<DropdownMenuItem<int>>((item) => DropdownMenuItem<int>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p18),
                    child:
                        Text(item.toString(), style: TextStyle(fontSize: 16)),
                  ),
                ))
            .toList(),
        onChanged: (item) => setState(() => hours = item),
      ));

  //Minutes
  Widget buildMinutesDropDown() => SizedBox(
          child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.av_timer_outlined),
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        value: minutes,
        items: itemMinutes
            .map<DropdownMenuItem<int>>((item) => DropdownMenuItem<int>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p18),
                    child:
                        Text(item.toString(), style: TextStyle(fontSize: 16)),
                  ),
                ))
            .toList(),
        onChanged: (item) => setState(() => minutes = item),
      ));

  Widget buildTag() => SizedBox(
        child: DropdownButtonFormField<Tag>(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                labelText: 'Project',
                labelStyle: Theme.of(context).textTheme.subtitle2),
            value: selectedTag,
            icon: Icon(Icons.arrow_downward),
            elevation: AppSize.s16.toInt(),
            onChanged: (Tag? newValue) {
              setState(() {
                selectedTag = newValue!;
              });
            },
            items: availableTags
                .map<DropdownMenuItem<Tag>>((tag) =>
                    DropdownMenuItem<Tag>(value: tag, child: Text(tag.name)))
                .toList()),
      );

  Widget buildDay() => buildHeader(
        header: 'Date',
        child: buildDropdownField(
          leadingIcon: Icon(Icons.calendar_month_outlined),
          text: Utils.toDate(startDate),
          onClicked: () => pickFromDateTime(pickDate: true),
        ),
      );

  Widget buildTime() => buildHeader(
        header: 'Time',
        child: buildDropdownField(
          leadingIcon: Icon(Icons.av_timer_outlined),
          text: Utils.toTime(startDate),
          onClicked: () => pickFromDateTime(pickDate: false),
        ),
      );

  Widget dropDownHoursItems() =>
      buildHeader(header: 'Hours', child: buildHoursDropDown());

  Widget dropDownMinutesItems() =>
      buildHeader(header: 'Minutes', child: buildMinutesDropDown());

  Widget buildTagField() => buildHeader(
      header: 'Tag', icon: Icons.assignment_outlined, child: buildTag());

  Widget buildDateTimePickers() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildDay(),
          buildTime(),
          dropDownHoursItems(),
          dropDownMinutesItems(),
          buildTags(),
        ],
      );

  //Tags
  Widget buildTags() => Tags(
        key: _globalKey,
        itemCount: tags.length,
        columns: 3,
        textField: TagsTextField(
            textStyle: TextStyle(fontSize: 14),
            onSubmitted: (t) {
              setState(() {         
                // print('added!');
                tags.add(Item(title: t));
              });
            }),
        itemBuilder: (index) {
          final Item currentItem = tags[index];

          return ItemTags(
            index: index,
            title: currentItem.title!,
            combine: ItemTagsCombine.withTextBefore,
            onPressed: ((i) => print(i)),
            removeButton: ItemTagsRemoveButton(onRemoved: () {
              setState(() {
                tags.removeAt(index);
              });
              return true;
            }),
          );
        },
      );
}
