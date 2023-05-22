import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/Page_Routing/pages/ItemScreen.dart';

import '../../models/item.dart';
import 'cubit.dart';

class CategoryRoute extends StatefulWidget {
  const CategoryRoute({required this.category, Key? key}) : super(key: key);
  final String category;

  @override
  State<CategoryRoute> createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>(
      create: (context) =>
          CategoryCubit()..getItemsFromCategory(category: widget.category),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<CategoryCubit, List<Item>>(builder: (context, list) {
          if (list.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.count(
              childAspectRatio: 1 / 1.2,
              crossAxisCount: 2,
              children: List.generate(
                list.length,
                (index) {
                  return Container(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ItemScreen(item: list[index]))),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .6,
                            height: MediaQuery.of(context).size.height * .2,
                            child: Image.network(
                              list[index].pic,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                list[index].name,
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '\$${list[index].price}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        }),
      ),
    );
  }
}
