import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/SignUpPage.dart';
import 'package:htu_app/ViewModel/SignIn/cubit.dart';
import 'package:htu_app/ViewModel/SignIn/states.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String warningMessage = '';

  void signInCheck(String email, String pass) {
    if (email.isEmpty || pass.isEmpty) {
      setState(() {
        warningMessage = 'Please fill the fields';
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Sign In',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                warningMessage,
                style: const TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: BlocConsumer<SignInCubit, SignInStates>(
                  builder: (context, state) => ElevatedButton(
                    onPressed: () async {
                      signInCheck(
                          emailController.text, passwordController.text);

                        await context.read<SignInCubit>().SignInUser(
                            emailController.text, passwordController.text);
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  listener: (context, state) {
                    if (state is SignInErrorState) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              const SizedBox(height: 50),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                        text: "Don't have an account?",
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                      text: ' Sign Up!',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
