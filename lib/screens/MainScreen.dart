import 'package:firebase_chat/models/entry.dart';
import 'package:firebase_chat/screens/ChatScren.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  Entry entry = new Entry();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "🔥 firestore chat 💬",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: "Enter "),
                TextSpan(
                    text: "room_id",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.grey.shade400,
                    )),
                TextSpan(text: " and "),
                TextSpan(
                    text: "username",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.grey.shade400,
                    )),
                TextSpan(text: " to join. "),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 1, color: Colors.grey),
                            top: BorderSide(width: 1, color: Colors.grey),
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              this.entry.room_id = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "room_id"),
                        ))),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 1, color: Colors.grey),
                            top: BorderSide(width: 1, color: Colors.grey),
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              this.entry.username = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "username"),
                        ))),
                TextButton(
                  onPressed: () {
                    if (this.entry.isValid()) {
                      Navigator.pushNamed(context, "/chat",
                          arguments: this.entry);
                    }
                  },
                  child: Text(
                    "Join",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(90, 50)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.purpleAccent),
                  ),
                )
              ],
            ),
          ),
          entry.username != "" && entry.room_id != ""
              ? Text(
                  "UN: ${entry.username} - RID: ${entry.room_id}",
                )
              : Container()
        ]),
      ),
    );
  }
}
