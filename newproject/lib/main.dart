// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newproject/myinfo.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: const Text(
              "Hello Flutter",
              style: TextStyle(fontFamily: "Poppins"),
            ),
          ),
          body: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(20),
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 162, 168, 255)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Welcome to my flutter app"),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/flutter_logo.png",
                      height: 100,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "this app is developed by Shivam",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    // height: 50,

                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 85, 84, 84),
                        borderRadius: BorderRadius.circular(20)),
                    child: Myinfo() //made a custom widget
                    )
              ],
            ),
          )),
    );
  }
}
