// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
            Center(
              child: Image(
                image: NetworkImage(
                    "https://cdn.dribbble.com/users/147557/screenshots/3635793/desk.gif"),
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
