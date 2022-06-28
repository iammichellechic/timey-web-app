import '/data/providers/user.dart';
import '../../model/tag.dart';
import '../../presentation/resources/formats_manager.dart';

class TimeBlock {
  String? id;
  Tag? tag;
  DateTime startDate;
  DateTime? endDate;
  int? reportHours;
  int? remainingMinutes;
  int? reportedMinutes;
  ReportedTime? reportedTime;
  User? userId;

  int? totalReportedTime() {
    reportedTime!.reportHours! * 60 + reportedTime!.remainingMinutes!;
    return reportedMinutes;
  }

  ReportedTime convertToHrsAndMins(TimeBlock tb) {
    var hours = (tb.reportedMinutes! / 60);
    reportHours = hours.floor();
    remainingMinutes = (hours - reportHours!) * 60 as int;

    return ReportedTime(
        reportHours: reportHours, remainingMinutes: remainingMinutes);
  }

  TimeBlock(
      {this.id,
      this.tag,
      required this.startDate,
      this.endDate,
      this.reportedMinutes,
      this.reportedTime,
      this.reportHours,
      this.remainingMinutes});

  TimeBlock.fromJson(Map<String, dynamic> data)
      : startDate = Utils.convertDateFromString(data['datetimeStart']),
        endDate = Utils.convertDateFromString(data['datetimeEnd']),
        id = Utils.convertStringFromInt(data['userIdCreated']),
        reportedMinutes = data['reportedMinutes'];

  TimeBlock.toMap(Map<String, dynamic> data)
      : id = data['timeBlockGuid'],
        startDate = data['datetimeStart'],
        reportedMinutes = data['reportedMinutes'],
        userId = data['userIdCreated'];
}

class ReportedTime {
  int? reportHours;
  int? remainingMinutes;

  ReportedTime({this.reportHours, this.remainingMinutes});
}
