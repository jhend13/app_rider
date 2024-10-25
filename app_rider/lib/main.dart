import 'package:app_rider/ui/pages/registration.dart';
import 'package:flutter/material.dart';

import 'config/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:app_rider/router/auth_guard.dart';

import 'package:app_rider/ui/pages/home_page.dart';
import 'package:app_rider/ui/pages/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    //final providers = [EmailAuthProvider()];

    return SafeArea(
        child: MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark, seedColor: const Color(0x415f91)),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x415f91)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGuard(),
        '/home': (context) => const HomePage(),
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const RegistrationPage()
      },
    ));
  }
}
