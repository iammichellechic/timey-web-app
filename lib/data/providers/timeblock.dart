import '../../model/tag.dart';
import '../../presentation/resources/formats_manager.dart';

class TimeBlock {
  final String? id;
  Tag? tag;
  DateTime startDate;
  DateTime endDate;
  final int? reportHours;
  final int? remainingMinutes;

  // Temporary calculation - will be replaced with data from db.
  //int? get reportHours => endDate.difference(startDate).inHours;

  // Temporary calculation - will be replaced with data from db.
//int get remainingMinutes => endDate.difference(startDate).inMinutes - (reportHours * 60);

  TimeBlock({
    this.id, // lets ignore id for now
    this.tag,
    required this.startDate,
    required this.endDate,
    this.reportHours,
    this.remainingMinutes,
  });

  TimeBlock.fromJson(Map<String, dynamic> data)
      : startDate = Utils.convertDateFromString(data['datetimeStart']),
        endDate = Utils.convertDateFromString(data['datetimeEnd']),
        id = Utils.convertStringFromInt(data['userIdCreated']),
        reportHours = data['reportedHours'],
        remainingMinutes = data['reportedRemainingMinutes'];
}
