import 'package:flutter/foundation.dart';

import 'tag.dart';

class TimeBlock with ChangeNotifier {
  final String? id;
  Tag? tag;
  DateTime startDate;
  DateTime endDate;

  // Temporary calculation - will be replaced with data from db.
  int get reportHours => endDate.difference(startDate).inHours;

  // Temporary calculation - will be replaced with data from db.
  int get remainingMinutes =>
      endDate.difference(startDate).inMinutes - (reportHours * 60);

  TimeBlock(
      {required this.id,
      required this.tag,
      required this.startDate,
      required this.endDate});
}
