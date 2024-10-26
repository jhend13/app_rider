import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:app_rider/services/auth.dart';
import 'package:app_rider/router/auth_guard.dart';
import 'package:app_rider/models/user.dart';

//final providers = [EmailAuthProvider()];
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(create: (_) => AuthService.getUser())
      ],
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
          navigatorKey: navigatorKey,
          home: AuthGuard()),
    ));
  }
}
