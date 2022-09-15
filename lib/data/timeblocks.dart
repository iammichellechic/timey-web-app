import 'package:flutter/material.dart';
import 'package:timey_web/data/providers/filter_tags.dart';

import '../model/timeblock.dart';
import 'providers/tags.dart';

class TimeBlocks with ChangeNotifier {
  final List<TimeBlock> _userTimeBlocks = [
    TimeBlock(
        id: '1',
        tag: Tags().tags[0],
        startDate: DateTime.now()
            .subtract(Duration(days: 1, hours: 8, minutes: 15)),
        reportedMinutes: 260,
        filterTags: FilterTags().all.first,
        ),
    TimeBlock(
        id: '2',
        tag: Tags().tags[1],
        startDate: DateTime.now().subtract(Duration(days: 3, hours: 8)),
        reportedMinutes: 200,
        filterTags: FilterTags().all.last),
    TimeBlock(
        id: '3',
        tag: Tags().tags[0],
        startDate: DateTime.now().subtract(Duration(days: 2, hours: 8)),
        reportedMinutes: 180,
        filterTags: FilterTags().all.elementAt(1)),
    TimeBlock(
        id: '4',
        tag: Tags().tags[0],
        startDate: DateTime.now().subtract(Duration(days: 6, hours: 9)),
        reportedMinutes: 160,
        filterTags: FilterTags().all.first),
    TimeBlock(
        id: '5',
        tag: Tags().tags[0],
        startDate: DateTime.now().add(Duration(days: 4, hours: 0)),
        reportedMinutes: 360,
        filterTags: FilterTags().all.elementAt(2)),
    TimeBlock(
      filterTags: FilterTags().all.elementAt(5),
        id: '6',
        tag: Tags().tags[1],
        reportedMinutes: 200,
        startDate: DateTime.now().subtract(Duration(days: 7, hours: 6))),
    TimeBlock(
      filterTags: FilterTags().all.elementAt(4),
        id: '7',
        tag: Tags().tags[0],

        startDate: DateTime.now().subtract(Duration(days: 5, hours: 3)),
        reportedMinutes: 180),
    TimeBlock(
      filterTags: FilterTags().all.elementAt(3),
      id: '8',
      tag: Tags().tags[1],
      startDate: DateTime.now().add(Duration(days: 1, hours: 0)),
     reportedMinutes: 150
    ),
    TimeBlock(
      filterTags: FilterTags().all.elementAt(2),
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
      tag: timeBlock.tag,
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
