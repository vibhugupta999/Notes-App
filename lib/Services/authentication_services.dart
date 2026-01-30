// ignore_for_file: unused_local_variable, unnecessary_nullable_for_final_variable_declarations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  AuthServices();

  static final _auth = FirebaseAuth.instance;

  static final googleSignin = GoogleSignIn.instance;

  static User? get user => _auth.currentUser;

  static Stream<User?> get userStream => _auth.authStateChanges();

  static register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final credential = _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credential) {
            credential.user?.sendEmailVerification();
            credential.user?.updateDisplayName(username);
          });
    } catch (e) {
      rethrow;
    }
  }

  static bool get isEmailVerified => user?.emailVerified ?? false;

  static Future<void> logout() async {
    await _auth.signOut();
    if (!kIsWeb) {
      await googleSignin.signOut();
    }
  }

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      googleAuthProvider.addScope(
        'https://www.googleapis.com/auth/contacts.readonly',
      );

      return await _auth.signInWithPopup(googleAuthProvider);
    } else {
      // Trigger the authentication flow
      await googleSignin.initialize(
        serverClientId:
            "859392640995-on34mhdanvkbund5dqs8td57ncuih488.apps.googleusercontent.com",
      );

      final GoogleSignInAccount? googleUser = await googleSignin.authenticate();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    }
  }
}
