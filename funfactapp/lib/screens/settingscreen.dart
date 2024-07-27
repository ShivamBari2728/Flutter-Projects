// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfactapp/provider/themeprovider.dart';
import 'package:provider/provider.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  // bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<Themeprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: themeprovider.isDarkModeOn
                ? DecorationImage(
                    image: NetworkImage(
                        "https://miro.medium.com/v2/resize:fit:1024/1*pX7GpvFZ60eeX6mfmOFvSA.jpeg"),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: NetworkImage(
                        "https://img.freepik.com/premium-photo/card-template-curve-gradient-abstract-background_608068-9787.jpg"),
                    fit: BoxFit.cover,
                  )),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Dark Theme",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 195),
                  Switch(
                      value: themeprovider.isDarkModeOn,
                      onChanged: (value) {
                        themeprovider.updateData(data: value);
                        setState(() {});
                      }),
                  // Padding(
                  //   padding: const EdgeInsets.all(5),
                  //   child: Text(isChecked ? "Dark mode" : "Light mode"),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
