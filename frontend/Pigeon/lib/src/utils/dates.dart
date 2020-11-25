import 'package:intl/intl.dart';

class UtilDates {
  static final int oneDayInMilliseconds = 86400000;

  static final daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  static final formatHour = new DateFormat("HH:mm");
  static final formatDay = new DateFormat("dd/MM/yyyy");

  static int getTodayMidnight() {
    final now = DateTime.now();
    final lastMidnight = new DateTime(now.year, now.month, now.day);
    final lastMidnightMilliseconds = lastMidnight.millisecondsSinceEpoch;
    return lastMidnightMilliseconds;
  }

  static String getSendAtDayOrHour(int milliseconds) {
    int daysSinceMessage;
    int todayMidnight = getTodayMidnight();
    for (var i = 0; i < 7; i++) {
      if (milliseconds >= todayMidnight - (oneDayInMilliseconds * i)) {
        daysSinceMessage = i;
        break;
      }
    }
    if (daysSinceMessage == null) {
      return messageDay(milliseconds);
    }

    if (daysSinceMessage == 0) {
      return messageHour(milliseconds);
    }

    if (daysSinceMessage == 1) {
      return "Yesterday";
    }

    return messageWeekDay(milliseconds);
  }

  static String getSendAtDay(int milliseconds) {
    int daysSinceMessage;
    int todayMidnight = getTodayMidnight();
    for (var i = 0; i < 7; i++) {
      if (milliseconds >= todayMidnight - (oneDayInMilliseconds * i)) {
        daysSinceMessage = i;
        break;
      }
    }
    if (daysSinceMessage == null) {
      return messageDay(milliseconds);
    }

    if (daysSinceMessage == 0) {
      return "Today";
    }

    if (daysSinceMessage == 1) {
      return "Yesterday";
    }

    return messageWeekDay(milliseconds);
  }

  static String messageHour(int milliseconds) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return formatHour.format(date);
  }

  static String messageDay(int milliseconds) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return formatDay.format(date);
  }

  static String messageWeekDay(int milliseconds) {
    int weekday = new DateTime.fromMillisecondsSinceEpoch(milliseconds).weekday;
    return daysOfWeek[weekday - 1];
  }
}
