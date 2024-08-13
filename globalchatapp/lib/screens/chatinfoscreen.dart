import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chatinfoscreen extends StatefulWidget {
  final String chatroomname;
  final String chatroomid;
  final String chatrom_decs;

  Chatinfoscreen({
    super.key,
    required this.chatroomname,
    required this.chatroomid,
    required this.chatrom_decs,
  });

  @override
  State<Chatinfoscreen> createState() => _ChatinfoscreenState();
}

class _ChatinfoscreenState extends State<Chatinfoscreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String? chatowner;

  Future<void> fetchChatOwnerName() async {
    try {
      var doc = await db.collection("chatrooms").doc(widget.chatroomid).get();
      if (doc.exists) {
        String? ownerName = doc.data()?['Chat_ownerName'] as String?;
        setState(() {
          chatowner = ownerName;
        });
      }
    } catch (e) {
      print("Error fetching chat owner name: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchChatOwnerName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Info"),
      ),
      body: chatowner == null
          ? Center(child: CircularProgressIndicator())
          : Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
            
              child: Card(
                
                elevation: 5, // Shadow effect
                shape: RoundedRectangleBorder(
                  
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            "https://i.postimg.cc/PJqwdZLG/globchat-cion-removebg-preview.png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Chat Name: ${widget.chatroomname}",
                        style: TextStyle(
                        
                          fontSize: 18,
                          
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Chat Description: ${widget.chatrom_decs}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Chat Owner: ${chatowner}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Colors.blue[700],
                        ),
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
