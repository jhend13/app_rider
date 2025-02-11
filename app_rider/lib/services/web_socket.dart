import 'dart:convert';
import 'dart:io' show WebSocket;
import 'package:app_rider/config/constants.dart' as constants;

class WebSocketService {
  static const _reconnectCooldown = 5; // seconds
  bool _isConnecting = false;
  Map<String, String?> headers = {};
  WebSocket? _socket;

  // because WebSocketChannel uses a single-subscription stream
  // we need a middleman Broadcast stream that can allow multiple subscribers
  Stream<dynamic> _broadcastStream = const Stream.empty();

  Stream<dynamic> get stream => _broadcastStream;

  WebSocketService([Map<String, String?>? headers]) : headers = headers ?? {};

  void connect() {
    _connect();
  }

  void _connect() async {
    if (_isConnecting) return;
    _isConnecting = true;

    try {
      _socket = await WebSocket.connect(
        constants.urlWebSocketEndpoint,
        headers: headers,
      );

      _broadcastStream = _socket!.asBroadcastStream().map((o) => jsonDecode(o));
      _isConnecting = false;

      _broadcastStream.listen((data) {}, onError: (err) {}, onDone: () {
        _reconnect();
      });
    } catch (e) {
      _isConnecting = false;
      _reconnect();
    }
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: _reconnectCooldown), () {
      _connect();
    });
  }

  void send(Enum webSocketActionType, [Map<String, dynamic>? data]) {
    Map<String, dynamic> payload = {
      'action': webSocketActionType.name,
      'data': data ?? {}
    };
    String json = jsonEncode(payload);
    _socket?.add(json);
  }

  void close() {
    _socket?.close();
  }

  void dispose() {
    close();
  }
}
