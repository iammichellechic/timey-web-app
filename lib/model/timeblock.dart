import 'tag.dart';
import '../presentation/resources/formats_manager.dart';

//TODO: use json serializer soon
class TimeBlock {
  String? id;
  Tag? tag;
  DateTime startDate;
  int? hours;
  double? minutes;
  int? reportedMinutes;
  int? userId;
  DateTime? endDate;

  // DateTime get endDateVariable =>
  //     endDate!.add(Duration(minutes: reportedMinutes!));

  DateTime get endDateVariable {
    endDate!.add(Duration(minutes: reportedMinutes!));
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
