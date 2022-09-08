import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'timeblock.dart';


//The appointment builder (Calendar) uses this model,
//the height of the card in the weekly view is determined by the StartTime(start) and EndTime(height ends)
class EventDataSource extends CalendarDataSource {
  EventDataSource(List<TimeBlock> appointments) {
    this.appointments = appointments;
  }

  TimeBlock getEvent(int index) => appointments![index] as TimeBlock;

  @override
  DateTime getStartTime(int index) => getEvent(index).startDate;

  @override
  
  DateTime getEndTime(int index) => getEvent(index).endDate!;

  @override
  String getSubject(int index) => getEvent(index).id.toString();
}

