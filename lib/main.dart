import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/Home.dart';
import 'package:htu_app/Page_Routing/PageRoutingCubit.dart';
import 'package:htu_app/SignUpPage.dart';
import 'package:htu_app/ViewModel/SignIn/cubit.dart';
import 'package:htu_app/ViewModel/SignIn/states.dart';

import 'SignInPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthWrapper(),routes: {
        'home' : (context) => BlocProvider<PageRoutingCubit>(
    create: (context) => PageRoutingCubit(),
    child: Home())
    },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInStates>(
        builder: (context, state) {
          if (state is SignInLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SignInPage();
          }
        },
        listener: (context, state) {
          if (state is SignInSuccessState) {
            print('signed in');
            Navigator.of(context).pushNamedAndRemoveUntil(
                'home',
                (route) => route.isFirst);
          }else if (state is SignInInitState){
            print('logged out');

          }
        },
      ),
    );
  }
}
