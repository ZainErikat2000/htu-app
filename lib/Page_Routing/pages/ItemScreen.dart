import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:htu_app/custom/ItemInfoPiece.dart';
import 'package:htu_app/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({required this.item, Key? key}) : super(key: key);
  final Item item;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Image.network(widget.item.pic),
              ),
              ItemInfoPiece(infoName: 'Price', info: '\$${widget.item.price}'),
              ItemInfoPiece(infoName: 'Date Posted', info: widget.item.date),
              ItemInfoPiece(infoName: 'Category', info: widget.item.category),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  String? uid = pref.getString('id');

                  CollectionReference users =
                      FirebaseFirestore.instance.collection('users');
                  await users.doc(uid).update({
                    'cart': FieldValue.arrayUnion([widget.item.id])
                  }).then((value) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actionsAlignment: MainAxisAlignment.center,
                        title: const Text(
                          'Item is now in your cart',
                        ),
                        content: Text('Item ID: ${widget.item.id}'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    );
                  });
                },
                child: const Text('Buy'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
