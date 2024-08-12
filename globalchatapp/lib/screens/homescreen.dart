// ignore_for_file: prefer_const_constructors, unused_import

// import 'dart:nativewrappers/_internal/vm/lib/mirrors_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchatapp/provider/themeprovider.dart';
import 'package:globalchatapp/provider/userProvider.dart';
import 'package:globalchatapp/screens/addnewgroup.dart';
import 'package:globalchatapp/screens/chatroomscreen.dart';
import 'package:globalchatapp/screens/loginscreen.dart';
import 'package:globalchatapp/screens/profilescreen.dart';
import 'package:globalchatapp/screens/settingscreen.dart';
import 'package:globalchatapp/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var userdata = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  List<String> chatroomids = [];
  List<Map<String, dynamic>> chatroomslist = [];
  void getChatrooms() {
    db.collection("chatrooms").get().then((datasnapshot) {
      for (var singlechatroomdata in datasnapshot.docs) {
        chatroomslist.add(singlechatroomdata.data());
        chatroomids.add(singlechatroomdata.id);
        foundchatroomslist = chatroomslist;
        foundchatroomids = chatroomids;
        setState(() {});
      }
    });
  }

  List<Map<String, dynamic>> foundchatroomslist = [];
  List<String> foundchatroomids = [];
  @override
  void initState() {
    getChatrooms();
    foundchatroomslist = chatroomslist;
    foundchatroomids = chatroomids;
    super.initState();
  }

  Future<void> refresh() async {
    chatroomslist = [];
    chatroomids = [];
    foundchatroomslist = [];
    foundchatroomids = [];
    getChatrooms();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<Themeprovider>(context);
    var userproviderdata = Provider.of<userProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Addnewgroup(
                  createrName: userproviderdata.data?["name"] ?? "",
                  createrID: userproviderdata.data?["userID"] ?? "",
                );
              }).then((value) {
            if (value) {
              refresh();
            }
          });
        },
        child: Icon(Icons.group_add_rounded),
      ),
      appBar: AppBar(
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 45,
              width: 45,
              child: Image(image: NetworkImage("https://i.postimg.cc/PJqwdZLG/globchat-cion-removebg-preview.png") )),SizedBox(width: 10,),
            Text("Globe Chat",style: TextStyle(fontWeight: FontWeight.bold),)],
        ),
        

        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Settingscreen();
                  }));
                },
                child: Icon(Icons.settings)),
          )
        ],
        centerTitle: true,
        // backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 150,
              width: 200,
              child: Image(
                image: NetworkImage(
                    "https://i.postimg.cc/PJqwdZLG/globchat-cion-removebg-preview.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Profilescreen();
                }));
              },
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              subtitle: Text(userproviderdata.data?["email"] ?? ""),
              title: Text(userproviderdata.data?["name"] ?? ""),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("https://github.com/ShivamBari2728"));
              },
              leading: Icon(Icons.account_circle),
              title: Text("About Developer"),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("https://t.me/shivamtheskywalker"));
              },
              leading: Icon(Icons.sms),
              title: Text("Contact Developer"),
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
            ),
            SizedBox(
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
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: themeprovider.isDarkModeOn
                    ? BoxDecoration()
                    : BoxDecoration(
                        color:
                            Colors.white, // Background color of the container
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 5, // Spread radius
                            blurRadius: 7, // Blur radius
                            offset: Offset(0, 0), // Shadow offset
                          ),
                        ],
                      ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: TextField(
                    onChanged: (value) => runFilter(value),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: Icon(Icons.search_rounded),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        border: themeprovider.isDarkModeOn
                            ? OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(),
                              )
                            : InputBorder.none),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: foundchatroomslist.length,
                  itemBuilder: (BuildContext context, int index) {
                    var Chatname = foundchatroomslist[index]["Chat_Name"];
                    var Chatdesc = foundchatroomslist[index]["Chat_desc"];
                    return ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Chatroomscreen(
                            chatroomid: foundchatroomids[index],
                            chatroonname: Chatname,
                          );
                        }));
                      },
                      leading: CircleAvatar(
                        child: Icon(Icons.chat_rounded)
                      ),
                      subtitle: Text(Chatdesc),
                      title: Text(Chatname),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

//filtering list tiles
  void runFilter(String enteredKeyWord) {
    List<Map<String, dynamic>> filteredChatrooms = [];
    List<String> filteredChatroomIds = [];

    if (enteredKeyWord.isEmpty) {
      filteredChatrooms = chatroomslist;
      filteredChatroomIds = chatroomids;
    } else {
      for (int i = 0; i < chatroomslist.length; i++) {
        var chatroom = chatroomslist[i];
        var chatroomId = chatroomids[i];

        String chatName = chatroom["Chat_Name"];
        String lowerCaseChatName = chatName.toLowerCase();
        String lowerCaseEnteredKeyWord = enteredKeyWord.toLowerCase();

        if (lowerCaseChatName.contains(lowerCaseEnteredKeyWord)) {
          filteredChatrooms.add(chatroom);
          filteredChatroomIds.add(chatroomId);
        }
      }
    }

    setState(() {
      foundchatroomslist = filteredChatrooms;
      foundchatroomids = filteredChatroomIds;
    });
  }
}
