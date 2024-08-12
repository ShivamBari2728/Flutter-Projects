// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, body_might_complete_normally_nullable, unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:globalchatapp/controllers/signupcontroller.dart';
import 'package:globalchatapp/screens/homescreen.dart';
import 'package:globalchatapp/screens/loginscreen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  var userForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: userForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(image: NetworkImage("https://i.postimg.cc/PJqwdZLG/globchat-cion-removebg-preview.png")),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email required";
                    }
                  },
                  controller: email,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password required";
                    }
                    return null;
                  },
                  controller: password,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name required";
                    }
                  },
                  controller: name,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "country required";
                    }
                  },
                  controller: country,
                  decoration: InputDecoration(hintText: "Country"),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (userForm.currentState!.validate()) {
                        Signupcontroller.createAccount(
                            context: context,
                            email: email.text,
                            password: password.text,
                            country: country.text,
                            name: name.text);
                      }
                      ;
                    },
                    child: Text("Create Account"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
