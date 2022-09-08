import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/data/main_repository_impl.dart';
import 'package:flutter_why_do_i_awake_nights1/data/models/post_model.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/main_repository.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/calendar/bloc/calendar_state.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/bloc/post_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit()
      : super(CalendarInitial(month: DateTime.now().month, posts: []));

  Future<void> updateMonth(int month) async {
    emit(CalendarLoadiang(month: month, posts: []));

    MainRepository mainRepository = MainRepositoryImpl();

    List<PostEntity> posts = await mainRepository.getAllPost();

    emit(UpdateMonth(month: month, posts: posts));
  }
}
