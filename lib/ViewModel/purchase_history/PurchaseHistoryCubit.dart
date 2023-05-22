import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/bill.dart';

class PurchaseHistoryCubit extends Cubit<List<Bill>> {
  PurchaseHistoryCubit() : super([]);

  Future<void> getBills() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String uid = pref.getString('id') ?? '';

    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(uid);
    ref.get().then((doc) {
      List historyList = doc['bought'];

      List<Bill> billList = [];
      for (var bill in historyList) {
        billList.add(Bill(date: bill['date'], items: bill['items']));
      }

      emit(billList);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
