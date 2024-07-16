// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';

class Addtodo extends StatefulWidget {
  void Function({required String todotext}) sendtext;

  Addtodo({super.key, required this.sendtext});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  TextEditingController texteditor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          autofocus: true, //open keyboard automatically.
          controller: texteditor,
          decoration: InputDecoration(
              icon: Icon(Icons.add_task_rounded), hintText: "Add task.."),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              if (texteditor.text != "") {
                widget.sendtext(todotext: texteditor.text);
              }
              texteditor.text = '';
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 31, 79, 151),
            ))
      ],
    );
  }
}
