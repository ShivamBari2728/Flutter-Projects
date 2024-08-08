// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchatapp/screens/splashscreen.dart';

class Logincontroller {
  static Future<void> loginAccount(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      SnackBar sucesssnackbar = SnackBar(
        content: Text(
          "Welcome",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(sucesssnackbar);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return Splashscreen();
      }), (route) => false);
    } catch (e) {
      SnackBar errorsnackbar = SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(errorsnackbar);
    }
  }
}
