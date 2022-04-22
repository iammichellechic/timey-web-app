import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timey_web_scratch/providers/timeblock.dart';

import '../providers/tag.dart';
import '../providers/tags.dart';
import '../providers/timeblocks.dart';
import '../utils.dart';

class TimeblockPage extends StatefulWidget {
  static const routeName = '/edit-entry';

  @override
  State<TimeblockPage> createState() => _TimeblockPageState();
}

class _TimeblockPageState extends State<TimeblockPage> {
  final _form = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                buildTag(),
                SizedBox(height: 12),
                buildDateTimePickers(),
                SizedBox(height: 12),
                //buildLanguages(),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('Report'),
                    onPressed: _saveForm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTag() => DropdownButtonFormField<Tag>(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        icon: const Icon(Icons.assignment, color:Colors.grey),
        labelText: 'Project',
        labelStyle: TextStyle(fontWeight: FontWeight.bold)
      ),
      value: selectedTag,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      onChanged: (Tag? newValue) {
        setState(() {
          selectedTag = newValue!;
          _editedEntry.tag = selectedTag;
        });
      },
      items: availableTags
          .map<DropdownMenuItem<Tag>>(
              (tag) => DropdownMenuItem<Tag>(value: tag, child: Text(tag.name)))
          .toList());

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
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
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
            Icon(Icons.calendar_month_outlined, color:Colors.grey),
            Text(header, style: TextStyle(fontWeight: FontWeight.bold)),
            child,
          ],
        ),
      );

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );
}
