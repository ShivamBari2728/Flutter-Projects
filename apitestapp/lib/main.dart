import 'package:apitestapp/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(Apitest());
}
class Apitest extends StatefulWidget {
  const Apitest({super.key});

  @override
  State<Apitest> createState() => _ApitestState();
}

class _ApitestState extends State<Apitest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Homescreen(),
    );
  }
}