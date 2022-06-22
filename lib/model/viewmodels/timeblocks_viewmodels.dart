import 'package:flutter/material.dart';

import '../../data/providers/timeblock.dart';
import '../../locator.dart';
import '../../services/timeblocks_service.dart';

class TimeBlocksViewModel with ChangeNotifier {
  final _api = locator<TimeBlocksApi>();

  List<TimeBlock> _appointmentData = [];
  List<TimeBlock> get appointmentData => _appointmentData;

  Future getTimeblocksList() async {
    var timeblockResults = await _api.getTimeblocks();

    if (timeblockResults is String) {
      // show error
    } else {
      _appointmentData = timeblockResults;
    }

    notifyListeners();
  }
}
