// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Draweritems extends StatelessWidget {
  const Draweritems({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 58, 58, 58),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              height: 200,
              color: Color.fromARGB(255, 56, 149, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Image.asset(
                    'assets/images/image.png',
                    height: 125,
                  ),
                  Text(
                    "Listify",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("https://github.com/ShivamBari2728"));
              },
              leading: Icon(Icons.account_circle),
              title: Text("About Me"),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("https://t.me/shivamtheskywalker"));
              },
              leading: Icon(Icons.sms),
              title: Text("Contact Me"),
            )
          ],
        ),
      ),
    );
  }
}
