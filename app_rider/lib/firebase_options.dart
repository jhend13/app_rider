// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyChbNXU6oYAhs67Ba7-pK1M0PNSiwz_YRE',
    appId: '1:583487293943:web:0135c7f1e9a9956ad506f2',
    messagingSenderId: '583487293943',
    projectId: 'aadd-be709',
    authDomain: 'aadd-be709.firebaseapp.com',
    storageBucket: 'aadd-be709.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4vWLInQqNamMvq7qrW3c3X0XvPliCOLM',
    appId: '1:583487293943:android:de0e0011b535aa00d506f2',
    messagingSenderId: '583487293943',
    projectId: 'aadd-be709',
    storageBucket: 'aadd-be709.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRvbsa2T3URzskzt1wF19TWgEN_goRJrc',
    appId: '1:583487293943:ios:65d199ea2ec8b2c4d506f2',
    messagingSenderId: '583487293943',
    projectId: 'aadd-be709',
    storageBucket: 'aadd-be709.appspot.com',
    iosClientId: '583487293943-ej6fic184fddvgoan1k29jbk6f4e8jeq.apps.googleusercontent.com',
    iosBundleId: 'com.example.appRider',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyChbNXU6oYAhs67Ba7-pK1M0PNSiwz_YRE',
    appId: '1:583487293943:web:ecfaa2d40ddfa395d506f2',
    messagingSenderId: '583487293943',
    projectId: 'aadd-be709',
    authDomain: 'aadd-be709.firebaseapp.com',
    storageBucket: 'aadd-be709.appspot.com',
  );
}
