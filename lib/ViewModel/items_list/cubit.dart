import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/item.dart';

class ItemsListCubit extends Cubit<List<Item>> {
  ItemsListCubit() : super([]);

  Future<void> getItemsFromIDs(List<String> ids) async {
    await FirebaseFirestore.instance
        .collection('items')
        .where(FieldPath.documentId, whereIn: ids)
        .get()
        .then((QuerySnapshot snapshot) {
      emit(snapshot.docs
          .map((DocumentSnapshot doc) =>
              Item.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList());
    });
  }
}
