import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/data/main_repository_impl.dart';
import 'package:flutter_why_do_i_awake_nights1/data/models/tag_model.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/post_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/entities/tag_entity.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/main_repository.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/post/bloc/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitialState());

  Future<void> addPost({
    required String descriptoin,
    List<String>? imagesUrl,
    List<TagEntity>? tags,
    required DateTime dateTime,
  }) async {
    MainRepository mainRepository = MainRepositoryImpl();
    emit(PostLoadingState());
    await mainRepository.addPost(
      descriptoin: descriptoin,
      tags: tags?.map((e) => e.toModel()).toList(),
      imagesUrl: imagesUrl,
      timestamp: Timestamp.fromDate(dateTime),
    );

    emit(PostLoadedState());
  }

  Future<void> removePost(PostEntity post) async {
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
    MainRepository mainRepository = MainRepositoryImpl();

    emit(PostLoadingState());

    await mainRepository.removePost(post);
    emit(PostLoadedState());
  }

  Future<void> editPost(
      {required String descriptoin,
      List<String>? imagesUrl,
      List<TagEntity>? tags,
      required DateTime dateTime,
      required String postID}) async {
    emit(PostLoadingState());
    MainRepository mainRepository = MainRepositoryImpl();
    await mainRepository.editPost(
      postID: postID,
      descriptoin: descriptoin,
      imagesUrl: imagesUrl,
      tags: tags,
      timestamp: Timestamp.fromDate(dateTime),
    );

    emit(PostLoadedState());
  }
}
