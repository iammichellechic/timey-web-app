import 'package:flutter/material.dart';
import './timeblock.dart';

class TimeBlocks with ChangeNotifier {
  final List<TimeBlock> _userTimeBlocks = [
    TimeBlock(
        id: '1',
        tag: 'Microservices',
        startDate: DateTime.now().add(new Duration(days: 1)),
        endDate: DateTime.now().add(new Duration(days:2)), 
        reportHours: 2
        ),
    TimeBlock(
        id: '2',
        tag: 'Meeting',
        startDate: DateTime.now().add(new Duration(days: 2)),
        endDate: DateTime.now().add(new Duration(days: 4)),
        reportHours: 3),
    TimeBlock(
        id: '3',
        tag: 'Time Reporting System',
        startDate: DateTime.now().add(new Duration(days: 3)),
        endDate: DateTime.now().add(new Duration(days: 3)),
         reportHours: 4),
    TimeBlock(
        id: '4',
        tag: 'Microservices',
        startDate: DateTime.now().add(new Duration(days: 4)),
        endDate: DateTime.now().add(new Duration(days: 7)),
         reportHours: 5),
    TimeBlock(
        id: '5',
        tag: 'Meeting',
        startDate: DateTime.now().add(new Duration(days: 5)),
        endDate: DateTime.now().add(new Duration(days: 5)),
         reportHours: 6),
    TimeBlock(
        id: '6',
        tag: 'Time Reporting System',
        startDate: DateTime.now().add(new Duration(days: 6)),
        endDate: DateTime.now().add(new Duration(days: 8)),
         reportHours: 7),
    TimeBlock(
        id: '7',
        tag: 'Microservices',
        startDate: DateTime.now().add(new Duration(days: 7)),
        endDate: DateTime.now().add(new Duration(days: 6)),
         reportHours: 8),
    TimeBlock(
        id: '8',
        tag: 'Meeting',
        startDate: DateTime.now().add(new Duration(days: 8)),
        endDate: DateTime.now().add(new Duration(days: 2)),
         reportHours: 3),
    TimeBlock(
        id: '9',
        tag: 'Time Reporting System',
        startDate: DateTime.now().add(new Duration(days: 9)),
        endDate: DateTime.now().add(new Duration(days: 2)),
         reportHours: 5),
  ];
  List<TimeBlock> get userTimeBlock {
    return [..._userTimeBlocks];
  }

    List<TimeBlock> get recentEntries {
    return _userTimeBlocks.where((tx) {
      return tx.startDate.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
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
      reportHours: timeBlock.reportHours,
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
