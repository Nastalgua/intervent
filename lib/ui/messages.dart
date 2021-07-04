import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intervent/widgets/chats/message_item.dart';

class Messages extends StatelessWidget {
  //Messages ({ Key? key }) : super(key: key);
  String to;
  @override
  var temp = [
    [false, "penis"],
    [true, "pp"],
    [false, "penis"],
    [false, "penis"],
    [true, "pp"],
    [false, "penis"],
    [true, "pp"],
    [true, "pp"],
  ];
  //idk what to do w these lol
  void leaveChat() {}

  void sendMessage() {}

  Messages(this.to);

  //header
  Widget _header(BuildContext context) {
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
                  onPressed: null,
                  icon: new SvgPicture.asset("assets/icons/leave_chat.svg"),
                ),
              ),

              //name
              Padding(
                padding: EdgeInsets.all(0),
                child: RichText(
                  text: TextSpan(
                    text: this.to,
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
  Widget _body(BuildContext context) {
    //color already given from the build method
    //stores the messages in an overflow box
    return Container(
        //remaining height left after giving space to header and footer
        height: MediaQuery.of(context).size.height * 0.76,
        child: ListView(
          children: [
            MessageItem(false, "pp"),
            MessageItem(true, "pp"),
            MessageItem(false, "pp"),
            MessageItem(true, "pp"),
            MessageItem(true, "ppaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
            MessageItem(false, "pp"),
            MessageItem(false, "pp"),
            MessageItem(false, "pp"),
            MessageItem(false, "pp"),
            MessageItem(false, "pp"),
            MessageItem(false, "pp"),
          ],
        )
      );
  }

  //footer
  Widget _footerBar(BuildContext context) {
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
                  style: TextStyle(
                      fontSize: 16.0, height: .5, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Send a message...',
                  ),
                ),
              ),
              //send message button
              IconButton(
                onPressed: null,
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

  Widget build(BuildContext context) {
    return Material(
      child: Container(
          //bg color
          color: Color(0xF7F7F7),
          child: Column(
            children: [
              //header - body - footer
              _header(context),
              _body(context),
              _footerBar(context),
            ],
          )),
    );
  }
}
