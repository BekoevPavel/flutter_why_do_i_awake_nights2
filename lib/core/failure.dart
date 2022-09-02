import 'package:equatable/equatable.dart';

enum AuthFailure {
  userNotFound,
  wrongPassword,
  weakPassword,
  emailAlreadyInUse
}
