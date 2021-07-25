import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {Key? key,
      required this.username,
      required this.text,
      required this.date})
      : super(key: key);

  final String username;
  final String text;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 35,
                height: 35,
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    username.substring(0, 1),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          username,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, height: 1.5),
                      text: text,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 20,
        )
      ],
    );
  }
}
