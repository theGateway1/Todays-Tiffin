import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';

class Authorize {
  Future<String> signinwithPhoneEmail(String phoneNo, String password) async {
    final String email = phoneNo + "@mytiffin.tiffinservice.com";
    try {
      auth.UserCredential userCredential = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        return "user-not-found";
      } else if (e.code == 'wrong-password') {
        return "wrong-password";
      }
    }
    print("success");
    return "success";
  }

  Future signOut() async {
    await auth.FirebaseAuth.instance.signOut();
    // _user = null;
    return Future.delayed(Duration.zero);
  }
}

class otherServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<QueryDocumentSnapshot> findUserDetails(String usid) async {
    QuerySnapshot docref = await _firestore
        .collection("users")
        .where('uid', isEqualTo: usid)
        .get();
    QueryDocumentSnapshot doc = docref.docs[0];
    return doc;
  }

  Future<String> fetchDelayFactor() async {
    String usid = FirebaseAuth.instance.currentUser!.uid.toString();
    // print(usid.toString());
    QueryDocumentSnapshot doc = await findUserDetails(usid);
    String res = doc["delayFactor"];
    // print("Delay Factor: $res");
    return res;
  }
}
