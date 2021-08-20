import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:z_todays_tiffin/Utilities/utilities.dart';

class Authorize {
  Future<String> signinwithPhoneEmail(String phoneNo, String password) async {
    final String email = phoneNo + "@mytiffin.tiffinservice.com";
    try {
      auth.UserCredential userCredential = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        Utilities.showToast("USER NOT FOUND");
        return "error";
      } else if (e.code == 'wrong-password') {
        Utilities.showToast("INVALID CREDENTIALS");
        return "error";
      } else {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Utilities.showToast(e.code);
            return "error";
          }
        } on SocketException catch (_) {
          Utilities.showToast("NOT CONNECTED TO INTERNET");
          return "error";
        }
      }
    }
    return "error";
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
