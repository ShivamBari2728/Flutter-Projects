// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfactapp/provider/themeprovider.dart';
import 'package:funfactapp/screens/settingscreen.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List facts = [];
  bool isLoading = true;

  Future<void> getData() async {
    var dio = Dio();
    try {
      Response response = await dio.get(
          "https://raw.githubusercontent.com/ShivamBari2728/testing_data/main/factsdata.json");
      isLoading = false;
      facts = jsonDecode(response.data);

      setState(() {});
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<Themeprovider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Fun facts"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Settingscreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(Icons.settings_rounded),
            ),
          )
        ],
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
        child: Column(
          children: [
            Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PageView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: facts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                  child: Text(
                                facts[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 50),
                              )),
                            ),
                          );
                        })),
            Text("Swip up for more facts!")
          ],
        ),
      ),
    );
  }
}
