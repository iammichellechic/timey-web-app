import 'package:timey_web/viewmodels/timeblocks_viewmodels.dart';

import 'tag.dart';
import '../presentation/resources/formats_manager.dart';

//TODO: use json serializer soon
class TimeBlock {
  String? id;
  Tag? tag;
  DateTime startDate;
  int? hours;
  int? minutes;
  int? reportedMinutes;
  int? userId;
  DateTime? endDate;

  DateTime get endDateVariable {
   // for (var tb in TimeBlocksViewModel().appointmentData)
   //  {
      endDate = endDate!.add(Duration(minutes: reportedMinutes!));
   // }
    print(endDate);
    print(reportedMinutes);
    return endDate!;
  }

  TimeBlock(
      {this.id,
      this.tag,
      required this.startDate,
      this.endDate,
      this.reportedMinutes,
      this.hours,
      this.minutes,
      this.userId});

  TimeBlock.fromJson(Map<String, dynamic> data)
      : startDate = Utils.convertStringtoDate(data['datetimeStart']),
        endDate = Utils.convertStringtoDate(data['datetimeEnd']),
        id = data['timeBlockGuid'],
        reportedMinutes = data['reportedMinutes'];

  Map<String, dynamic> toJson() => {
        'userIdCreated': userId,
        'reportedMinutes': reportedMinutes,
        'datetimeStart': startDate,
      };
}
