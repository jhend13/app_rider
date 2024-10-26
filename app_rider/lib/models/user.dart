import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String? uid;
  String? username;
  String? email;
  bool isVerified = false;

  User() {}
  User.fromFirebaseUser(fb.User fbUser)
      : uid = fbUser.uid,
        username = fbUser.displayName,
        email = fbUser.email,
        isVerified = fbUser.emailVerified {}
}
