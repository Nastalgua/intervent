import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';

class TagItem extends StatelessWidget {
  const TagItem({Key? key, required this.name, required this.selected}) : super(key: key);

  final String name; 
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? Color(0xFF9EC2B8) : Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Text(
          name,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: selected ? Color(0xFFFFFFFF) : Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: 18.0
            )
          ),
        ),
      ),
      opacity: 0.4,
      color: Color(0xFFB0B0B0),
      offset: Offset(0, 4),
      sigma: 4, 
    );
  }
}