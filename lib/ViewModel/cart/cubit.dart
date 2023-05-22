import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<List<Item>>{
  CartCubit():super([]);
  Future<void> getUserCart() async{
    List<dynamic> itemsIDs = [];
    List<Item> items = [];

    //Get user id from shared prefs
    SharedPreferences pref = await SharedPreferences.getInstance();
    String uid = pref.getString('id') ?? '';

    //get cart array from user's document and then...
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((doc) async {
      itemsIDs = doc.data()!['cart'];
      if(itemsIDs.isEmpty){
        print('no items in cart\nUser id $uid');
      }

      for(String id in itemsIDs){
        if(id.isEmpty){
          //DO NOTHING
        }else{
          DocumentSnapshot<Map<String,dynamic>> itemDoc = await FirebaseFirestore.instance.collection('items').doc(id).get();
          print(itemsIDs);
          Item item = Item.fromJson(itemDoc.data()??{}, itemDoc.id);
          items.add(item);
        }
      }
      emit(items);
    }).onError((error, stackTrace) {
      print('an error occurred fetching the cart: ${error}');
      emit([]);
    });
  }
}