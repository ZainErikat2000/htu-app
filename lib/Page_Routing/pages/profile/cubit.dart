import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/Page_Routing/pages/profile/states.dart';
import 'package:htu_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCubit extends Cubit<User> {
  ProfileCubit() : super(User(fName: 'loading', lName: 'loading', dob: 'loading',email: 'loading', pic: 'loading'));

  Future<void> getUserInfo() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      SharedPreferences pref = await SharedPreferences.getInstance();
      String uid = pref.getString('id') ?? '';
      dynamic doc = await users.doc(uid).get();
      emit(User(
          fName: doc['fname'],
          lName: doc['lname'],
          dob: doc['dob'],
          email: doc['email'],
          pic: doc['pic']));
    } catch (e) {
      print(e.toString());
      emit(User(fName: 'error', lName: 'error', dob: 'error',email: 'error', pic: 'error'));
    }
  }
}
