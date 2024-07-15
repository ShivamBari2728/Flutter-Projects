
import 'package:flutter/material.dart';
import 'package:todo_app/main_screen.dart';

void main()
{
  // ignore: prefer_const_constructors
  runApp(todo_app());
}
class todo_app extends StatefulWidget {
  const todo_app({super.key});

  @override
  State<todo_app> createState() => _todo_appState();
}

class _todo_appState extends State<todo_app> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: MainScreen(),
      
      )
    ;
  }
}