import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  static CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    
    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    final res = await FirebaseAuth.instance.signInWithCredential(credential);
    
    if (res.additionalUserInfo!.isNewUser) {
      await users.doc(res.user?.uid).set({ 'id': res.user?.uid, 'tags': [], 'chats': [] });
    }

    notifyListeners();
  }

  static Future googleLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future updateTags(List<dynamic> tags) async {
    users.doc(FirebaseAuth.instance.currentUser!.uid).update({ 'tags' : tags });

    notifyListeners();
  }

}