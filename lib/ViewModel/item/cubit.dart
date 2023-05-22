import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/models/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCubit extends Cubit<Item> {
  ProfileCubit()
      : super(Item(
            name: 'Loading',
            price: 0,
            category: 'Loading',
            date: 'Loading',
            pic: '',
            id: 'wew'));

  Future<void> getItemInfo(String id) async {
    try {
      CollectionReference items =
          FirebaseFirestore.instance.collection('items');
      SharedPreferences pref = await SharedPreferences.getInstance();
      String docid = pref.getString(id) ?? '';
      dynamic doc = await items.doc(docid).get();
      emit(
        Item(
            name: doc['name'],
            price: doc['price'],
            category: doc['category'],
            date: doc['json'],
            pic: doc['pic'],
            id: docid),
      );
    } catch (e) {
      print(e.toString());
      emit(Item(
          name: 'error',
          price: 0,
          category: 'error',
          date: 'error',
          pic: 'error',
          id: 'error'));
    }
  }
}
