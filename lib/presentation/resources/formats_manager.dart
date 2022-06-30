
import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date $time';
  }

  static String toDateSingleLetter(DateTime dateTime) {
    final date = DateFormat.E().format(dateTime).substring(0, 1);

    return date;
  }

  static String toDateAbbrLabel(DateTime dateTime) {
    final date = DateFormat(DateFormat.ABBR_WEEKDAY).format(dateTime);

    return date;
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);

    return date;
  }

  static String toChartDate(DateTime dateTime) {
    final date = DateFormat.Md().format(dateTime);

    return date;
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);

    return time;
  }

  static DateTime removeTime(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  static DateTime convertStringtoDate(String date) {
    return DateTime.parse(date);
  }

  static String convertDatetoString(DateTime data) {
    return data.toString();
  }

  static String convertInttoString(int data) {
    return data.toString();
  }

  static String convertDoubletoString(double data) {
    return data.toString();
  }

  static num roundADecimalValue(double data, int count) {
    return num.parse(data.toStringAsFixed(count));
  }
}
