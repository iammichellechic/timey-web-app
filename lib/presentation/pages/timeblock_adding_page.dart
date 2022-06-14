import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/utils/constant_duration_values.dart';
import 'package:timey_web/presentation/widgets/button_widget.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../model/tag.dart';
import '../../data/providers/tags.dart';
import '../../data/providers/timeblocks.dart';
import '../../data/providers/timeblock.dart';
import '../resources/timeFormat_manager.dart';

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
        Navigator.of(context).pop();
      } else {
        Provider.of<TimeBlocks>(context, listen: false).addTimeBlock(timeBlock);
        Scaffold.of(context).closeEndDrawer();
      }
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      //   locator<NavigationService>().navigatorKey.currentState!.pop();

    }
  }

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    return Container(
      padding: safeArea,
      width: isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.23
          : MediaQuery.of(context).size.width,
      child: Drawer(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p30),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                buildTag(),
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
                          color: ColorManager.blue,
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
      )),
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
                    color: ColorManager.grey,
                  ),
                  onPressed: () {
                    Scaffold.of(context).closeEndDrawer();
                  })))
    ]));
  }

  Widget buildTag() => Container(
        padding: EdgeInsets.only(top: AppPadding.p16),
        child: DropdownButtonFormField<Tag>(
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(Icons.assignment, color: ColorManager.grey),
                labelText: 'Project',
                labelStyle: Theme.of(context).textTheme.subtitle2),
            value: selectedTag,
            icon: const Icon(Icons.arrow_downward),
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

  Widget buildDateTimePickers() => Column(
        children: [buildStartDate(), buildDuration()],
      );

  Widget buildStartDate() => buildHeader(
        header: 'Date and time',
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

  Widget buildEndDate() => buildHeader(
        header: 'End date and time',
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

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.calendar_month_outlined, color: ColorManager.grey),
            Text(
              header,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            child,
          ],
        ),
      );

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

  Widget buildDropDownFormField(
          {required int? value,
          required List<int> list,
          required String? label}) =>
      SizedBox(
          width: 100,
          child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              labelText: label,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 2, color: Colors.blue),
              ),
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
      );
}
