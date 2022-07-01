import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'timeblock.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<TimeBlock> appointments) {
    this.appointments = appointments;
  }

  TimeBlock getEvent(int index) => appointments![index] as TimeBlock;

  @override
  DateTime getStartTime(int index) => getEvent(index).startDate;

  @override
  // DateTime getEndTime(int index) => getEvent(index).startDate.add(Duration(minutes:getEvent(index).reportedMinutes!));
  DateTime getEndTime(int index) => getEvent(index).endDateVariable;

  @override
  String getSubject(int index) => getEvent(index).id.toString();
}
