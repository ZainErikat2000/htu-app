import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/ViewModel/items_list/cubit.dart';
import 'package:htu_app/ViewModel/purchase_history/PurchaseHistoryCubit.dart';

import '../../models/bill.dart';
import '../../models/item.dart';

class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PurchaseHistoryCubit, List<Bill>>(
        builder: (context, billsList) {
          if (billsList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<String> itemsIDs = [];
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: List<Widget>.generate(
                      billsList.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .7,
                              decoration: BoxDecoration(color: Colors.white,
                                  boxShadow: [BoxShadow(blurRadius: 3)],
                                  borderRadius: BorderRadius.circular(9)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocProvider(
                                  create: (context) => ItemsListCubit()
                                    ..getItemsFromIDs(List<String>.from(
                                        billsList[index].items)),
                                  child: Center(
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      direction: Axis.vertical,
                                      children: [
                                        Text('Date:   ${billsList[index].date}'),
                                        BlocBuilder<ItemsListCubit, List<Item>>(
                                            builder: (context, il) {
                                          double total = 0;
                                          for (Item item in il) {
                                            total += item.price;
                                          }

                                          List<Widget> itemsInfo =
                                              List<Widget>.generate(
                                            il.length,
                                            (i) => Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(width:2))),
                                              height: 30,
                                              width: MediaQuery.of(context).size.width*.6,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(il[i].name),
                                                  Text(il[i].price.toString())
                                                ],
                                              ),
                                            ),
                                          );

                                          itemsInfo.add(Text('Total:   ${total.toStringAsFixed(2)}'));

                                          return Column(
                                            children: itemsInfo,
                                          );
                                        },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
