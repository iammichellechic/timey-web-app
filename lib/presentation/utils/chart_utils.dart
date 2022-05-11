import '/data/providers/timeblock.dart';
import 'day_helpers.dart';

class EntryTotal {
  final DateTime day;
  int value;

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
      entryTotal.value += entry.reportHours;
    }

    yield entryTotal;
  }
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
