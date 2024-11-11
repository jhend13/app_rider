import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:app_rider/services/auth.dart';
import 'package:app_rider/services/rest_api.dart';
import 'package:app_rider/router/auth_guard.dart';
import 'package:app_rider/models/user.dart';

// navigatorKey used in AuthGuard
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  User user = AuthService.getUser();

  if (AuthService.isLoggedIn()) {
    // sync firebase uid with respective data in our
    // external database
    await RestApiService.syncUser(user);
  }

  runApp(App(user: user));
}

class App extends StatelessWidget {
  final User user;

  const App({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MultiProvider(
      providers: [ChangeNotifierProvider.value(value: user)],
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
