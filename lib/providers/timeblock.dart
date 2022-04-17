import 'package:flutter/foundation.dart';

import 'tag.dart';

class TimeBlock with ChangeNotifier {
  final String? id;
  final Tag? tag;
  final DateTime startDate;
  final DateTime endDate;

  TimeBlock({
    required this.id,
    required this.tag,
    required this.startDate,
    required this.endDate,
  });
}
