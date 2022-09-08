import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {}
