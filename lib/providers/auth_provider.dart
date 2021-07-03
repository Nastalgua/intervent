import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/* TODO: This get the google log in prompt, and moves user to homepage
final authProvider = Provider.of<AuthProvider>(context, listen: false);
authProvider.googleLogin();
Navigator.of(context).pushNamed(HomeViewRoute);
*/

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? user;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    
    if (googleUser == null) return;
    user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();

  }

  Future googleLogout() async {
    await FirebaseAuth.instance.signOut();
  }

}