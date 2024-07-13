import 'package:flutter/material.dart';

class Myinfo extends StatelessWidget {
  const Myinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row( 
                children:  [
                  Image.asset("assets/images/profile.png",height: 65),
                SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Shivam Bari",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
                      Text("Flutter app",style: TextStyle(color: Colors.white)),
                      Text("github.com/ShivamBari2728",style: TextStyle(color: Colors.white))
                    ],
                  )
                ],
              );
  }
}