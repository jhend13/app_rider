import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  String? _fcmToken;
  NotificationSettings? notificationSettings;

  String? get token => _fcmToken;

  NotificationService() {
    _init();
  }

  void _init() async {
    notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);

    String? _fcmToken = await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      _fcmToken = fcmToken;
    }).onError((err) {
      // Error getting token.
    });
  }
}
