import 'package:timey_web/model/filterTag.dart';

import 'tag.dart';
import '../presentation/resources/formats_manager.dart';

class TimeBlock {
  String? id;
  Tag? tag;
  DateTime startDate;
  int? hours;
  int? minutes;
  int? reportedMinutes;
  int? userId;
  DateTime? endDate;
 FilterTag? filterTags;

  TimeBlock(
      {this.id,
      this.tag,
      required this.startDate,
      this.endDate,
      this.reportedMinutes,
      this.hours,
      this.minutes,
      this.userId,
      this.filterTags});

    

  TimeBlock.fromJson(Map<String, dynamic> data)
      : startDate = Utils.convertStringtoDate(data['datetimeStart']),
        // endDate = Utils.convertStringtoDate(data['datetimeEnd']),
        id = data['timeBlockGuid'],
        reportedMinutes = data['reportedMinutes'];
}
