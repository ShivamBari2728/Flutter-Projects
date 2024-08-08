// ignore_for_file: prefer_const_constructors, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchatapp/provider/userProvider.dart';
import 'package:globalchatapp/screens/chatroomscreen.dart';
import 'package:globalchatapp/screens/loginscreen.dart';
import 'package:globalchatapp/screens/profilescreen.dart';
import 'package:globalchatapp/screens/splashscreen.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var userdata = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  List<Map<String,dynamic>> chatroomslist=[];
  List<String> chatroomids=[];
  void getChatrooms(){
   db.collection("chatrooms").get().then((datasnapshot){

    for(var singlechatroomdata in datasnapshot.docs)
    {
        chatroomslist.add(singlechatroomdata.data());
        chatroomids.add(singlechatroomdata.id);
        setState(() {
          
        });
    }
   });
  }
@override
  void initState() {
    getChatrooms();
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
    var userproviderdata = Provider.of<userProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
        // backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return Profilescreen();
                }));
              },
              leading: CircleAvatar(child: Icon(Icons.person),),
              subtitle: Text(userproviderdata.data?["email"]?? ""),
              title: Text(userproviderdata.data?["name"] ?? ""),
            ),SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                SnackBar sucesssnackbar = SnackBar(
                  content: Text(
                    "Logged out",
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(sucesssnackbar);
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return Splashscreen();
                }), (route) => false);

//                 (route) => false:

// This is the predicate function that determines which routes should be kept in the navigation stack.
// By returning false, it tells the navigator to remove all the previous routes.
              },
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            ),SizedBox(
              height: 10,
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) {
            //       return Profilescreen();
            //     }));
            //   },
            //   leading: Icon(Icons.person_outlined),
            //   title: Text("Profile"),
            // )
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: chatroomslist.length,
        itemBuilder: (BuildContext context,int index){
          var Chatname=chatroomslist[index]["Chat_Name"];
          var Chatdesc = chatroomslist[index]["Chat_desc"];
        return ListTile( 
          onTap: (){
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return Chatroomscreen(
                    chatroomid: chatroomids[index],
                    chatroonname: Chatname,
                  );
                }));
          },
          leading: CircleAvatar(child: Text(Chatname[0]),),
          subtitle: Text(Chatdesc),
          title: Text(Chatname),);
      }),
    );
  }
}
