import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/modules/login/cubit/loginstate.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitalLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility;
  bool ispassword = true;
  void changePassword() {
    ispassword = !ispassword;
    suffix = ispassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangeVisibityPassword());
  }

  void signIn({@required String email, @required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.uid);
      emit(LoginSucessState(value.user.uid));
    }).catchError((error) {
      emit(LoginErrorState(error));
    });
  }
}
