import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient/helper/helperfunctions.dart';
import 'package:patient/services/database.dart';
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

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(username);
          HelperFunctions.saveUserEmailSharedPreference(email);

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

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.docs[0]["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.docs[0]["userEmail"]);
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
