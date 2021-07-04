import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intervent/models/message.dart';

class MessageItem extends StatelessWidget {
  Message msg;
  final user = FirebaseAuth.instance.currentUser!;

  MessageItem(this.msg);

  bool isMe() {
    return user.uid == this.msg.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        margin: this.isMe()
            ? EdgeInsets.only(top: 8, bottom: 8, left: 80, right: 10)
            : EdgeInsets.only(top: 8, bottom: 8, right: 80, left: 10),
        decoration: BoxDecoration(
          color: this.isMe() ? Color(0xFFFFFFFF) : Color(0xFF9EC2B8),
          borderRadius: this.isMe()
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          )
                        : BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )
        ),
        child: Text(
          this.msg.body,
          style: TextStyle(
            color: this.isMe() ? Colors.black : Colors.white
          ),
        )
    );
  }
}
