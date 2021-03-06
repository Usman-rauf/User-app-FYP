import 'dart:async';

import 'package:flutter/material.dart';
import 'package:users_app/authhentication/login_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/main_screen.dart';

import '../assitants/assistant_methods.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    fAuth.currentUser != null
        ? AssitantMethods.readCurrentOnLineUserInfp()
        : null;
    Timer(const Duration(seconds: 3), () async {
      Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));

      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;

        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.png"),
            const SizedBox(height: 10),
            const Text(
              "Go where you want",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        )),
      ),
    );
  }
}
