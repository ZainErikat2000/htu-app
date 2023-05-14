import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/ViewModel/SignIn/cubit.dart';
import 'package:htu_app/ViewModel/SignIn/states.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInStates>(
      builder: (context, state) => ElevatedButton(
          onPressed: () {
            context.read<SignInCubit>().SignOutUser();
          },
          child: Text('Log Out')),
      listener: (context, state) {
        if (state is SignInInitState) {
          print('signed out');
          Navigator.of(context).pop();
        }
      },
    );
  }
}
