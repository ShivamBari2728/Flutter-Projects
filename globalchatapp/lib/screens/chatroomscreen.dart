// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalchatapp/provider/userProvider.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroonname),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            //StreamBuilder checks for changes in data base and refresh it fro new events. and fetch data
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 34, 34,
                  34), // Light background color for the message bubble
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
                if(allmessages.length <1){
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mark_chat_unread_rounded),
                      SizedBox(width: 10,),
                      Text("Be the first to start chat"),
                    ],
                  );
                }
                return ListView.builder(
                    reverse: true,
                    itemCount: allmessages.length,
                    itemBuilder: (BuildContext context, int index) {
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
                                    color:
                                        isSender ? Colors.blue : const Color.fromARGB(255, 51, 51, 51),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  allmessages[index]["message"],
                                ),
                              ),
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
                        autofocus: true,
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
