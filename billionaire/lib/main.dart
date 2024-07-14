// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:billionaire/addmoneybutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  double balance = 0;

  void addMoney() async {
    setState(() {
      balance = balance + 500;
    });

    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', balance);
  }

  @override
  void initState() {
    loadBalance();
    super.initState();
  }

  void loadBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      balance = prefs.getDouble('balance') ?? 0;
      // "??(null aware operator)" is it used as a fallback value as for the first time the value will be null.
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Billionaire app"),
          backgroundColor: Color.fromARGB(255, 50, 52, 53),
          centerTitle: true,
        ),
        body: Container(
          color: Color.fromARGB(255, 85, 88, 124),
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("bank balance"),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${NumberFormat.simpleCurrency().format(balance)}"),
                    ],
                  )),
              addMoneybutton(addMoneyFunction: addMoney)
              //passing the function to the refrence variable.
            ],
          ),
        ),
      ),
    );
  }
}
