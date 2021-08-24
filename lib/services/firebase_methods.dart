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

class OtherServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<QueryDocumentSnapshot> findUserDetails(String usid) async {
    QuerySnapshot docref = await _firestore
        .collection("users")
        .where('uid', isEqualTo: usid)
        .get();
    QueryDocumentSnapshot doc = docref.docs[0];
    return doc;
  }

  Future<QueryDocumentSnapshot> findUserRequest(String usid) async {
    QuerySnapshot docref = await _firestore
        .collection("requests")
        .where('uid', isEqualTo: usid)
        .get();
    QueryDocumentSnapshot doc = docref.docs[0];
    return doc;
  }

  Future<String> fetchDelayFactor() async {
    String usid = FirebaseAuth.instance.currentUser!.uid.toString();
    QueryDocumentSnapshot doc = await findUserDetails(usid);
    String res = doc["delayFactor"];
    return res;
  }

  Future<String> requestCancellation() async {
    try {
      print("RUNS");
      Map<String, String> data = {
        "cancellation": "true",
      };
      String usid = FirebaseAuth.instance.currentUser!.uid.toString();
      QueryDocumentSnapshot doc = await findUserRequest(usid);
      if (doc["cancellation"] != "false") {
        return "requested";
      } else {
        await _firestore.collection("requests").doc(usid).update(data);
        return "success";
      }
    } catch (e) {
      print(e.toString());
      return "error";
    }
  }

  Future<String> requestChangedTiming(String time) async {
    try {
      Map<String, String> data = {
        "changedTime": time,
      };
      String usid = FirebaseAuth.instance.currentUser!.uid.toString();
      QueryDocumentSnapshot doc = await findUserRequest(usid);
      if (doc["changedTime"] != "false") {
        return "requested";
      } else {
        await _firestore.collection("requests").doc(usid).update(data);
        return "success";
      }
    } catch (e) {
      print(e.toString());
      return "error";
    }
  }

  Future<String> requestClearDues() async {
    try {
      Map<String, String> data = {
        "clearDues": "true",
      };
      String usid = FirebaseAuth.instance.currentUser!.uid.toString();
      QueryDocumentSnapshot doc = await findUserRequest(usid);
      if (doc["clearDues"] != "false") {
        return "requested";
      } else {
        await _firestore.collection("requests").doc(usid).update(data);
        return "success";
      }
    } catch (e) {
      print(e.toString());
      return "error";
    }
  }

  Future<String> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Utilities.showToast(e.code);
        return "success";
      }
    } on SocketException catch (_) {
      Utilities.showToast("NOT CONNECTED TO INTERNET");
      return "error";
    }
    return "error";
  }

  Future<String> userAcknowledge() async {
    try {
      Map<String, String> data = {
        "clearDuesResponse": "null",
        "cancellationResponse": "null",
        "changedTimeResponse": "null",
      };
      String usid = FirebaseAuth.instance.currentUser!.uid.toString();
      await _firestore.collection("requests").doc(usid).update(data);
      return "success";
    } catch (e) {
      print(e.toString());
      return "error";
    }
  }

  Future<List<Map<dynamic, dynamic>>> getRequestList() async {
    List<Map<dynamic, dynamic>> response = [
      {"null": "null"}
    ];
    try {
      String usid = FirebaseAuth.instance.currentUser!.uid.toString();
      QueryDocumentSnapshot doc = await findUserRequest(usid);
      response.clear();
      response.add({"Last Updated At": doc["lastUpdatedAt"]});

      response.add({"Clear Dues": doc["clearDuesResponse"]});

      response.add({"Cancellation": doc["cancellationResponse"]});

      response.add({"Changed Timing": doc["changedTimeResponse"]});

      print(response.toString());
      if (response.isEmpty) {
        response.add({"null": "null"});
      }
      return response;
    } catch (e) {
      print(e.toString());
    }
    return response;
  }
}
