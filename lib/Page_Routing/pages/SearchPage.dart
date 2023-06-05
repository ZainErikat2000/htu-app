import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/ViewModel/search/SearchCubit.dart';
import 'package:htu_app/ViewModel/search/SearchStates.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(),
      child: Scaffold(
          appBar: AppBar(),
          body: BlocConsumer<SearchCubit, Map<String, dynamic>>(
            listener: (context, map) {
              if (map['state'] is SearchErrorState) {
                showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                          title: Text('An Error occurred'),
                        ));
              }
            },
            builder: (context, map) {
              Widget main;

              if (map['state'] is SearchSuccessState) {
                main = Column(
                  children: List.generate(map['data'].length,
                      (index) => Text('${map['data'][index].name}')),
                );
              } else if (map['state'] is SearchLoadingState) {
                main = const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                main = Text('Search for an item');
              }

              return SizedBox(
                  width: fullWidth,
                  height: fullHeight,
                  child: Stack(
                    children: [
                      Positioned(child: main),
                      Positioned(
                          bottom: 0,
                          child: Row(
                            children: [
                              SizedBox(
                                width: fullWidth * .79,
                                child: TextField(
                                  controller: searchController,
                                ),
                              ),
                              SizedBox(
                                width: fullWidth * .2,
                                child: ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<SearchCubit>()
                                          .getItems(searchController.text);
                                    },
                                    child: const Icon(Icons.search)),
                              )
                            ],
                          ))
                    ],
                  ));
            },
          )),
    );
  }
}
