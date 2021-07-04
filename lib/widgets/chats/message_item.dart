import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  bool isMe;
  String body;

  MessageItem(this.isMe, this.body);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        margin: isMe
            ? EdgeInsets.only(top: 8, bottom: 8, left: 80, right: 10)
            : EdgeInsets.only(top: 8, bottom: 8, right: 80, left: 10),
        decoration: BoxDecoration(
          color: isMe ? Color(0xFFFFFFFF) : Color(0xFF9EC2B8),
          borderRadius: isMe
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
          body,
          style: TextStyle(
            color: isMe ? Colors.black : Colors.white
          ),
        )
    );
  }
}
