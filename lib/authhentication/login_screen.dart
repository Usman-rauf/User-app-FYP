import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authhentication/signup_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/main_screen.dart';

import '../widgets/progress_dialogue.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passowrdEditingController = TextEditingController();
  loginUserNow() async {
    if (!emailtextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email invalid");
    } else if (passowrdEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Passowrd is empty");
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext c) {
            return ProgressDialog(
              message: "Processing, please wait..",
            );
          });
      final User? firebaseUser = (await fAuth.signInWithEmailAndPassword(
        email: emailtextEditingController.text.trim(),
        password: passowrdEditingController.text.trim(),
      ))
          .user;
      if (firebaseUser != null) {
        DatabaseReference driversRef =
            FirebaseDatabase.instance.ref().child("users");
        driversRef.child(firebaseUser.uid).once().then((userkey) {
          final snap = userkey.snapshot;
          if (snap.value != null) {
            currentFirebaseUser = firebaseUser;
            Fluttertoast.showToast(msg: "Login successfull");
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => MainScreen()));
          } else {
            Fluttertoast.showToast(msg: "No record with this email");
            fAuth.signOut();
            Navigator.pop(context);
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (c) =>LoginScreen ()));
          }
        });
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error occurred");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("images/logo.png"),
            ),
            SizedBox(height: 10),
            const Text(
              "Login as a User",
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              style: const TextStyle(
                color: Colors.grey,
              ),
              controller: emailtextEditingController,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: 'Email',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextField(
              style: const TextStyle(
                color: Colors.grey,
              ),
              controller: passowrdEditingController,
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: 'Password',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                loginUserNow();
              },
              style: ElevatedButton.styleFrom(primary: Colors.lightGreenAccent),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => SignUpScreen()));
              },
              child: const Text(
                "Do you have an account? Signup here",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
