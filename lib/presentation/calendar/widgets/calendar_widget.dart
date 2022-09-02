import 'package:flutter/material.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/states/calendar_state.dart';

import 'section_widget.dart';

class CalendarWidget extends StatelessWidget {
  final CalendarController _calendarController = CalendarController();
  CalendarWidget({Key? key}) : super(key: key);

  List<Widget> getColumn(int startDay, BuildContext context) {
    var columns = List.generate(14, (index) {
      if (index % 2 == 0) {
        return SectionWidget(
          dayNumber: startDay,
        );
      } else {
        startDay++;
        return _linkWidget(
          context,
        );
      }
    });
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    getColumn(5, context);

    //columns.insert(0, _linkWidget(context, k: 0.9, type: 'line_break'));

    var rows = List.generate(9, (index) {
      if (index % 2 == 0) {
        return Column(
          children: getColumn(5, context),
        );
      } else {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        );
      }
    });
    return Row(
      children: [
        _daysOfTheWeek(context),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        ...rows
      ],
    );
  }
}

Widget _linkWidget(BuildContext context, {double k = 1, String type = 'line'}) {
  String url = type == 'line' ? "assets/link.png" : "assets/link_break.png";
  Color color = type == 'line' ? Colors.cyanAccent.withRed(200) : Colors.red;
  return Image.asset(url,
      width: MediaQuery.of(context).size.height * k * 0.04,
      height: MediaQuery.of(context).size.height * k * 0.04,
      color: color);
}

Widget _daysOfTheWeek(BuildContext context) {
  List<String> days = ['F', 'S', 'W', 'T', 'F', 'W', 'S'];
  int i = 0;

  var daysList = List.generate(13, (index) {
    if (index % 2 == 0) {
      return Container(
        height: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.1,
        child: Center(
            child: Text(days[i], style: Theme.of(context).textTheme.headline6)),
      );
    } else {
      i++;
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.04,
      );
    }
  });
  return Column(
    children: daysList,
  );
}
