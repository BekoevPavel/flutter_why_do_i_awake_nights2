import 'package:equatable/equatable.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';

abstract class CalendarState extends Equatable {
  List<String> monts = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  List<PostEntity> posts;

  late String monthName;
  int month;

  CalendarState({required this.month, required this.posts}) {
    monthName = monts[month - 1];
  }
  @override
  List<Object?> get props => [monthName, month];
}

class CalendarInitial extends CalendarState {
  CalendarInitial({required super.month, required super.posts});
}

class CalendarLoadiang extends CalendarState {
  CalendarLoadiang({required super.month, required super.posts});

  @override
  List<Object?> get props => [month];
}

class UpdateMonth extends CalendarState {
  UpdateMonth({required super.month, required super.posts}) {
    monts[month - 1];
  }
}
