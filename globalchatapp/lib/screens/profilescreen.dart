import 'package:flutter/material.dart';
import 'package:globalchatapp/provider/userProvider.dart';
import 'package:provider/provider.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    var userproviderdata = Provider.of<userProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5, // Shadow effect
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Rectangle shape
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Icon(Icons.person,size: 80,)
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Name: ${userproviderdata.data?["name"] ?? ""}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Email: ${userproviderdata.data?["email"] ?? ""}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Country: ${userproviderdata.data?["country"] ?? ""}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
