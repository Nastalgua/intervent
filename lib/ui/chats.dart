import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Chats extends StatefulWidget {
  Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  Widget _header(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.normal,
              color: Colors.white
            )
          ),
          children: <TextSpan>[
            TextSpan(text: "How are you doing,\n"),
            TextSpan(
              text: "Matthew",
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
            TextSpan(text: "?")
          ]
        )
      )
    );
  }

  Widget _mainBody(BuildContext context) {
    return SimpleShadow(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 247, 247, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(29), 
            topRight: Radius.circular(29)
          )
        ),
      ),
      opacity: 0.25,
      color: Color(0xFFCBCBCB),
      offset: Offset(0, -6),
      sigma: 4, 
    );
  }

  Widget _footerBar(BuildContext context) {
    return SimpleShadow(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.95),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(29), 
            topRight: Radius.circular(29)
          )
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
    return Material(
      color: Color(0xFF9EC2B8),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _header(context),
            _mainBody(context),
            _footerBar(context)
          ],
        ),
      ),
    );
  }
}