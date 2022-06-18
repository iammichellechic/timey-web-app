import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/utils/constant_duration_values.dart';
import 'package:timey_web/presentation/widgets/button_widget.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../../model/tag.dart';
import '../../../data/providers/tags.dart';
import '../../../data/providers/timeblocks.dart';
import '../../../data/providers/timeblock.dart';
import '../../resources/formats_manager.dart';

class TimeblockPage extends StatefulWidget {
  final TimeBlock? timeBlock;

  const TimeblockPage({
    Key? key,
    this.timeBlock,
  }) : super(key: key);

  @override
  State<TimeblockPage> createState() => _TimeblockPageState();
}

class _TimeblockPageState extends State<TimeblockPage> {
  final _form = GlobalKey<FormState>();

  List<int> itemList = constantValues.hoursItem;
  List<int> itemMinutes = constantValues.minutesItem;

  List<Tag> availableTags = Tags().tags;
  Tag? selectedTag;

  late DateTime startDate;
  late DateTime endDate;
  int? reportedHours;
  int? remainingMinutes;

  @override
  void initState() {
    if (widget.timeBlock == null) {
      startDate = DateTime.now();
      endDate = DateTime.now().add(Duration(hours: 2));
      selectedTag = Tags().tags.first;
      reportedHours = 0;
      remainingMinutes = 0;
    } else {
      final timeBlock = widget.timeBlock!;

      startDate = timeBlock.startDate;
      endDate = timeBlock.endDate;
      reportedHours = timeBlock.reportHours!;
      remainingMinutes = timeBlock.remainingMinutes!;
      selectedTag = timeBlock.tag; //doesnt auto populate during edit

    }

    if (availableTags.isNotEmpty) {
      selectedTag = availableTags.first;
    }

    super.initState();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();

    if (isValid) {
      final timeBlock =
          TimeBlock(tag: selectedTag, startDate: startDate, endDate: endDate);

      if (widget.timeBlock != null) {
        Provider.of<TimeBlocks>(context, listen: false)
            .updateTimeBlock(timeBlock, widget.timeBlock!);
      } else {
        Provider.of<TimeBlocks>(context, listen: false).addTimeBlock(timeBlock);
      }
      //Scaffold.of(context).closeEndDrawer();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) => 
        Container(
            padding: safeArea,
            width: sizingInformation.isDesktop
                ? MediaQuery.of(context).size.width * 0.23
                : MediaQuery.of(context).size.width,
            child: Drawer(
              child:  Padding(
                  padding: const EdgeInsets.all(AppPadding.p30),
                    child: Form(
                      key: _form,
                      child: Column(
                        children: <Widget>[
                          buildTagField(),
                          SizedBox(
                            height: AppSize.s12,
                          ),
                          buildDateTimePickers(),
                          SizedBox(
                            height: AppSize.s20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ButtonWidget(
                                    color: ColorManager.primary,
                                    text: 'Report',
                                    style: Theme.of(context).textTheme.headline6,
                                    onClicked: _saveForm)
                              ]),
                          Spacer(),
                          buildCloseButton(context),
                        ],
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

    if (date.isAfter(endDate)) {
      endDate = DateTime(
          date.year, date.month, date.day, endDate.hour, endDate.minute);
    }

    setState(() {
      startDate = date;
    });
  }

  Widget buildHeader(
          {required String header,
          required Widget child,
          required IconData icon}) =>
      Container(
        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
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
  }) =>
      ListTile(
        title: Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  //Duration
  Widget buildDropDownFormField(
          {required int? value,
          required List<int> list,
          required String? label}) =>
      SizedBox(
          width: 100,
          child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              labelText: label,
              enabledBorder: OutlineInputBorder(),
            ),
            value: value,
            items: list
                .map<DropdownMenuItem<int>>((item) => DropdownMenuItem<int>(
                      value: item,
                      child:
                          Text(item.toString(), style: TextStyle(fontSize: 16)),
                    ))
                .toList(),
            onChanged: (item) => setState(() => value = item),
          ));

  Widget buildTag() => SizedBox(
        child: DropdownButtonFormField<Tag>(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
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

  Widget buildStartDate() => buildHeader(
        header: 'Date and time',
        icon: Icons.calendar_month_outlined,
        child: Row(
          children: [
            Expanded(
              // flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(startDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(startDate),
                onClicked: () => pickFromDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );
  Widget dropDownHoursItems() {
    return buildDropDownFormField(
        value: reportedHours, list: itemList, label: "Hours");
  }

  Widget dropDownMinutesItems() {
    return buildDropDownFormField(
        value: remainingMinutes, list: itemMinutes, label: "Minutes");
  }

  Widget buildDuration() => buildHeader(
        header: 'Duration',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: dropDownHoursItems()),
            Expanded(child: dropDownMinutesItems()),
          ],
        ),
        icon: Icons.calendar_month_outlined,
      );

  Widget buildTagField() => buildHeader(
      header: 'Tag', icon: Icons.assignment_outlined, child: buildTag());

  Widget buildDateTimePickers() => Column(
        children: [buildStartDate(), buildDuration()],
      );
}
