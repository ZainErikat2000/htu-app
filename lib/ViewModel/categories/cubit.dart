import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/models/item.dart';

class CategoryCubit extends Cubit<List<Item>> {
  CategoryCubit() : super([]);

  Future<void> getItemsFromCategory({required String category}) async {
    final result = await FirebaseFirestore.instance
        .collection('items')
        .where('category', isEqualTo: category)
        .get();
    emit(result.docs.map((e) => Item.fromJson(e.data())).toList());
  }
}
