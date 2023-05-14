import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/Page_Routing/pages/profile/cubit.dart';
import 'package:htu_app/Page_Routing/pages/profile/states.dart';
import 'package:htu_app/ViewModel/SignIn/cubit.dart';
import 'package:htu_app/ViewModel/SignIn/states.dart';
import 'package:htu_app/custom/LogOutButton.dart';

import '../../models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, User>(
      builder: (context, user) => Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
                margin:
                    EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('First Name:', style: TextStyle(color: Colors.grey)),
                      Text('${user.fName}'),
                    ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
                margin:
                EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Last Name:', style: TextStyle(color: Colors.grey)),
                      Text('${user.lName}'),
                    ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
                margin:
                EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email:', style: TextStyle(color: Colors.grey)),
                      Text('${user.email}'),
                    ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
                margin:
                EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('DOB:', style: TextStyle(color: Colors.grey)),
                      Text('${user.dob}'),
                    ]),
              ),
            ],
          ),
          BlocProvider(
              create: (context) => SignInCubit(), child: LogOutButton())
        ],
      ),
    );
  }
}
