import '/data/providers/user.dart';
import '../../model/tag.dart';
import '../../presentation/resources/formats_manager.dart';

class TimeBlock {
  final String? id;
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

  static ReportedTime convertToHrsAndMins(TimeBlock tb) {
    var hours = (tb.reportedMinutes! / 60);
    var reportHours = hours.floor();
    var remainingMinutes = (hours - reportHours) * 60;

    return ReportedTime(
        reportHours: reportHours, remainingMinutes: remainingMinutes as int);
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

  TimeBlock.fromJson(Map<String, dynamic> data, ReportedTime reportedTime)
      : startDate = Utils.convertDateFromString(data['datetimeStart']),
        endDate = Utils.convertDateFromString(data['datetimeEnd']),
        id = Utils.convertStringFromInt(data['userIdCreated']),
        reportedMinutes = data['reportedMinutes'],
        reportHours = reportedTime.reportHours,
        remainingMinutes = reportedTime.remainingMinutes;

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
