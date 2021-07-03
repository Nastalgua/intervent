import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intervent/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class TagItem extends StatefulWidget {
  final String name; 

  TagItem({Key? key, required this.name}) : super(key: key);

  @override
  _TagItem createState() => _TagItem();
}

class _TagItem extends State<TagItem> {
  static CollectionReference users = FirebaseFirestore.instance.collection('users');

  final _userStream = 
    FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  bool selected = false;

  Widget item(context, List<dynamic> tags) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: ElevatedButton(
        child: Text(
          widget.name,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: selected ? Color(0xFFFFFFFF) : Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: 18.0
            )
          ),
        ),
        onPressed: () {
          final tagsClone = [...tags];
          final authProvider = Provider.of<AuthProvider>(context, listen: false);

          if (!this.selected) {
            tagsClone.add(widget.name);
            authProvider.updateTags(tagsClone);
          } else {
            tagsClone.remove(widget.name);
            authProvider.updateTags(tagsClone);
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (selected)
                return Color(0xFF9EC2B8);
              
              return Color(0xFFFFFFFF);
            }
          ),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              if (selected)
                return states.contains(MaterialState.pressed) ? Color(0xFF92B0AB) : null;
              
              return states.contains(MaterialState.pressed) ? Color(0xFFEFEFEF) : null;
            },
          )
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final tags = snapshot.data?["tags"];
        this.selected = tags.contains(widget.name);

        return item(context, tags);
      },
    );
  }
}
