import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/models/item.dart';
import 'SearchStates.dart';
import '';

class SearchCubit extends Cubit<Map<String, dynamic>> {
  SearchCubit() : super({'state': SearchInitState(), 'data': []});

  Future<void> getItems(String searchEntry) async {
    emit({'state': SearchLoadingState(), 'data': []});
    try {
      CollectionReference<Map<String, dynamic>> ref =
          FirebaseFirestore.instance.collection('items');
      Query<Map<String, dynamic>> query =
          ref.where('name', isGreaterThanOrEqualTo: searchEntry);
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documentSnapshots =
          querySnapshot.docs;

      List<Item> items = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in documentSnapshots) {
        Item item = Item.fromJson(doc.data(), doc.id);
        items.add(item);
      }
      emit({'state': SearchSuccessState(), 'data': items});
    } catch (e) {
      print(e.toString());
      emit({'state': SearchErrorState(), 'data': []});
    }
  }
}
