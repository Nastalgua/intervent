import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intervent/providers/auth_provider.dart';
import 'package:intervent/widgets/chats/tag_bar.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:intervent/widgets/chats/chat_item.dart';


class Chats extends StatefulWidget {
  Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  //temporary
  List users = [
    ["Michaeadadasal", Colors.red, "6/07/2021"],
    ["Ivanadaasda", Colors.blue, "6/09/2021"],
    ["Matthedsadsdasdabsdasbjdabjskaadw", Colors.green, "6/21/2021"],
    ["Matthedsadaadw", Colors.green, "6/21/2021"],
    ["Matthedsadaadw", Colors.green, "6/21/2021"],
    ["Matthedsadaadw", Colors.green, "6/21/2021"],
  ];

  final user = FirebaseAuth.instance.currentUser!;

  Widget _header(BuildContext context) {
    String firstName = user.displayName!.split(" ")[0];

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
              text: firstName,
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
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 247, 247, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(29), 
            topRight: Radius.circular(29)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TagBar(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  scrollDirection: Axis.vertical,
                  children: [
                    ...(users).map((info) {
                      return ChatItem(info[0], info[1], info[2]);
                    })
                  ],
                ),
              ),
            ],
          ),
        )
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.logout),
                color: Colors.red[400],
                iconSize: 30,
                onPressed: () {
                  AuthProvider.googleLogout();
                },
              )
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

  Widget _findButton() {
    return ElevatedButton(
      onPressed: () {},
      child: SizedBox(
        height: 28,
        width: 28,
        child: SvgPicture.asset("assets/icons/magnifier.svg")
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(15),
        primary: Color(0xFF9EC2B8), // <-- Button color
        onPrimary: Color(0xFF92B2A9), // <-- Splash color
      ),
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
            Stack(
              alignment: Alignment.center,
              children: [ 
                _footerBar(context),
                _findButton()
              ]
            )
          ],
        ),
      ),
    );
  }
}