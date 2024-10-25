import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_rider/services/auth.dart';

import 'package:app_rider/ui/pages/home_page.dart';
import 'package:app_rider/ui/pages/sign_in.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return SignInPage();
          }
        });
  }
}
