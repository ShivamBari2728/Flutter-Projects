import 'package:cloud_firestore/cloud_firestore.dart';

class Addgroupcontroller {
  var db = FirebaseFirestore.instance;

  Future<void> createChat(
      {required String chatname,
      required String chatdesc,
      required String createrName,
      required String createrID}) async {
    Map<String, dynamic> chatdata = {
      "Chat_Name": chatname,
      "Chat_desc": chatdesc,
      "Chat_ownerName": createrName,
      "Chat_ownerId": createrID
    };

    try {
      await db.collection("chatrooms").add(chatdata);
    } on Exception catch (e) {
      print(e);
    }
  }
}
