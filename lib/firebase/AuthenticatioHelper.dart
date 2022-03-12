import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient/firebase/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp(
      {required String email,
      required String password,
      required username}) async {
    DatabaseMethods databaseMethods = new DatabaseMethods();
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((result) {
        if (result != null) {
          Map<String, String> userDataMap = {
            "userName": username,
            "userEmail": email
          };

          databaseMethods.addUserInfo(userDataMap);

          // Navigator.pushReplacement(context, MaterialPageRoute(
          //     builder: (context) => ChatRoom()
          // ));
        }
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(email);
          print(userInfoSnapshot.docs[0].id);
        }
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
