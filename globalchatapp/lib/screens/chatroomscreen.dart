// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalchatapp/provider/themeprovider.dart';
import 'package:globalchatapp/provider/userProvider.dart';
import 'package:globalchatapp/screens/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Chatroomscreen extends StatefulWidget {
  var chatroonname;
  var chatroomid;

  Chatroomscreen(
      {super.key, required this.chatroomid, required this.chatroonname});

  @override
  State<Chatroomscreen> createState() => _ChatroomscreenState();
}

class _ChatroomscreenState extends State<Chatroomscreen> {
  var db = FirebaseFirestore.instance;
  TextEditingController messagetext = TextEditingController();
  Future<void> sendMessage() async {
    if (messagetext.text.isEmpty) {
      return;
    } else {
      Map<String, dynamic> data = {
        "message": messagetext.text,
        "sender_name":
            Provider.of<userProvider>(context, listen: false).data?["name"] ??
                "",
        "chatroom_id": widget.chatroomid,
        "sender_id":
            Provider.of<userProvider>(context, listen: false).data?["userID"] ??
                "",
        "time": FieldValue.serverTimestamp()
      };
      messagetext.text = "";
      try {
        await db.collection("messages").add(data);
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  Future<void> onDelete() async {
    await db
        .collection("chatrooms")
        .doc(widget.chatroomid)
        .get()
        .then((doc) async {
      if (doc.exists) {
        print("owner id: ${doc['Chat_ownerId']}");

        final userId =
            Provider.of<userProvider>(context, listen: false).data?["userID"] ??
                "";
        final ownerId = doc["Chat_ownerId"] ?? "";

        if (userId is String && ownerId is String && userId == ownerId) {
          await db.collection("chatrooms").doc(widget.chatroomid).delete();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Chat deleted sucessfully.',
              ),
              backgroundColor: Colors.green,
              duration: Duration(
                  seconds:
                      2), // Optional: duration the SnackBar will be visible
            ),
          );

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Homescreen();
          }));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Only Chat Owner can delete the chat.',
              ),
              backgroundColor: Colors.red,
              duration: Duration(
                  seconds:
                      2), // Optional: duration the SnackBar will be visible
            ),
          );
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeprovider = Provider.of<Themeprovider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 1) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Delete?"),
                      content:
                          Text("Are you Sure you want to delete this user?"),
                      actions: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        InkWell(
                            onTap: () {
                              onDelete();
                              setState(() {});
                            },
                            child: Text("Confirm"))
                      ],
                    );
                  });
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(value: 1, child: Text("Delete")),
            ];
          })
        ],
        title: Row(
          children: [
            Text(widget.chatroonname),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            //StreamBuilder checks for changes in data base and refresh it fro new events. and fetch data
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: themeprovider.isDarkModeOn
                  ? Color.fromARGB(255, 34, 34, 34)
                  : Color.fromARGB(255, 226, 226,
                      226), // Light background color for the message bubble
              borderRadius: BorderRadius.circular(10), // Rounded corners
              //border: Border.all(color: Colors.blue, width: 1)
            ),
            child: StreamBuilder(
              stream: db
                  .collection("messages")
                  .where("chatroom_id", isEqualTo: widget.chatroomid)
                  .orderBy("time", descending: true)
                  .snapshots(), //conditionally quaring the data base.
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text("Some error occured");
                }
                var allmessages = snapshot.data?.docs ?? [];
                if (allmessages.length < 1) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mark_chat_unread_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Be the first to start chat"),
                    ],
                  );
                }
                return ListView.builder(
                    reverse: true,
                    itemCount: allmessages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final time = allmessages[index]["time"];
                      String formattedTime = "";

                      if (time != null) {
                        // Safely cast and format only if time is not null
                        final dateTime = (time as Timestamp).toDate();
                        formattedTime = DateFormat('hh:mm a').format(dateTime);
                      }
                      bool isSender = allmessages[index]["sender_id"] ==
                          Provider.of<userProvider>(context, listen: false)
                              .data!["userID"];

                      return Column(
                        crossAxisAlignment: isSender
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: isSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(allmessages[index]["sender_name"],
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSender
                                        ? Colors.blue[300]
                                        : Colors.green[300],
                                  )),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: isSender
                                        ? Colors.blue
                                        : themeprovider.isDarkModeOn
                                            ? const Color.fromARGB(
                                                255, 51, 51, 51)
                                            : Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  allmessages[index]["message"],
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Text(
                                formattedTime,
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    });
              },
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              color: Colors.grey[1000],
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: messagetext,
                        autofocus: false,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Message"),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: sendMessage,
                      child: Icon(
                        Icons.send_rounded,
                        size: 35,
                      )),
                  SizedBox(width: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
