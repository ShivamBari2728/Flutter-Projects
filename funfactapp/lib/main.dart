import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfactapp/provider/themeprovider.dart';
import 'package:funfactapp/screens/homescreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Themeprovider(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<Themeprovider>(context);
    return MaterialApp(
      theme: themeprovider.isDarkModeOn
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      home: Homescreen(),
    );
  }
}
