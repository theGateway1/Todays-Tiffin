import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Authorize {
  Future<void> signinwithPhoneEmail(String phoneNo, String password) async {
    final String email = phoneNo + "@mytiffin.tiffinservice.com";
    try {
      auth.UserCredential userCredential = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Utilities.showToast('No user found for that mobile No.');
      } else if (e.code == 'wrong-password') {
        // Utilities.showToast('Wrong password.');
      } else {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            // Utilities.showToast(e.code);
          }
        } on SocketException catch (_) {
          // Utilities.showToast("Not Connected To internet");
        }
      }
    }
  }
}
