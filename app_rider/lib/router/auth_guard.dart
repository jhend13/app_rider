import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app_rider/ui/pages/home_page.dart';
import 'package:app_rider/ui/pages/sign_in.dart';

import 'package:app_rider/main.dart' as main;

class AuthGuard extends StatefulWidget {
  //const AuthGuard({Key? key}) : super(key: key);

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  StreamSubscription? _authStream;
  User? userData;

  @override
  void initState() {
    super.initState();
    _authStream = FirebaseAuth.instance.authStateChanges().listen((data) {
      userData = data;
      // when the auth state is changed, we want to clear the nav stack
      // and return to the root path '/' (AuthGuard)
      // otherwise if a route has been pushed, AuthGuard will rebuild up the stack
      // but the pushed route will continue to show.
      // returning true in popUntil does not produce any effects
      main.navigatorKey.currentState?.popUntil((route) {
        if (route.settings.name == '/') {
          return true;
        }
        return false;
      });
      setState(() {});
    });
  }

  @override
  void dispose() {
    _authStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const SignInPage();
    }
    return const HomePage();
  }
}
