import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';

class CalendarController {
  int findFirstDay(int month) {
    return DateTime(2022, month, 1).weekday;
  }

  int findLastNumber(int month) {
    if (month != 1) {
      DateTime x1 = DateTime(2022, month, 1).toUtc();
      var lastDay = DateTime(2022, month + 1, 1).toUtc().difference(x1).inDays;

      return lastDay;
    } else {
      DateTime x1 = DateTime(2022, 12, 0).toUtc();
      var lastDay = DateTime(2023, 1, 0).toUtc().difference(x1).inDays;
      return lastDay;
    }
  }

  List<DateTime> _findFirstDays(DateTime dateTime) {
    int firstDay = findLastNumber(dateTime.month - 1);

    int middleDay = findFirstDay(dateTime.month);

    List<DateTime> firstLst = [];
    for (int i = middleDay - 2; i >= 0; i--) {
      firstLst.add(DateTime(dateTime.year, dateTime.month - 1, firstDay - i));
    }
    firstLst.add(DateTime(dateTime.year, dateTime.month, 1));
    //firstLst.add(1);

    int firstIndex = firstLst.length;
    int day = 2;

    for (int i = firstIndex; i < 7; i++) {
      //firstLst.add(day);
      firstLst.add(DateTime(dateTime.year, dateTime.month, day));
      day++;
    }

    return firstLst;
  }

  List<DateTime> _findMiddleDays(DateTime dateTime) {
    int firstValue = _findFirstDays(dateTime).last.day;

    return List.generate(
        21,
        (index) =>
            DateTime(dateTime.year, dateTime.month, index + firstValue + 1));
  }

  List<DateTime> _findLastDays(DateTime dateTime) {
    List<DateTime> res = [];
    int firstDay = findLastNumber(dateTime.month);
    int middleDay = findFirstDay(dateTime.month + 1);

    for (int i = middleDay; i > 1; i--) {
      res.add(DateTime(dateTime.year, dateTime.month, firstDay));
      firstDay--;
    }
    int first = 1;
    res = res.reversed.toList();
    res.add(DateTime(dateTime.year, dateTime.month + 1, first));

    for (int i = res.length; i < 7; i++) {
      first++;
      res.add(DateTime(dateTime.year, dateTime.month + 1, first));
    }

    return res;
  }

  List<DateTime> calculeMonth(DateTime dateTime) {
    return [
      ..._findFirstDays(dateTime),
      ..._findMiddleDays(dateTime),
      ..._findLastDays(dateTime)
    ];
  }

  bool foundInPostEntity(DateTime dateTime, PostEntity post) {
    DateTime date1 =
        DateTime.fromMillisecondsSinceEpoch(post.timestamp.seconds * 1000);

    if (dateTime.month == date1.month &&
        dateTime.day == date1.day &&
        dateTime.year == date1.year) return true;
    return false;
  }

  bool equelMonth(DateTime date1, DateTime date2) {
    if (date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year) {
      return true;
    }
    return false;
  }
}
