import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final String message;
  final bool isSuccess;

  AuthResult({required this.isSuccess, required this.message});
}

class AuthService {
  //final FirebaseAuth _fbInstance = FirebaseAuth.instance;

  static Future<AuthResult> createUserWithEmailAndPassword(
      email, password) async {
    bool isSuccess = false;
    String message = '';

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
    } catch (e) {}

    return AuthResult(isSuccess: isSuccess, message: message);
  }

  static Future<AuthResult> signInWithEmailAndPassword(email, password) async {
    bool isSuccess = false;
    String? message = '';

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid username or password. ';
      }
    } catch (e) {}

    return AuthResult(isSuccess: isSuccess, message: message);
  }
}
