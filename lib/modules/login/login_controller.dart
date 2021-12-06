import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      log(
        'Caught error while signing in with google',
        name: 'LoginController',
        error: error,
      );
      return;
    }
  }
}
