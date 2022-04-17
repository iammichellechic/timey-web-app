import 'package:flutter/material.dart';
import 'package:timey_web_scratch/providers/tags.dart';
import './timeblock.dart';

class TimeBlocks with ChangeNotifier {
  final List<TimeBlock> _userTimeBlocks = [
    TimeBlock(
        id: '1',
        tag: Tags().tags[0],
        startDate: DateTime.now().add(new Duration(days: 1)),
        endDate: DateTime.now().add(new Duration(days: 15))),
    TimeBlock(
        id: '2',
        tag: Tags().tags[1],
        startDate: DateTime.now().add(new Duration(days: 3)),
        endDate: DateTime.now().add(new Duration(days: 20))),
    TimeBlock(
        id: '3',
        tag: Tags().tags[0],
        startDate: DateTime.now().add(new Duration(days: 2)),
        endDate: DateTime.now().add(new Duration(days: 25))),
    TimeBlock(
        id: '4',
        tag: Tags().tags[0],
        startDate: DateTime.now().add(new Duration(days: 6)),
        endDate: DateTime.now().add(new Duration(days: 15))),
    TimeBlock(
        id: '5',
        tag: Tags().tags[0],
        startDate: DateTime.now().add(new Duration(days: 4)),
        endDate: DateTime.now().add(new Duration(days: 20))),
    TimeBlock(
        id: '6',
        tag: Tags().tags[1],
        startDate: DateTime.now().add(new Duration(days: 7)),
        endDate: DateTime.now().add(new Duration(days: 25))),
    TimeBlock(
        id: '7',
        tag: Tags().tags[0],
        startDate: DateTime.now().add(new Duration(days: 5)),
        endDate: DateTime.now().add(new Duration(days: 15))),
    TimeBlock(
        id: '8',
        tag: Tags().tags[1],
        startDate: DateTime.now().add(new Duration(days: 1)),
        endDate: DateTime.now().add(new Duration(days: 20))),
    TimeBlock(
        id: '9',
        tag: Tags().tags[0],
        startDate: DateTime.now().add(new Duration(days: 2)),
        endDate: DateTime.now().add(new Duration(days: 25))),
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
      id: DateTime.now().toString(),
    );
    _userTimeBlocks.add(newEntry);
    notifyListeners();
  }

  void updateTimeBlock(String id, TimeBlock newEntry) {
    final entryIndex = _userTimeBlocks.indexWhere((tb) => tb.id == id);
    if (entryIndex >= 0) {
      _userTimeBlocks[entryIndex] = newEntry;
      notifyListeners();
    } else {
      print('....');
    }
  }

  void deleteTimeBlock(String? id) {
    _userTimeBlocks.removeWhere((tb) => tb.id == id);
    notifyListeners();
  }
}
