import 'package:flutter/material.dart';
import '../../data/providers/timeblock.dart';
import '../../locator.dart';
import '../../services/timeblocks_api_service.dart';

class TimeBlocksViewModel with ChangeNotifier {
  final _api = locator<TimeBlocksApi>();

  List<TimeBlock> _appointmentData = [];
  List<TimeBlock> get appointmentData => _appointmentData;
  int? reportHours;
  double? remainingMinutes;
  int? reportInMinutes;
  DateTime? startDate;
  List<TimeBlock> _tbData = [];
  List<TimeBlock> get tbData => _tbData;

  Future getTimeblocksList() async {
    var timeblockResults = await _api.getTimeblocks();

    if (timeblockResults is String) {
      // show error
    } else {
      _appointmentData = timeblockResults;
    }

    notifyListeners();
  }

  int? getReportedTime() {
    for (var tb in appointmentData) {
      return tb.reportedMinutes;
    }
    return reportInMinutes;
  }

  DateTime? getDate() {
    for (var tb in appointmentData) {
      return tb.startDate;
    }
    return startDate;
  }

  // MAPPING thuis one
  // error: NULL
  List<TimeBlock> getList() {
    var hours = getReportedTime()! / 60;
    reportHours = hours.floor();
    remainingMinutes = (hours - reportHours!) * 60;

    return TimeBlock(
        reportHours: reportHours,
        remainingMinutes: remainingMinutes as int,
        startDate: getDate()!,
        reportedMinutes: getReportedTime()) as List<TimeBlock>;
  }

  dynamic timeList() {
    if (getList().isNotEmpty) {
      _tbData = getList();
      print(_tbData);
    }
  }
}
