// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Adduser extends StatefulWidget {
  int newindex; //newindex is the length of list fetched in privious getData().
  Adduser({super.key, required this.newindex});

  @override
  State<Adduser> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  TextEditingController nametext = TextEditingController();
  TextEditingController agetext = TextEditingController();
  TextEditingController jobtext = TextEditingController();
  Future<void> addData() async {
    var dio = Dio();
    try {
      Map<String, dynamic> data = {
        "age": agetext.text,
        "job": jobtext.text,
        "profile":
            "https://media0.giphy.com/avatars/ashrafomar__/zo7sIcJiW5EH.gif",
        "username": nametext.text
      };
      await dio.patch(
          "https://apptesting-a9f77-default-rtdb.firebaseio.com/users/${widget.newindex}.json",
          data: data);
      Navigator.pop(context, "refresh");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var addForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: addForm,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Empty field";
                  } else {
                    return null;
                  }
                },
                controller: nametext,
                decoration: InputDecoration(label: Text("Name")),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty field";
                  } else if (int.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  //filters the non numeric input like a . , etc.
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: agetext,
                decoration: InputDecoration(label: Text("Age")),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty field";
                  } else {
                    return null;
                  }
                },
                controller: jobtext,
                decoration: InputDecoration(label: Text("Job Profile")),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (addForm.currentState!.validate()) {
                    addData();
                  }
                },
                child: Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
