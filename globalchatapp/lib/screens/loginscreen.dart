// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:globalchatapp/controllers/logincontroller.dart';
import 'package:globalchatapp/screens/signupscreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var userForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(""), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: userForm,
          child: Column(
            children: [
              SizedBox(height: 100,),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("assets/images/image.png"),),
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
                height: 20,
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
                height: 30,
              ),
              ElevatedButton(
                // style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 0, 247, 255)),
                  onPressed: () {
                    if (userForm.currentState!.validate()) {
                      Logincontroller.loginAccount(
                          context: context,
                          email: email.text,
                          password: password.text);
                    }
                    ;
                  },
                  child: Text("Login")),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Dont have an account?"),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Signupscreen();
                        }));
                      },
                      child: Text(
                        "Sign up?",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
