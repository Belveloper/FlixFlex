import 'package:firebase_auth/firebase_auth.dart';
import 'package:flixflex/controllers/Login/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final auth = FirebaseAuth.instance;

  bool isObscure = true;

  bool isLogin = true;

  void toggleLoginRegister() {
    isLogin = !isLogin;
    emit(LoginAndRegister());
  }

  void toggleObscure() {
    isObscure = !isObscure;
    emit(ChangePasswordVisibility());
  }

  void userRegister({required String email, required String password}) {
    emit(RegisterLoadState());
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      emit(RegisterSuccessState());
      Hive.box('local').put('uid', value.user!.uid);
      if (kDebugMode) {
        print('user registred successfuly');
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      if (error is FirebaseAuthException) {
        print(error.message);
        emit(RegisterErrorState(error.message.toString()));
      } else {
        emit(RegisterErrorState(error.toString()));
      }
    });
  }

  void userLogin({required String email, required String password}) {
    emit(LoginLoadState());
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      emit(LoginSuccessState());
      Hive.box('data').put('uid', value.user!.uid);
    }).catchError((
      error,
    ) {
      if (kDebugMode) {
        print(error);
      }
      if (error is FirebaseAuthException) {
        emit(LoginErrorState(error.message.toString()));
      } else {
        emit(LoginErrorState(error.toString()));
      }
    });
  }
}
