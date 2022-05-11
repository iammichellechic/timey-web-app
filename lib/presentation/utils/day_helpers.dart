extension DayUtils on DateTime {
  DateTime get atMidnight {
    //specified in local time zone 
    return DateTime(year, month, day);
  }

  /// Checks that the two dates share the same date.
  bool isSameDay(DateTime d2) {
    return year == d2.year && month == d2.month && day == d2.day;
  }
}
