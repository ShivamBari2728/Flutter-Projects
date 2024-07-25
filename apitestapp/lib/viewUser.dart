// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Viewuser extends StatefulWidget {
  Map<String, dynamic> userstoredData = {};
  int index;
  //int index = 0;
  Viewuser({super.key, required this.userstoredData, required this.index});

  @override
  State<Viewuser> createState() => _ViewuserState();
}

class _ViewuserState extends State<Viewuser> {
  Future<void> onDelete() async {
    var dio = Dio();
    Navigator.pop(context);
    try {
      await dio.delete(
          "https://apptesting-a9f77-default-rtdb.firebaseio.com/users/${widget.index}.json");
      Navigator.pop(context, true); //sending data back to Navigator.push.
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.userstoredData["username"]}"),
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 1) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Delete?"),
                      content:
                          Text("Are you Sure you want to delete this user?"),
                      actions: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        InkWell(
                            onTap: () {
                              onDelete();
                              setState(() {});
                            },
                            child: Text("Confirm"))
                      ],
                    );
                  });
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(value: 1, child: Text("Delete")),
            ];
          })
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.userstoredData["profile"]),
              radius: 60,
            ),
            SizedBox(
              height: 30,
            ),
            Text("Name : ${widget.userstoredData["username"]}"),
            SizedBox(
              height: 10,
            ),
            Text("Age : ${widget.userstoredData["age"]}"),
            SizedBox(
              height: 10,
            ),
            Text("Job Profile : ${widget.userstoredData["job"]}")
          ],
        ),
      ),
    );
  }
}
