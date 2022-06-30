import '../resources/formats_manager.dart';
import '../../model/timeblock.dart';
import 'day_helpers.dart';

class EntryTotal {
  final DateTime day;
  double value;

  EntryTotal(this.day, this.value);
}

/// Returns a list of EntryTotal objects. Each is the sum of
/// the values of all the entries on a given day.

List<EntryTotal> entryTotalsByDay(List<TimeBlock>? entries, int daysAgo,
    {DateTime? today}) {
  today ??= DateTime.now();

  return _entryTotalsByDay(entries, daysAgo, today).toList();
}

Iterable<EntryTotal> _entryTotalsByDay(
    List<TimeBlock>? entries, int daysAgo, DateTime today) sync* {
  var start = today.subtract(Duration(days: daysAgo));
  var entriesByDay = _entriesInRange(start, today, entries);

  for (var i = 0; i < entriesByDay.length; i++) {
    var list = entriesByDay[i];
    var entryTotal = EntryTotal(start.add(Duration(days: i)), 0);

    for (var entry in list) {
      //make variable that adds reporthours and minutes
      //use that variable to store value
      var minsInDecimal = entry.reportedMinutes! / 60;
      entryTotal.value += minsInDecimal;
    }

    yield entryTotal;
  }
}

/// MONTH ////
//get number of days in a month
int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    return isLeapYear ? 29 : 28;
  }
  const List<int> daysInMonth = <int>[
    31,
    -1,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];
  return daysInMonth[month - 1];
}

List<EntryTotal> entryTotalsByMonth(List<TimeBlock>? entries,
    {DateTime? startMonth, DateTime? endMonth}) {
  DateTime today = DateTime.now();
  startMonth = DateTime(today.year, today.month, 1);
  endMonth = DateTime(
      today.year, today.month, getDaysInMonth(today.year, today.month));

  return _entryTotalsByMonth(entries, startMonth, endMonth).toList();
}

Iterable<EntryTotal> _entryTotalsByMonth(
    List<TimeBlock>? entries, DateTime startMonth, DateTime endMonth) sync* {
  var start = startMonth;
  var entriesByDay = _entriesInRange(start, endMonth, entries);

  for (var i = 0; i < entriesByDay.length; i++) {
    var list = entriesByDay[i];
    var entryTotal = EntryTotal(start.add(Duration(days: i)), 0);

    for (var entry in list) {
      var minsInDecimal = entry.reportedMinutes! / 60;
      entryTotal.value += Utils.roundADecimalValue(minsInDecimal,2);
    }
    yield entryTotal;
  }
}

double getMonthTotalReportedHours(List<TimeBlock>? entries) {
  var sum = 0.0;
  var list = entryTotalsByMonth(entries);

  sum += list.fold(0, (previous, current) => previous + current.value);

  return sum;
}

//DO: convert dec to time for the label

/// WEEK ////
List<EntryTotal> entryTotalsByWeek(List<TimeBlock>? entries,
    {DateTime? startWeek, DateTime? endWeek}) {
  DateTime today = DateTime.now();

  int daysOfWeek = today.weekday - 1;
  startWeek = DateTime(today.year, today.month, today.day - daysOfWeek);
  endWeek = startWeek.add(Duration(days: 6, hours: 23, minutes: 59));

  return _entryTotalsByWeek(entries, startWeek, endWeek).toList();
}

Iterable<EntryTotal> _entryTotalsByWeek(
    List<TimeBlock>? entries, DateTime startWeek, DateTime endWeek) sync* {
  var start = startWeek;
  var entriesByDay = _entriesInRange(start, endWeek, entries);

  for (var i = 0; i < entriesByDay.length; i++) {
    var list = entriesByDay[i];
    var entryTotal = EntryTotal(start.add(Duration(days: i)), 0);

    for (var entry in list) {
      var minsInDecimal = entry.reportedMinutes! / 60;
      entryTotal.value += Utils.roundADecimalValue(minsInDecimal, 2);
    }

    yield entryTotal;
  }
}

double getWeekTotalReportedHours(List<TimeBlock>? entries) {
  var sum = 0.0;
  var list = entryTotalsByWeek(entries);

  sum += list.fold(0, (previous, current) => previous + current.value);

  return sum;
}

/// Groups entries by day between start and end. The result is a list of
/// lists. The outer list represents the number of days since start, and the
/// inner list is the group of entries on that day.

List<List<TimeBlock>> _entriesInRange(
        DateTime start, DateTime end, List<TimeBlock>? entries) =>
    _entriesInRangeImpl(start, end, entries).toList();

Iterable<List<TimeBlock>> _entriesInRangeImpl(
    DateTime start, DateTime end, List<TimeBlock>? entries) sync* {
  start = start.atMidnight;
  end = end.atMidnight;
  var d = start;

  while (d.compareTo(end) <= 0) {
    var es = <TimeBlock>[];
    for (var entry in entries!) {
      if (d.isSameDay(entry.startDate.atMidnight)) {
        es.add(entry);
      }
    }

    yield es;
    d = d.add(const Duration(days: 1));
  }
}
