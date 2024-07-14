import 'package:flutter/material.dart';

class addMoneybutton extends StatelessWidget {
  void Function() addMoneyFunction;  //refrence variable of type function.

   addMoneybutton({super.key,required this.addMoneyFunction});

  @override
  Widget build(BuildContext context) {
    return Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 122, 145, 248),
                        minimumSize: Size(double.infinity, 0),
                      ),
                      onPressed: addMoneyFunction,
                      child: Text("Add Money")));
  }
}