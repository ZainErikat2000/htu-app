import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/ViewModel/cart/cubit.dart';
import 'package:htu_app/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextStyle totalStyle = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, List<Item>>(
        builder: (context, items) {
          double total = 0.0;
          for (Item item in items) {
            total += item.price;
          }

          List<Widget> itemsWidgets = List<Widget>.generate(
            items.length,
            (index) => Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 2, color: Colors.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(blurRadius: 5, color: Colors.grey)
                            ], borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                items[index].pic,
                                fit: BoxFit.fitWidth,
                                width: 80,
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 38,
                                    child: Text(items[index].name,
                                        textAlign: TextAlign.center),
                                  ),
                                  Container(
                                    height: 38,
                                    child: Text('Price: ${items[index].price}'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );

          itemsWidgets.add(Container(
            width: MediaQuery.of(context).size.width,
            height: 90,
          ));

          if (items.isEmpty) {
            return const Center(child: Text('No Items in Cart.'));
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: itemsWidgets,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white54,
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 2,
                                  right: 2,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [BoxShadow(blurRadius: 1)]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total:', style: totalStyle),
                                      Text(total.toStringAsFixed(2),
                                          style: totalStyle)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (items.isEmpty) {
                                      return;
                                    }

                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    String uid = prefs.getString('id') ?? '';
                                    if (uid.isEmpty) {
                                      return;
                                    }

                                    CollectionReference ref = FirebaseFirestore
                                        .instance
                                        .collection('users');
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(uid)
                                        .get()
                                        .then((doc) async {
                                      //get items IDs
                                      List<dynamic> cartItems =
                                          doc.data()!['cart'];
                                      //get current date and format it
                                      DateTime currentDate = DateTime.now();
                                      String date =
                                          '${currentDate.year}-${currentDate.month}-${currentDate.day}';

                                      Map<String, dynamic> map = {
                                        'date': date,
                                        'items': cartItems
                                      };

                                      ref.doc(uid).update({
                                        'bought': FieldValue.arrayUnion([map])
                                      });

                                      ref.doc(uid).update({
                                        'cart': FieldValue.delete()
                                      });
                                    }).onError(
                                      (error, stackTrace) {
                                        print(error.toString());
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('An Error Occured'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('ok'))
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Complete your Purchase')),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
