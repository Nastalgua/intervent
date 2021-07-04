import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intervent/models/message.dart';
import 'package:intervent/router/route_constants.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intervent/widgets/chats/message_item.dart';

class Messages extends StatefulWidget {
  final String id;

  Messages({Key? key, required this.id}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final user = FirebaseAuth.instance.currentUser!;
  final myController = TextEditingController();

  late DocumentReference _chatRef;
  var _chatStream;

  String message = "";

  void leaveChat(context) {
    Navigator.of(context).pushNamed(HomeViewRoute);
  }

  void sendMessage(List<dynamic> prevMessages, BuildContext context) {
    FocusScope.of(context).unfocus();
    final Message msg = new Message(userId: user.uid, body: this.message);

    _chatRef.update({ 'messages' : [...prevMessages, msg.toJSON()]});

    myController.clear();
  }

  @override
  void initState() { 
    super.initState();
    
    _chatRef = FirebaseFirestore.instance
      .collection('chats')
      .doc(widget.id);
    
    _chatStream = _chatRef.snapshots();
  }

  //header
  Widget _header(BuildContext context, String name) {
    return SimpleShadow(
      child: Container(
        padding: EdgeInsets.only(top: 18, right: 12, left: 12),
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.95),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(29),
                bottomRight: Radius.circular(29))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              //exit icon button
              Padding(
                padding: EdgeInsets.all(0),
                child: IconButton(
                  onPressed: () { 
                    leaveChat(context);
                  },
                  icon: new SvgPicture.asset("assets/icons/leave_chat.svg"),
                ),
              ),

              //name
              Padding(
                padding: EdgeInsets.all(0),
                child: RichText(
                  text: TextSpan(
                    text: name,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      opacity: 0.25,
      color: Color(0xFFD7D7D7),
      offset: Offset(0, 4),
      sigma: 4,
    );
  }

  //body
  Widget _body(BuildContext context, List<dynamic> messages) {
    //color already given from the build method
    //stores the messages in an overflow box
    return Container(
        color: Color(0xFFEEEEEE),
        //remaining height left after giving space to header and footer
        height: MediaQuery.of(context).size.height * 0.76,
        child: ListView(
          children: messages.map((msg) {
            return MessageItem(Message.fromJSON(msg));
          }).toList(),
        )
      );
  }

  //footer
  Widget _footerBar(BuildContext context, List<dynamic> messages) {
    return SimpleShadow(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.95),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(29), topRight: Radius.circular(29))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, //push them to the ends
            children: [
              //enter into tb
              Flexible(
                child: TextField(
                  controller: myController,
                  style: TextStyle(
                      fontSize: 16.0, height: 1.5, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Send a message...',
                  ),
                  onChanged: (value) {
                    setState(() {
                      this.message = value;
                    });
                  },
                ),
              ),
              //send message button
              IconButton(
                onPressed: () {
                  sendMessage(messages, context);
                },
                icon: new SvgPicture.asset("assets/icons/send_message.svg"),
              ),
            ],
          ),
        ),
      ),
      opacity: 0.25,
      color: Color(0xFFCBCBCB),
      offset: Offset(0, -4),
      sigma: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _chatStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data?['messages'];
        String nameToUse = snapshot.data?['userOne'];
       
        if (nameToUse == user.displayName) {
          nameToUse = snapshot.data?['userTwo'];
        }

        return Scaffold(
          body: Container(
              //bg color
              color: Color(0xF7F7F7),
              child: Column(
                children: [
                  _header(context, nameToUse),
                  Expanded(child: _body(context, messages)),
                  _footerBar(context, messages),  
                ],
              )
            )
        );
      },
    );
  }
}
