import 'package:flutter/material.dart';
import '/data/providers/tags.dart';
import '../../presentation/resources/timeFormat_manager.dart';
import './timeblock.dart';

class TimeBlocks with ChangeNotifier {
  final List<TimeBlock> _userTimeBlocks = [
    TimeBlock(
      id: '1',
      tag: Tags().tags[0],
      startDate:
          DateTime.now().subtract(new Duration(days: 1, hours: 8, minutes: 15)),
      endDate: DateTime.now().subtract(new Duration(days: 1, hours: 0)),
    ),
    TimeBlock(
        id: '2',
        tag: Tags().tags[1],
        endDate: DateTime.now().subtract(new Duration(days: 3, hours: 0)),
        startDate: DateTime.now().subtract(new Duration(days: 3, hours: 8))),
    TimeBlock(
        id: '3',
        tag: Tags().tags[0],
        endDate: DateTime.now().subtract(new Duration(days: 2, hours: 0)),
        startDate: DateTime.now().subtract(new Duration(days: 2, hours: 8))),
    TimeBlock(
        id: '4',
        tag: Tags().tags[0],
        endDate: DateTime.now().subtract(new Duration(days: 6, hours: 0)),
        startDate: DateTime.now().subtract(new Duration(days: 6, hours: 9))),
    TimeBlock(
        id: '5',
        tag: Tags().tags[0],
        startDate: DateTime.now().add(new Duration(days: 4, hours: 0)),
        endDate: DateTime.now().add(new Duration(days: 4, hours: 8))),
    TimeBlock(
        id: '6',
        tag: Tags().tags[1],
        endDate: DateTime.now().subtract(new Duration(days: 7, hours: 0)),
        startDate: DateTime.now().subtract(new Duration(days: 7, hours: 6))),
    TimeBlock(
        id: '7',
        tag: Tags().tags[0],
        endDate: DateTime.now().subtract(new Duration(days: 5, hours: 0)),
        startDate: DateTime.now().subtract(new Duration(days: 5, hours: 3))),
    TimeBlock(
      id: '8',
      tag: Tags().tags[1],
      startDate: DateTime.now().add(new Duration(days: 1, hours: 0)),
      endDate: DateTime.now().add(new Duration(days: 1, hours: 10)),
    ),
    TimeBlock(
      id: '9',
      tag: Tags().tags[0],
      startDate: DateTime.now().add(new Duration(days: 2, hours: 0)),
      endDate: DateTime.now().add(new Duration(days: 2, hours: 5)),
    ),
  ];

  List<TimeBlock> get userTimeBlock {
    return [..._userTimeBlocks];
  }

  TimeBlock findById(String id) {
    return _userTimeBlocks.firstWhere((tb) => tb.id == id);
  }

  void addTimeBlock(TimeBlock timeBlock) {
    final newEntry = TimeBlock(
        tag: timeBlock.tag,
        startDate: timeBlock.startDate,
        endDate: timeBlock.endDate,
        id: DateTime.now().toString());
    _userTimeBlocks.add(newEntry);
    notifyListeners();
  }

  // void updateTimeBlock(id, TimeBlock? newEntry) {
  //   final entryIndex = _userTimeBlocks.indexWhere((tb) => tb.id == id);
  //   if (entryIndex >= 0) {
  //     _userTimeBlocks[entryIndex] = newEntry!;
  //     notifyListeners();
  //   } else {
  //     print('....');
  //   }
  // }

  void updateTimeBlock(TimeBlock newEntry, TimeBlock oldEntry) {
    final index = _userTimeBlocks.indexOf(oldEntry);
    _userTimeBlocks[index] = newEntry;

    notifyListeners();
  }

  void deleteTimeBlock(id) {
    _userTimeBlocks.removeWhere((tb) => tb.id == id);
    notifyListeners();
  }

  /*calendar related*/

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<TimeBlock> get entriesOfSelectedDate => _userTimeBlocks.where(
        (entries) {
          final selected = Utils.removeTime(_selectedDate);
          final from = Utils.removeTime(entries.startDate);
          final to = Utils.removeTime(entries.endDate);

          return from.isAtSameMomentAs(selectedDate) ||
              to.isAtSameMomentAs(selectedDate) ||
              (selected.isAfter(from) && selected.isBefore(to));
        },
      ).toList();
}
