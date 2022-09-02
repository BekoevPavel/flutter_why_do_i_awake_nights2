import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_why_do_i_awake_nights1/data/main_repository_impl.dart';
import 'package:flutter_why_do_i_awake_nights1/domain/main_repository.dart';
import 'package:flutter_why_do_i_awake_nights1/presentation/auth/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    MainRepository mainRepository = MainRepositoryImpl();
    var res = await mainRepository.singIn(email: email, password: password);
    if (res != null) {
      emit(AuthFailure(message: res.toString()));
      print('error');
    } else {
      print('norm');
      emit(AuthSignIn());
    }
  }

  Future<void> signOut() async {
    MainRepository mainRepository = MainRepositoryImpl();
    await mainRepository.singOut();
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String username}) async {
    emit(AuthLoading());
    MainRepository mainRepository = MainRepositoryImpl();

    var res = await mainRepository.singUp(
        email: email, userName: username, password: password);
    if (res != null) {
      emit(AuthFailure(message: res.toString()));
    } else {
      emit(AuthSignUp());
    }
  }
}
