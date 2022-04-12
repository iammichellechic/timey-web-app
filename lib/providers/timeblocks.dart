import 'package:flutter/material.dart';
import './timeblock.dart';

class TimeBlocks with ChangeNotifier {
  List<TimeBlock> _userTimeBlocks = [
    TimeBlock(
        id: '1',
        tag: 'Microservices',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(new Duration(days: 15))),
    TimeBlock(
        id: '2',
        tag: 'Meeting',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(new Duration(days: 20))),
    TimeBlock(
        id: '3',
        tag: 'Time Reporting System',
        startDate: DateTime.now(),
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

  void deleteTimeBlock(String id) {
    _userTimeBlocks.removeWhere((tb) => tb.id == id);
    notifyListeners();
  }
}
