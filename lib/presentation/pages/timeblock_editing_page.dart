import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web_scratch/presentation/resources/color_manager.dart';
import 'package:timey_web_scratch/presentation/resources/values_manager.dart';

import '../../data/providers/tag.dart';
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
  
  List<Tag> availableTags = Tags().tags;
  Tag? selectedTag;
  late DateTime startDate;
  late DateTime endDate;

 
  @override
  void initState() {
    super.initState();

    if (widget.timeBlock == null) {
      startDate = DateTime.now();
      endDate = DateTime.now().add(Duration(hours: 2));
      selectedTag = Tags().tags.first;

     
    } else {
      
        final timeBlock = widget.timeBlock!;

        startDate = timeBlock.startDate;
        endDate = timeBlock.endDate;
        selectedTag = timeBlock.tag; //doesnt auto populate durinh edit

      }
      
       if (availableTags.isNotEmpty) selectedTag = availableTags.first;
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
        Provider.of<TimeBlocks>(context, listen: false)
            .addTimeBlock(timeBlock);
      }
      Navigator.of(context).pop();
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
            ? MediaQuery.of(context).size.width * 0.30
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
                  SizedBox(height: AppSize.s12),
                  //buildLanguages(),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  Column(children: [
                    Align(
                      alignment: FractionalOffset.bottomRight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromRGBO(187, 222, 251, 1),
                                Color.fromRGBO(13, 71, 161, 1),
                              ]),
                        ),
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Text('Report'),
                          ),
                          onPressed: _saveForm,
                        ),
                      ),
                    ),
                  ]),

                  //chnage this
                  SizedBox(
                    height: AppSize.s280,
                  ),
                  //Spacer(), - richtext isnt flexible
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Close",
                        style: Theme.of(context).textTheme.caption),
                    WidgetSpan(
                        child: Align(
                            alignment: FractionalOffset.bottomLeft,
                            child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: ColorManager.grey,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })))
                  ]))
                ],
              ),
            ),
          ),
        )));
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
              .toList()));

  Widget buildDateTimePickers() => Column(
        children: [buildStartDate(), buildEndDate()],
      );

  Widget buildStartDate() => buildHeader(
        header: 'Start date and time',
        child: Row(
          children: [
            Expanded(
              flex: 2,
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
}
