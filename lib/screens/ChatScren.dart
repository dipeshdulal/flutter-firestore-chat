import 'dart:developer';

import "package:intl/intl.dart";

import 'package:firebase_chat/components/ChatBubble.dart';
import 'package:firebase_chat/models/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageControler = TextEditingController();
  Entry _entry = Entry();

  _handleSendMessage() async {
    if (_messageControler.text.trim().isNotEmpty) {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection("messages").doc();

      String oldMessage = _messageControler.text.trim();

      _messageControler.text = "";
      await docRef.set({
        "username": _entry.username,
        "roomId": _entry.room_id,
        "text": oldMessage,
        "createdAt": Timestamp.now()
      });
    }
  }

  _buildMessages(String roomId) {
    log("room-id: " + roomId);
    return Expanded(
      child: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("messages")
              .where("roomId", isEqualTo: roomId)
              .orderBy("createdAt", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              DateFormat format = DateFormat("yyyy-MM-DD HH:mm");
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return ChatBubble(
                    username: document["username"],
                    text: document["text"],
                    date: format
                        .format((document["createdAt"] as Timestamp).toDate()),
                  );
                },
                reverse: true,
              );
            }
            if (snapshot.hasError) {
              log(snapshot.error.toString());
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildInput() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: TextField(
                      controller: _messageControler,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Message...",
                        border: InputBorder.none,
                      ),
                    )),
              ),
              IconButton(
                  onPressed: () => _handleSendMessage(),
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Icon(Icons.send),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _entry = ModalRoute.of(context)?.settings.arguments as Entry;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "🔥 firestore chat 💬",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildMessages(_entry.room_id),
            _buildInput(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageControler.dispose();
    super.dispose();
  }
}
