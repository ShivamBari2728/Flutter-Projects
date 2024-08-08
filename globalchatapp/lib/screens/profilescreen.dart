// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:globalchatapp/provider/userProvider.dart';
import 'package:provider/provider.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  // Map<String, dynamic>? data = {};
  // var db = FirebaseFirestore.instance;
  // var user = FirebaseAuth.instance.currentUser;

  // void fetchdata() async {
  //   await db.collection("users").doc(user!.uid).get().then((datasnapshot) {
  //     data = datasnapshot.data();
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var userproviderdata = Provider.of<userProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(
                      image: NetworkImage(
                          "https://static-00.iconduck.com/assets.00/profile-circle-icon-512x512-zxne30hp.png")),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name : ${userproviderdata.data?["name"] ?? ""} "),
                  Text("Email : ${userproviderdata.data?["email"] ?? ""} "),
                  Text("Country : ${userproviderdata.data?["country"] ?? ""} "),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
