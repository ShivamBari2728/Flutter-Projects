// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Adduser extends StatefulWidget {
  int newindex;
  Adduser({super.key,required this.newindex});

  @override
  State<Adduser> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  TextEditingController nametext = TextEditingController();
  TextEditingController agetext = TextEditingController();
  TextEditingController jobtext = TextEditingController();
  Future<void> addData()async
  {
    var dio = Dio();
    try {
      Map<String,dynamic> data = {
         "age": agetext.text,
        "job": jobtext.text,
        "profile": "",
        "username": nametext.text

      };
      await dio.patch("https://apptesting-a9f77-default-rtdb.firebaseio.com/users/${widget.newindex}.json",data: data);
      Navigator.pop(context,"refresh");
      
    } catch (e) {
      print(e);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add User"),),
     
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
         
          children: [
            TextField( 
              controller: nametext,
              decoration: InputDecoration(
                label: Text("Name")
              ),
            ),
            TextField(
              controller: agetext,
              decoration: InputDecoration(
                label: Text("Age")
              ),
            ),
            TextField(
              controller: jobtext,
              decoration: InputDecoration(
                label: Text("Job Profile")
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: addData, child: Text("Add"),
            
            )
            
          ],
        ),
      ),

    );
  }
}