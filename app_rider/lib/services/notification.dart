import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  String? _fcmToken;
  NotificationSettings? notificationSettings;

  String? get token => _fcmToken;

  NotificationService() {
    _init();
  }

  // firebase package dictates that onBackgroundMessage
  // needs to be a non-anonymous, top-level function.
  static Future<void> _onBackgroundMessage(RemoteMessage msg) async {
    print('{fb.onBackgroundMessage} ${DateTime.now()}');
    print(msg.data);
  }

  void _init() async {
    notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);

    String? _fcmToken = await FirebaseMessaging.instance.getToken();

    // to-do: .onError
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      _fcmToken = fcmToken;
    });

    // when app is opened
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print('{fb.onMessage} test message received');
      print(msg.data);
    });

    // when app is in background / closed
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }
}
