import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intervent/router/route_constants.dart';

class ChatItem extends StatelessWidget {
  Color color;
  String to;
  String id;
  DateTime date; //update every time user talks with other person
  
  ChatItem(this.to, this.color, this.date, this.id);

  String formattedDate() {
    return "${this.date.month}/${this.date.day}/${this.date.year}";
  }

  Widget _userCircle(BuildContext context){
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: this.color,
              shape: BoxShape.circle
            )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 15
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              this.to,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle( 
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black
                  )
              ),
            ),
          ), 
        ),
      ],
    );
  }

  Widget _date(BuildContext context){
    return Align(
      child: Padding(
        padding: EdgeInsets.only(
          right: 20
        ),
        child: RichText(
          text: TextSpan(
            text: this.formattedDate(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle( 
                fontWeight: FontWeight.w300,
                fontSize: 15,
                color: Colors.black
              )
            ),
          ),
        ),  
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            MessagesViewRoute,
            arguments: this.id
          );
        }, // put in later
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _userCircle(context), //circle and user
          _date(context) //date
          ],
        ),
      )
    );
  }
}