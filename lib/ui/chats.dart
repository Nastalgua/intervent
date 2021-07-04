import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intervent/constants/colors_gen.dart';
import 'package:intervent/models/chat.dart';
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

  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
  final CollectionReference chatsRef = FirebaseFirestore.instance.collection('chats');

  List<String> userChats = [];

  @override
  void initState() { 
    super.initState();
    
    this.usersRef.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((element) { 
        setState(() {
          userChats = [...element.doc.get('chats')];
        });

      });
    });
  }

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

  Widget _mainBody(BuildContext context, userDoc) {
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
                child: StreamBuilder<QuerySnapshot> (
                  stream: chatsRef.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      print(userChats);
                      return new ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          print(userChats);
                          if (!userChats.contains(data['id'])) return CircularProgressIndicator();

                          if (userDoc.get('name') == user.displayName) {
                            return ChatItem(data['userTwo'], getRandomColor(), DateTime.parse(data['createdAt']), data['id']);
                          } else {
                            return ChatItem(data['userOne'], getRandomColor(), DateTime.parse(data['createdAt']), data['id']);
                          }
                        }).toList(),
                      );
                    }

                    return CircularProgressIndicator();
                  },                  
                )
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

  Widget _findButton(context) {
    return ElevatedButton(
      onPressed: () async {
        final usersQuerySnapshot = await usersRef.get();
        final currUserData = await usersRef.doc(user.uid).get();
        
        usersQuerySnapshot.docs.forEach((iUser) async {
          if (iUser.get('id') == currUserData['id']) return; // same user

          final tempUserChatsSet = (iUser.get('chats') as List<dynamic>).toSet();
          final userChatsSet = (currUserData['chats'] as List<dynamic>).toSet();

          // check if chat between users already exist
          if (tempUserChatsSet.intersection(userChatsSet).isNotEmpty) return;

          final tempUserTagSet = (iUser.get('tags') as List<dynamic>).toSet();
          final userTagSet = (currUserData['tags'] as List<dynamic>).toSet();

          if (tempUserTagSet.intersection(userTagSet).isEmpty) return;

          // create chat between user
          Chat chat = new Chat(userOne: iUser.get('name'), userTwo: currUserData['name']);
          
          chatsRef.doc(chat.id).set({
            'id': chat.id,
            'userOne': chat.userOne,
            'userTwo': chat.userTwo,
            'createdAt': chat.createdAt,
            'messages': [],
          });

          usersRef.doc(user.uid).update({ 'chats' : [...currUserData['chats'], chat.id] });
          usersRef.doc(iUser.get('id')).update({ 'chats' : [...iUser.get('chats'), chat.id] });

          userChats.add(chat.id);
        });
      },
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
            FutureBuilder(
              future: usersRef.doc(user.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _mainBody(context, (snapshot.data as DocumentSnapshot));
                }

                return CircularProgressIndicator();
              }
            ),
            Stack(
              alignment: Alignment.center,
              children: [ 
                _footerBar(context),
                _findButton(context)
              ]
            )
          ],
        ),
      ),
    );
  }
}
