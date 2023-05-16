import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/ViewModel/categories/cubit.dart';
import 'package:htu_app/models/item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<CategoryCubit>(
                      create: (context) => CategoryCubit()
                        ..getItemsFromCategory(category: 'Tech'),child: Scaffold(appBar: AppBar(),body: BlocBuilder<CategoryCubit,List<Item>>(builder: (context,list){
                          if(list.isEmpty){
                            return Center(child: CircularProgressIndicator(),);
                          }else{
                            return ListView.builder(itemCount: list.length,itemBuilder: (context,index) => ListTile(title: Text(list[index].name),));
                          }
                    }),),
                    ),
                  ),
                ),
            child: Text('hello')));
  }
}
