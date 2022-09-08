class PostController {
  String getDayName(int day) {
    List<String> names = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    if (day <= 7) {
      return names[day - 1];
    }
    return names[0];
  }
}
