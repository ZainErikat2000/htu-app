import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/Page_Routing/PageRoutingCubit.dart';
import 'package:htu_app/Page_Routing/PageRoutingStates.dart';
import 'package:htu_app/Page_Routing/pages/SearchPage.dart';
import 'package:htu_app/Page_Routing/pages/cart_screen.dart';
import 'package:htu_app/Page_Routing/pages/categories_screen.dart';
import 'package:htu_app/Page_Routing/pages/profile/cubit.dart';
import 'package:htu_app/Page_Routing/pages/profile_screen.dart';
import 'package:htu_app/ViewModel/SignIn/cubit.dart';
import 'package:htu_app/ViewModel/cart/cubit.dart';
import 'package:htu_app/custom/DrawerButton.dart';

import 'Page_Routing/pages/settings_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PageRoutingCubit, PageRoutingStates>(
          builder: (context, state) {
        if (state is PageRoutingProfileState) {
          return BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit()..getUserInfo(),
              child: ProfileScreen());
        } else if (state is PageRoutingSettingsState) {
          return SettingsScreen();
        } else if (state is PageRoutingCartState) {
          return BlocProvider<CartCubit>(
              create: (context) => CartCubit()..getUserCart(),
              child: CartScreen());
        } else if (state is PageRoutingCategoriesState) {
          return CategoriesScreen();
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      }),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: Drawer(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                height: 200,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 2,
                            color: Colors.grey[400] ?? Colors.black))),
                height: MediaQuery.of(context).size.height * .6,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DrawerButtonSim(
                        onTap: () {
                          context.read<PageRoutingCubit>().BuildProfileScreen();
                          Navigator.pop(context);
                        },
                        text: 'Profile',
                        icon: Icon(Icons.person),
                      ),
                      DrawerButtonSim(
                        onTap: () {
                          context.read<PageRoutingCubit>().BuildCartScreen();
                          Navigator.pop(context);
                        },
                        text: 'Cart',
                        icon: Icon(Icons.shopping_cart),
                      ),
                      DrawerButtonSim(
                          onTap: () {
                            context
                                .read<PageRoutingCubit>()
                                .BuildCategoriesScreen();
                            Navigator.pop(context);
                          },
                          text: 'Categories',
                          icon: Icon(Icons.category)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
