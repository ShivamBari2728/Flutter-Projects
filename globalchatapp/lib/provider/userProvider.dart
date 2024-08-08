import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class userProvider extends ChangeNotifier{

  Map<String, dynamic>? data = {};

  void fetchdata() async {
  var db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
    await db.collection("users").doc(user!.uid).get().then((datasnapshot) {
      data = datasnapshot.data();
    });
  }


}