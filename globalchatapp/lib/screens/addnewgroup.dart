// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalchatapp/controllers/addgroupcontroller.dart';

class Addnewgroup extends StatefulWidget {
  var createrName;
  var createrID;
  Addnewgroup({super.key, required this.createrName, required this.createrID});

  @override
  State<Addnewgroup> createState() => _AddnewgroupState();
}

class _AddnewgroupState extends State<Addnewgroup> {
  var db = FirebaseFirestore.instance;
  var groupForm = GlobalKey<FormState>();

  TextEditingController chatname = TextEditingController();
  TextEditingController chatdesc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 300,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: groupForm,
            child: Column(
              children: [
                Icon(Icons.minimize_rounded),
                // Center(
                //     child: Text(
                //   "Create Chat",
                //   style: TextStyle(
                //     fontSize: 16,
                //   ),
                // )),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Chat name required";
                    }
                    return null;
                  },
                  controller: chatname,
                  decoration: InputDecoration(hintText: "Chat Name"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Chat description required";
                    }
                    return null;
                  },
                  controller: chatdesc,
                  decoration: InputDecoration(hintText: "Chat description"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      if (groupForm.currentState!.validate()) {
                        Addgroupcontroller().createChat(
                          chatname: chatname.text,
                          chatdesc: chatdesc.text,
                          createrID: widget.createrID,
                          createrName: widget.createrName,
                        );
                        Navigator.pop(context, true);
                      }
                    },
                    child: Text(
                      "Create Chat",
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
