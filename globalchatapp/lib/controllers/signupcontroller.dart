// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:globalchatapp/screens/splashscreen.dart';

class Signupcontroller {
  static Future<void> createAccount(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String country}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var userid = FirebaseAuth.instance.currentUser!.uid;
      var db = FirebaseFirestore.instance;

      Map<String, dynamic> udata = {
        "name": name,
        "country": country,
        "email": email,
        "userID": userid.toString()
      };
      try {
        await db.collection("users").doc((userid.toString())).set(udata);
      } catch (e) {print(e);}

      SnackBar sucesssnackbar = SnackBar(
        content: Text(
          "Account Created",
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
