import 'package:flutter/material.dart';

import '../model/timeblock.dart';
import 'providers/tags.dart';

class TimeBlocks with ChangeNotifier {
  final List<TimeBlock> _userTimeBlocks = [
    TimeBlock(
        id: '1',
        tag: Tags().tags[0],
        startDate: DateTime.now()
            .subtract(Duration(days: 1, hours: 8, minutes: 15)),
        reportedMinutes: 260),
    TimeBlock(
        id: '2',
        tag: Tags().tags[1],
        startDate: DateTime.now().subtract(Duration(days: 3, hours: 8)),
        reportedMinutes: 200),
    TimeBlock(
        id: '3',
        tag: Tags().tags[0],
        startDate: DateTime.now().subtract(Duration(days: 2, hours: 8)),
        reportedMinutes: 180),
    TimeBlock(
        id: '4',
        tag: Tags().tags[0],
        startDate: DateTime.now().subtract(Duration(days: 6, hours: 9)),
        reportedMinutes: 160),
    TimeBlock(
        id: '5',
        tag: Tags().tags[0],
        startDate: DateTime.now().add(Duration(days: 4, hours: 0)),
        reportedMinutes: 360),
    TimeBlock(
        id: '6',
        tag: Tags().tags[1],
        reportedMinutes: 200,
        startDate: DateTime.now().subtract(Duration(days: 7, hours: 6))),
    TimeBlock(
        id: '7',
        tag: Tags().tags[0],

        startDate: DateTime.now().subtract(Duration(days: 5, hours: 3)),
        reportedMinutes: 180),
    TimeBlock(
      id: '8',
      tag: Tags().tags[1],
      startDate: DateTime.now().add(Duration(days: 1, hours: 0)),
     reportedMinutes: 150
    ),
    TimeBlock(
      id: '9',
      tag: Tags().tags[0],
      startDate: DateTime.now().add(Duration(days: 2, hours: 0)),
      reportedMinutes: 420
    ),
  ];

  List<TimeBlock> get userTimeBlock {

     for (var tb in _userTimeBlocks) {
      var hours = tb.reportedMinutes! / 60;
      tb.hours = hours.floor();
      tb.minutes = ((hours - tb.hours!) * 60).floor();
      tb.endDate = tb.startDate.add(Duration(minutes: tb.reportedMinutes!));
    }
    
    return [..._userTimeBlocks];
  }

  TimeBlock findById(String id) {
    return _userTimeBlocks.firstWhere((tb) => tb.id == id);
  }

  void addTimeBlock(TimeBlock timeBlock) {
    final newEntry = TimeBlock(
        reportedMinutes: timeBlock.reportedMinutes,
        startDate: timeBlock.startDate,
        hours: timeBlock.hours,
        minutes: timeBlock.minutes,
        filterTags: timeBlock.filterTags,
        //endDate: timeBlock.endDate,
        id: DateTime.now().toString());
    _userTimeBlocks.add(newEntry);
    notifyListeners();
  }


  void updateTimeBlock(TimeBlock newEntry, TimeBlock oldEntry) {
    final index = _userTimeBlocks.indexOf(oldEntry);
    _userTimeBlocks[index] = newEntry;

    notifyListeners();
  }

  void deleteTimeBlock(id) {
    _userTimeBlocks.removeWhere((tb) => tb.id == id);
    notifyListeners();
  }
}
