import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/item.dart';
import 'cubit.dart';

class CategoryRoute extends StatefulWidget {
  const CategoryRoute({required this.category,Key? key}) : super(key: key);
  final String category;

  @override
  State<CategoryRoute> createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>(
        create: (context) => CategoryCubit()
          ..getItemsFromCategory(category: widget.category),child: Scaffold(appBar: AppBar(),body: BlocBuilder<CategoryCubit,List<Item>>(builder: (context,list){
        if(list.isEmpty){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView.builder(itemCount: list.length,itemBuilder: (context,index) => ListTile(title: Text(list[index].name),));
        }
      }),),
      );
  }
}
