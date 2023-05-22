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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bDayYearController = TextEditingController();
  TextEditingController bDayMonthController = TextEditingController();
  TextEditingController bDayDayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .35,
                        child: TextField(
                          controller: firstNameController,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .35,
                        child: TextField(
                          controller: lastNameController,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Date of Birth'),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: bDayYearController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'Year',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: bDayMonthController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'Month',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: bDayDayController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'Day',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  controller: passwordRepeatController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Repeat Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                textAlign: TextAlign.center,
                stateMessage,
                style: TextStyle(color: stateMessageColor, fontSize: 14),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  onPressed: () => signUp(emailController.text,
                      passwordController.text, passwordRepeatController.text),
                  child: const Text('Sign Up'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
