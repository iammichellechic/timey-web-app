
import 'package:flutter/material.dart';
import '../model/timeblock.dart';
import '../../locator.dart';
import '../../services/timeblocks_api_service.dart';

class TimeBlocksViewModel extends ChangeNotifier {
  final _api = locator<TimeBlocksApi>();

  List<TimeBlock> _appointmentData = [];
  List<TimeBlock> get appointmentData => _appointmentData;

  
  Future getTimeblocksList() async {
    var timeblockResults =
        await _api.getTimeblocks();

    if (timeblockResults is String) {
      // show error
    } else {
      _appointmentData = timeblockResults;
      
      for (var tb in _appointmentData) {
        var hours = tb.reportedMinutes! / 60;
        tb.hours = hours.floor();
        tb.minutes = ((hours - tb.hours!) * 60);
      }
    }
    notifyListeners();
  }

}
