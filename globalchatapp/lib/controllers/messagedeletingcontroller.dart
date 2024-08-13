// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Messagedeletingcontroller {
  var db = FirebaseFirestore.instance;
  showdeleteconfermation(
      {required String SenderId,
      required bool currentuser,
      required String documentid,
      required BuildContext context}) {
    if (currentuser) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Message"),
            content: Text("Are you sure you want to delete this message?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  deleteMessage(documentid, context);
                  Navigator.pop(context);
                },
                child: Text("Delete"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Message"),
            content: Text("Are you sure you want to delete this message?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You can only delete your own messages.'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text("Delete"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> deleteMessage(String documentId, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message deleted successfully.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    try {
      await db.collection("messages").doc(documentId).delete();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete message.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
