import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../pages/loginpage.dart';

class AuthenticationService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Future<User?> signIn({required String email, required String password, required BuildContext context}) async {
    User? user;
    try{
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      const snackBar = SnackBar(
        content: Text('Invalid Password!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return user;
  }

  Future<bool> signUp({required String email, required String password, required BuildContext context}) async {
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      const snackBar = SnackBar(
          content: Text('Successfull!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return true;
    }on FirebaseAuthException catch (e){
      debugPrint(e.message ?? "Unkown Error");
      return false;
    }
  }

  Future signOut(BuildContext context) async{
    await firebaseAuth.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Loginpage()));
    debugPrint("Signout!");
  }

}