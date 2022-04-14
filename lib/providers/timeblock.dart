import 'package:flutter/foundation.dart';

class TimeBlock with ChangeNotifier {
  final String? id;
  final String tag;
  final DateTime startDate;
  final DateTime endDate;

  TimeBlock({
    required this.id,
    required this.tag,
    required this.startDate,
    required this.endDate,
  });
  
}
