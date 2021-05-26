import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/models/registermodel.dart';
import 'package:sociaapp/modules/register/cubit/registerstate.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitalRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility;
  bool ispassword = true;
  void changePassword() {
    ispassword = !ispassword;
    suffix = ispassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangeVisibityPassword());
  }

  void register({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.uid);
      putUser(
        name: name,
        email: email,
        phone: phone,
        uid: value.user.uid,
      );

      emit(RegisterSucessState(value.user.uid));
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState(error));
    });
  }

  RegisterModel model;
  void putUser({
    @required String name,
    @required String email,
    @required String phone,
    @required String uid,
    String bio,
    String image,
    String cover,
  }) {
    model = RegisterModel(
      userName: name,
      email: email,
      phone: phone,
      uid: uid,
      bio: 'write you bio ...',
      cover:
          'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
      image:
          'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
      isemailverified: false,
    );

    FirebaseFirestore.instance.collection('Users').doc(uid).set(model.toMap());
  }
}
