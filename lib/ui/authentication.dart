import 'package:flutter/material.dart';

import 'package:intervent/providers/auth_provider.dart';
import 'package:intervent/router/route_constants.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';

//Find others to talk to.
//Vent out your troubles.
class Authentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF9EC2B8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Intervent",    
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle( 
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Find others to talk to.",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle( 
                        fontWeight: FontWeight.w300,
                        fontSize: 25,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Vent out your troubles.",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle( 
                        fontWeight: FontWeight.w300,
                        fontSize: 25,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                "Login",                  
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle( 
                    fontWeight: FontWeight.w300,
                    fontSize: 23,
                    color: Colors.white
                  ),
                ),
              ),
              IconButton(
                iconSize: 120,
                onPressed: () {
                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                  authProvider.googleLogin();
                  Navigator.of(context).pushNamed(HomeViewRoute);
                }, 
                icon: SimpleShadow(
                  child: new SvgPicture.asset("assets/icons/google_icon.svg"),
                  opacity: 0.25,
                  color: Color(0xFF656565),
                  offset: Offset(0, 4),
                  sigma: 6,    
                )
                // icon: Icon(Icons.login),
              ),
            ],
          ),
        ],

      )
    );
  }
}