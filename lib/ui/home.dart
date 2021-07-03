import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intervent/ui/authentication.dart';
import 'package:intervent/ui/chats.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF9EC2B8),
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Something went wrong..."));
            } else if (snapshot.hasData) {
              return Chats();
            }

            return Authentication();
          },
        ),
      ),
    );
  }
}