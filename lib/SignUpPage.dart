import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String picUrl = '';
  String stateMessage = '';
  Color stateMessageColor = Colors.red;
  bool imagesPicked = false;

  Future<String> uploadImage() async {
    //pick image
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    //check if image picked
    if (pickedImage == null) {
      setState(() {
        stateMessage = 'Please pick a picture';
        stateMessageColor = Colors.red;
      });
      return '';
    }

    //turn image XFile to File
    final photo = io.File(pickedImage.path);

    //set refs
    final fileName = pickedImage.name;
    final destination = 'profilePics/$fileName';

    try {
      final ref =
          FirebaseStorage.instance.ref(destination).child('profilePics/');
      final uploadedTask = await ref.putFile(photo).then((p0) async {
        picUrl = await p0.ref.getDownloadURL();
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        stateMessage = 'an error occurred during uploading the file';
        stateMessageColor = Colors.red;
      });
      return picUrl;
    }
    imagesPicked = false;
    return picUrl;
  }

  void signUp(
      {required String email,
      required String pass,
      required String passR,
      required String fName,
      required String lName,
      required String year,
      required String month,
      required String day}) async {
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

    if (year.length != 4 || int.parse(year) < 1900) {
      setState(() {
        stateMessage = 'Please enter valid year';
        stateMessageColor = Colors.red;
      });
      return;
    }

    if (int.parse(month) > 12 || int.parse(month) < 1) {
      setState(() {
        stateMessage = 'Please enter valid month';
        stateMessageColor = Colors.red;
      });
      return;
    }

    if (int.parse(day) > 31 || int.parse(day) < 1) {
      setState(() {
        stateMessage = 'Please enter valid day of month';
        stateMessageColor = Colors.red;
      });
      return;
    }

    if (!imagesPicked) {
      setState(() {
        stateMessage = 'Please enter choose a profile picture';
        stateMessageColor = Colors.red;
      });
    }

    String picURL = await uploadImage();

    if(picURL.isEmpty){
      setState(() {
        stateMessage = 'Failed to get profile pic';
        stateMessageColor = Colors.red;
      });
       return;
     }

    //sign up user
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then(
      (userCredential) async {
        String? uid = userCredential.user?.uid;
        CollectionReference reference =
            FirebaseFirestore.instance.collection('users');
        await reference.doc(uid).set({
          'dob': '$year-$month-$day',
          'email': email,
          'fname': fName,
          'lname': lName,
          'pic': picURL
        });

        setState(
          () {
            stateMessage = 'Sign up successfully';
            stateMessageColor = Colors.green;
          },
        );
      },
    ).onError((onError, stackTrace) {
      setState(() {
        stateMessage = 'An Error Occurred: $onError';
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
                  onPressed: () => signUp(
                      email: emailController.text,
                      pass: passwordController.text,
                      passR: passwordRepeatController.text,
                      fName: firstNameController.text,
                      lName: lastNameController.text,
                      year: bDayYearController.text,
                      month: bDayMonthController.text,
                      day: bDayDayController.text),
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
