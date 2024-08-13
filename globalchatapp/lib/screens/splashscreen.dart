// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:globalchatapp/provider/userProvider.dart';
import 'package:globalchatapp/screens/homescreen.dart';
import 'package:globalchatapp/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  var userdata = FirebaseAuth.instance.currentUser;
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      if (userdata == null) {
        sendtologinpage();
      } else {
        sendtohomescreen();
      }
    });

    super.initState();
  }

  void sendtologinpage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Loginscreen();
    }));
  }

  void sendtohomescreen() {
    Provider.of<userProvider>(context, listen: false).fetchdata();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Homescreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
              height: 100,
              width: 100,
              child: Image(
                  image: NetworkImage(
                      "https://i.postimg.cc/PJqwdZLG/globchat-cion-removebg-preview.png")))),
    );
  }
}
