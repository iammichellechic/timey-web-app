import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../providers/tag.dart';
import '../providers/tags.dart';
import '../providers/timeblock.dart';
import '../providers/timeblocks.dart';


//THIS PAGE IS NO LONGER NEEDED //

class AddTimeBlockScreen extends StatefulWidget {
  static const routeName = '/edit-timeblock';
  @override
  State<AddTimeBlockScreen> createState() => _AddTimeBlockScreenState();
}

class _AddTimeBlockScreenState extends State<AddTimeBlockScreen> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final _form = GlobalKey<FormState>();
 

  var _editedEntry = TimeBlock(
      id: null,
      tag: Tags().tags.first,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(new Duration( hours: 2))
  );

  TimeBlock? _initialValues;
  var _isInit = true;
  List<Tag> availableTags = Tags().tags;
  Tag? selectedTag;

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
        appBar: AppBar(
          title: Text('Time Report Entry'),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    DropdownButtonFormField<Tag>(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          icon: const Icon(Icons.assignment),
                          labelText: 'Project',
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
                            .map<DropdownMenuItem<Tag>>((tag) =>
                                DropdownMenuItem<Tag>(
                                    value: tag, child: Text(tag.name)))
                            .toList()),
                    SizedBox(height: 20),
                    DateTimeField(
                      initialValue: _initialValues != null
                          ? _initialValues!.startDate
                          : null,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        filled: true,
                        icon: const Icon(Icons.calendar_month_outlined),
                        labelText: 'Start date and time',
                      ),
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2021),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child!,
                              );
                            },
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      validator: (value) {
                        return value != null
                            ? null
                            : 'Please provide start date and time';
                      },
                      onSaved: (value) {
                        _editedEntry.startDate = value!;
                      },
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    DateTimeField(
                      initialValue: _initialValues != null
                          ? _initialValues!.endDate
                          : null,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        filled: true,
                        icon: const Icon(Icons.calendar_month_outlined),
                        labelText: 'End date and time',
                      ),
                      format: format,
                      onShowPicker: (context, currentValue,) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2021),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child!,
                              );
                            },
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      validator: (value) {
                        return value != null
                            ? null
                            : 'Please provide end date and time';
                      },
                      onSaved: (value) {
                        _editedEntry.endDate = value!;
                      },
                    ),
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
              )),
        ));
  }
}
