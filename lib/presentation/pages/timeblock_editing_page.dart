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
  @override
  State<TimeblockPage> createState() => _TimeblockPageState();
}

class _TimeblockPageState extends State<TimeblockPage> {
  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TimeBlock? _initialValues;
  List<Tag> availableTags = Tags().tags;
  Tag? selectedTag;

  var _editedEntry = TimeBlock(
    id: null,
    tag: Tags().tags.first,
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  );

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final tbId = ModalRoute.of(context)!.settings.arguments;
      if (tbId != null) {
        _editedEntry = Provider.of<TimeBlocks>(context, listen: false)
            .findById(tbId.toString());
        _initialValues = _editedEntry;
      }
    }

    if (availableTags.isNotEmpty) selectedTag = availableTags.first;

    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_editedEntry.id != null) {
      Provider.of<TimeBlocks>(context, listen: false)
          .updateTimeBlock(_editedEntry.id!, _editedEntry);
    } else {
      Provider.of<TimeBlocks>(context, listen: false)
          .addTimeBlock(_editedEntry);
    }
    Navigator.of(context).pop();
  }

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

//padding issues : mobile: padding top
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

                  //this can be removed once the form has more stuff in it so icon below goes to the bottomest part
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
              _editedEntry.tag = selectedTag;
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
                text: Utils.toDate(_editedEntry.startDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(_editedEntry.startDate),
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
                text: Utils.toDate(_editedEntry.endDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(_editedEntry.endDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(_editedEntry.startDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(_editedEntry.endDate)) {
      _editedEntry.endDate = DateTime(date.year, date.month, date.day,
          _editedEntry.endDate.hour, _editedEntry.endDate.minute);
    }

    setState(() {
      _editedEntry.startDate = date;
    });
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      _editedEntry.endDate,
      pickDate: pickDate,
      firstDate: pickDate ? _editedEntry.startDate : null,
    );
    if (date == null) return;

    setState(() {
      _editedEntry.endDate = date;
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
