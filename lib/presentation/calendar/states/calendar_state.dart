class CalendarController {
  int findFirstDay(int month) {
    return DateTime(2022, month, 1).weekday;
  }

  int findLastDay(int month) {
    DateTime x1 = DateTime(2022, month, 0).toUtc();
    var lastDay = DateTime(2022, month + 1, 0).toUtc().difference(x1).inDays;

    return DateTime(2022, month, lastDay).weekday;
  }

  int findLastNumberPrevious(int month) {
    if (month != 1) {
      DateTime x1 = DateTime(2022, month - 1, 0).toUtc();
      var lastDay = DateTime(2022, month, 0).toUtc().difference(x1).inDays;
      return lastDay;
    } else {
      DateTime x1 = DateTime(2022, 12, 0).toUtc();
      var lastDay = DateTime(2023, 1, 0).toUtc().difference(x1).inDays;
      return lastDay;
    }
  }

  List<int> daysInTheWeek(int week, int month) {
    List<int> days = [];
    if (week == 0) {
      int lastDate = findLastNumberPrevious(month);
      int firstDayOnWeek = findFirstDay(month);
      //for(int i = )
    }
    return [];
  }
}
