import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/ViewModel/SignIn/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInInitState());

  Future<void> SignInUser(String email, String password) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      pref.setString('id', value.user!.uid.toString());
      if (kDebugMode) {
        print(value.user!.uid.toString());
      }
      emit(SignInSuccessState());
    })
        //ON ERROR
        .catchError((onError) {
      emit(
        SignInErrorState(
          msg: onError,
        ),
      );
    });
  }

  Future<void> SignOutUser() async {
    emit(SignInInitState());
    await FirebaseAuth.instance.signOut();
  }
}
