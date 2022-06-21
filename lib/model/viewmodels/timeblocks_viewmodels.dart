import 'package:flutter/cupertino.dart';

import '../../data/providers/timeblock.dart';
import '../../locator.dart';
import '../../presentation/resources/formats_manager.dart';
import '../../services/timeblocks_service.dart';

class TimeBlocksViewModel with ChangeNotifier {
  final _api = locator<TimeBlocksApi>();

  final List<TimeBlock> _appointmentData= [];
  List<TimeBlock> get appointmentData => _appointmentData;

  dynamic getTimeblocksList() {
    var timeblockResults = _api.getList;

    for (var data in timeblockResults) {
      TimeBlock tbData = TimeBlock(
          startDate: Utils.convertDateFromString(data['datetimeStart']),
          endDate: Utils.convertDateFromString(data['datetimeEnd']),
          id: Utils.convertStringFromInt(data['userIdCreated']),
          reportHours: data['reportedHours'],
          remainingMinutes: data['reportedRemainingMinutes']);

      _appointmentData.add(tbData);
    }
    //notifyListeners();
    return _appointmentData;
  }

}
