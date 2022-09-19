import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/data/providers/filter_tags.dart';
import 'package:timey_web/presentation/resources/color_manager.dart';

import 'package:timey_web/presentation/resources/styles_manager.dart';

import 'package:timey_web/presentation/utils/constant_duration_values.dart';
import 'package:timey_web/presentation/utils/snackbar_utils.dart';
import 'package:timey_web/presentation/widgets/button_widget.dart';

import '../../../data/timeblocks.dart';
import '../../../model/filterTag.dart';
import '../../resources/font_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../../model/tag.dart';
import '../../../data/providers/tags.dart' as companies;
import '../../../model/timeblock.dart';
import '../../resources/formats_manager.dart';

class TimeblockPage extends StatefulWidget {
  final TimeBlock? timeBlock;

  const TimeblockPage({Key? key, this.timeBlock}) : super(key: key);

  @override
  State<TimeblockPage> createState() => _TimeblockPageState();
}

class _TimeblockPageState extends State<TimeblockPage> {
  final _form = GlobalKey<FormState>();

  List<int> itemHours = constantValues.hoursItem;
  List<int> itemMinutes = constantValues.minutesItem;
  List<Tag> availableTags = companies.Tags().tags;
  List<FilterTag> filterChips = FilterTags().all;

  Tag? selectedTag;
  late DateTime startDate;
  //late DateTime endDate;
  FilterTag? selectedFilterTags;
  int? hours;
  int? minutes;
  int? userId;
  int? id;

  @override
  void initState() {
    if (widget.timeBlock == null) {
      startDate = DateTime.now();
      //endDate = DateTime.now().add(Duration(hours: 2));
      selectedTag = companies.Tags().tags.first;
      hours = itemHours.first;
      minutes = itemMinutes.first;
      //selectedFilterTags = filterChips;
    } else {
      final timeEntry = widget.timeBlock!;

      startDate = timeEntry.startDate;
      //endDate = timeBlock.endDate!;
      hours = timeEntry.hours;
      minutes = timeEntry.minutes;
      selectedTag = timeEntry.tag;
      //selectedFilterTags = timeEntry.filterTags!;
    }

    if (availableTags.isNotEmpty) {
      selectedTag = availableTags.first;
    }

    // for (var t in companies.Tags().tags) {
    //   tags = t as List<dynamic>;
    // }

    super.initState();
  }

  // void _saveForm() {
  //   final isValid = _form.currentState!.validate();

  //   if (isValid) {
  //     final timeBlock = TimeBlock(
  //         startDate: startDate,
  //         userId: userId = 1,
  //         hours: hours,
  //         minutes: minutes,
  //         reportedMinutes: (hours! * 60) + minutes!);

  //     if (widget.timeBlock != null) {
  //       //TODO: edit

  //     } else {
  //       TimeBlocksViewModel().getCreateTimeBlockFxn(timeBlock);
  //       SnackBarUtils.showSnackBar(
  //           text: 'Your time report has been added',
  //           color: Theme.of(context).colorScheme.secondary,
  //           context: context,
  //           icons: Icons.check,
  //           iconColor: Theme.of(context).colorScheme.onSecondary,
  //           style: makeYourOwnRegularStyle(
  //               fontSize: FontSize.s14,
  //               color: Theme.of(context).colorScheme.onSecondary));
  //     }
  //     Navigator.of(context).pop();
  //   }
  // }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      final timeBlockEntry = TimeBlock(
          tag: selectedTag,
          startDate: startDate,
          userId: userId = 1,
          hours: hours,
          minutes: minutes,
          reportedMinutes: (hours! * 60) + minutes!,
          filterTags: selectedFilterTags);
      if (!isValid) {
        return;
      }
      _form.currentState!.save();

      if (widget.timeBlock != null) {
        Provider.of<TimeBlocks>(context, listen: false)
            .updateTimeBlock(timeBlockEntry, widget.timeBlock!);
      } else {
        Provider.of<TimeBlocks>(context, listen: false)
            .addTimeBlock(timeBlockEntry);

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
                  mainAxisSize: MainAxisSize.min,
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
                      height: AppSize.s20,
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
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            Text(
              header,
              style: makeYourOwnRegularStyle(fontSize: AppSize.s12, color: ColorManager.grey
            )),
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
  //Company
  Widget buildTag() => SizedBox(
        child: DropdownButtonFormField<Tag>(
            decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_city),
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder()),
            value: selectedTag,
            onChanged: (Tag? newValue) {
              setState(() {
                selectedTag = newValue!;
              
              });
            },
            items: availableTags
                .map<DropdownMenuItem<Tag>>((tag) => DropdownMenuItem<Tag>(
                    value: tag,
                    child: Text(
                      tag.name!,
                      style: makeYourOwnBoldStyle(
                          fontSize: FontSize.s16, color: tag.color!),
                    )))
                .toList()),
      );
      
  Widget buildTagDropDown() => buildHeader(
        header: 'Company',
        child: buildTag(),
        
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

  //FilterTags/Chips
  Widget buildFilterChips() => Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Wrap(
          runSpacing: 5,
          spacing: 5,
          children: filterChips
              .map((filterChip) => ChoiceChip(
                    label: Text(filterChip.label!),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: filterChip.color,
                    ),
                    backgroundColor: filterChip.color!.withOpacity(0.1),
                    onSelected: (isSelected) => setState(() {
                      filterChips = filterChips.map((otherChip) {
                        final newChip = otherChip.copy(isSelected: false);

                        return filterChip == newChip
                            ? newChip.copy(isSelected: isSelected)
                            : newChip;
                      }).toList();

                      selectedFilterTags = filterChip;
                    }),
                    selected: filterChip.isSelected!,
                    selectedColor: filterChip.color!.withOpacity(0.25),
                  ))
              .toList(),
        ),
      );

  Widget buildDateTimePickers() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTagDropDown(),
          buildDay(),
          buildTime(),
          dropDownHoursItems(),
          dropDownMinutesItems(),
          buildFilterChips()
        ],
      );

  
}
