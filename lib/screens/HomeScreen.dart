import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';

class HomeScreen extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Icon(
                  Icons.warning,
                  color: Colors.redAccent.shade700,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Something went wrong",
                    style: TextStyle(color: Colors.redAccent.shade700),
                  ),
                ),
                Text(
                  snapshot.error.toString(),
                )
              ]));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MainScreen();
        }

        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [CircularProgressIndicator(), Text("Loading...")],
          ),
        );
      },
    ));
  }
}
