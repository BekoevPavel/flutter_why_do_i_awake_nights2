import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_why_do_i_awake_nights1/data/main_repository_impl.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/states/calendar_state.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/widgets/link_widget.dart';
import 'section_widget.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime currentDate;

  List<PostEntity> posts;
  final CalendarController _calendarController = CalendarController();
  CalendarWidget({Key? key, required this.currentDate, required this.posts})
      : super(key: key);

  List<Widget> getColumn(List<DateTime> lst, BuildContext context) {
    int i = 0;

    var columns = List.generate(14, (index) {
      if (index % 2 == 0) {
        return SectionWidget(
          dayNumber: lst[i].day,
          color: (lst[i].month != currentDate.month)
              ? Theme.of(context).dividerColor
              : null,
        );
      } else {
        i++;

        var breakPosts = posts
            .where((element) =>
                _calendarController.foundInPostEntity(lst[i - 1], element))
            .toList();

        return LinkWidget1(
          dateTime: lst[i - 1],
          post: breakPosts.isNotEmpty ? breakPosts.first : null,
          type: lst[i - 1].isBefore(DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day))
              ? 'line'
              : null,
        );
      }
    });
    return columns;
  }

  List<DateTime> _find7days(List<DateTime> lst) {
    List<DateTime> res = [];
    for (int i = 0; i < 7; i++) {
      res.add(lst[i]);
    }
    lst.removeRange(0, 7);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    //---
    // posts = [
    //   // PostEntity(
    //   //   userID: '',
    //   //   description: '',
    //   //   postID: '',
    //   //   timestamp: Timestamp.fromDate(
    //   //     DateTime(currentDate.year, currentDate.month, 5),
    //   //   ),
    //   // ),
    //   // PostEntity(
    //   //   userID: '',
    //   //   description: '',
    //   //   postID: '',
    //   //   timestamp: Timestamp.fromDate(
    //   //     DateTime(currentDate.year, currentDate.month, 2),
    //   //   ),
    //   // ),
    //   // PostEntity(
    //   //   userID: '',
    //   //   description: '',
    //   //   postID: '',
    //   //   timestamp: Timestamp.fromDate(
    //   //     DateTime(currentDate.year, 9, 1),
    //   //   ),
    //   // ),
    // ];

    //----

    int startDay = 1;

    var calculed = _calendarController.calculeMonth(currentDate);

    var rows = List.generate(9, (index) {
      if (index % 2 == 0) {
        return Column(
          children: getColumn(_find7days(calculed), context),
        );
      } else {
        startDay += 7;

        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        );
      }
    });
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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

Widget _daysOfTheWeek(BuildContext context) {
  List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  int i = 0;

  var daysList = List.generate(13, (index) {
    if (index % 2 == 0) {
      return SizedBox(
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
