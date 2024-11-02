import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  String? uid;
  String? username;
  String? email;
  bool isVerified = false;

  // provided by our rest api server
  //static const List<String> _syncedAttrs = ['id', 'name'];

  User();

  User.fromFirebaseUser(fb.User fbUser)
      : uid = fbUser.uid,
        username = fbUser.displayName,
        email = fbUser.email,
        isVerified = fbUser.emailVerified {}

  set name(String? val) {
    _name = val;
  }

  set id(int? val) {
    _id = val;
  }

  // will take the additional user data from the rest server
  // and import it into the user model
  void syncFromJSON(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      id = json['id'];
      name = json['name'];
    }
  }
}
