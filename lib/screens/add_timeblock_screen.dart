import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../providers/timeblock.dart';
import '../providers/timeblocks.dart';

class AddTimeBlockScreen extends StatefulWidget {
  static const routeName = '/edit-timeblock';
  @override
  State<AddTimeBlockScreen> createState() => _AddTimeBlockScreenState();
}

class _AddTimeBlockScreenState extends State<AddTimeBlockScreen> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final _form = GlobalKey<FormState>();


  var _editedEntry = TimeBlock(
      id: null, tag: '', startDate: DateTime.now(), endDate: DateTime.now(), reportHours: 0);
      

  TimeBlock? _initialValues;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final tbId = ModalRoute.of(context)!.settings.arguments;
      if (tbId != null) {
        _editedEntry = Provider.of<TimeBlocks>(context, listen: false)
            .findById(tbId.toString());
        _initialValues = TimeBlock(
            id: _editedEntry.id,
            tag: _editedEntry.tag,
            startDate: _editedEntry.startDate,
            endDate: _editedEntry.endDate,
            reportHours: _editedEntry.reportHours);
      }
    }
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
                    TextFormField(
                      initialValue:
                        _initialValues != null ? _initialValues!.tag : '',
                      decoration: InputDecoration(
                          filled: true,
                          icon: const Icon(Icons.file_copy),
                          labelText: 'Tag'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a tag.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedEntry = TimeBlock(
                          id: _editedEntry.id,
                          tag: value.toString(),
                          startDate:
                              format.parse(_editedEntry.startDate.toString()),
                          endDate: format.parse(_editedEntry.endDate.toString()),
                          reportHours: _editedEntry.reportHours,
                        );
                      },
                    ),
                    SizedBox(
                      height: 20),
        
                  DateTimeField(
                    // controller: _selectedStartDate,
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
                          firstDate: DateTime(1900),
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
                      _editedEntry = TimeBlock(
                        id: _editedEntry.id,
                        tag: _editedEntry.tag,
                        startDate: format.parse(value.toString()),
                        endDate: format.parse(_editedEntry.endDate.toString()),
                         reportHours: _editedEntry.reportHours,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DateTimeField(
                    initialValue:
                        _initialValues != null ? _initialValues!.endDate : null,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: const Icon(Icons.calendar_month_outlined),
                      labelText: 'End date and time',
                    ),
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
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
                        _editedEntry = TimeBlock(
                          id: _editedEntry.id,
                          tag: _editedEntry.tag,
                          startDate: format.parse(value.toString()),
                          endDate: format.parse(_editedEntry.endDate.toString()),
                           reportHours: _editedEntry.reportHours,
                        );
                      },
                    ),

                    //implement reportHours here enddate-startdate y/m/d/h:m bla bla 
                    //format it
                   
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
