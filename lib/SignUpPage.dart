import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String stateMessage = '';
  Color stateMessageColor = Colors.red;

  void signUp(String email, String pass, String passR) async {
    //check for empty input fields
    if (email.isEmpty || pass.isEmpty || passR.isEmpty) {
      setState(() {
        stateMessage = 'Please fill all of the available fields';
        stateMessageColor = Colors.red;
      });
      return;
    }

    //check if valid email
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (!emailValid) {
      setState(() {
        stateMessage = 'Please Enter a Valid Email';
        stateMessageColor = Colors.red;
      });

      return;
    }
    //check if passwords match
    if (pass != passR) {
      setState(() {
        stateMessage = "Passwords don't match";
        stateMessageColor = Colors.red;
      });

      return;
    }

    //sign up user
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then(
          (value) => setState(
            () {
              stateMessage = 'Sign up successfully';
              stateMessageColor = Colors.green;
            },
          ),
        )
        .catchError((onError) {
      setState(() {
        stateMessage = 'An Error Occured: $onError';
        stateMessageColor = Colors.red;
      });
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  controller: emailController,
                  obscureText: false,
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
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  controller: passwordRepeatController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Repeat Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(textAlign: TextAlign.center,
                stateMessage,
                style: TextStyle(color: stateMessageColor,fontSize: 14),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  onPressed: () => signUp(emailController.text, passwordController.text, passwordRepeatController.text),
                  child: Text('Sign Up'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
