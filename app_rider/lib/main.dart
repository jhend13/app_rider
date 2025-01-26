import 'package:app_rider/services/api/mapbox.dart';
import 'package:app_rider/services/web_socket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'config/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:app_rider/services/auth.dart';
import 'package:app_rider/services/api/rest.dart';
import 'package:app_rider/services/navigation.dart';
import 'package:app_rider/router/auth_guard.dart';
import 'package:app_rider/models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String accessToken = const String.fromEnvironment("ACCESS_TOKEN");
  MapboxOptions.setAccessToken(accessToken);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  User user = AuthService.getUser();

  if (AuthService.isLoggedIn()) {
    // sync firebase uid with respective data in our
    // external database
    await RestApiService.syncUser(user);
  }

  runApp(App(
    user: user,
    mapboxApi: MapboxApiService(accessToken),
  ));
}

class App extends StatelessWidget {
  final User user;
  final MapboxApiService mapboxApi;

  const App({super.key, required this.user, required this.mapboxApi});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: user),
        Provider(
          create: (context) => WebSocketService()..connect(),
          dispose: (context, value) => value.dispose(),
          lazy: false,
        ),
        Provider.value(value: mapboxApi),
        // ProxyProvider<User, WebSocketService>(
        //   create: (context) => WebSocketService()..connect(),
        //   update: (_, user, websocketService) {
        //     websocketService!.setUid(user.uid);
        //     return websocketService;
        //   },
        //   dispose: (context, value) => value.dispose(),
        //   lazy: false,
        // ),
      ],
      child: MaterialApp(
          title: 'AADD',
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
          navigatorKey: NavigationService.navigatorKey,
          home: AuthGuard()),
    ));
  }
}
