import 'package:firebase_chat/screens/ChatScren.dart';
import 'package:firebase_chat/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your applica
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/chat": (context) => const ChatScreen(),
        "/": (context) => HomeScreen()
      },
      initialRoute: "/",
    );
  }
}
