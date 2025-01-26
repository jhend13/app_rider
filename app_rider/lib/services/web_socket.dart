import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:app_rider/config/constants.dart' as constants;

class WebSocketService {
  static const _reconnectCooldown = 5; // seconds
  bool _isConnecting = false;
  WebSocketChannel? _socket;

  // because WebSocketChannel uses a single-subscription stream
  // we need a middleman Broadcast stream that can allow multiple subscribers
  Stream<dynamic> _broadcastStream = const Stream.empty();

  Stream<dynamic> get stream => _broadcastStream;

  WebSocketService();

  void connect() {
    _connect();
  }

  void getStream() {}

  void _connect() {
    if (_isConnecting) return;
    _isConnecting = true;

    try {
      _socket = WebSocketChannel.connect(
        Uri.parse(constants.urlWebSocketEndpoint),
      );

      _socket!.ready.then((val) {
        _isConnecting = false;
        _broadcastStream = _socket!.stream.asBroadcastStream();
      }, onError: (err) {
        _isConnecting = false;
        _reconnect();
      });

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
    _socket?.sink.add(json);
  }

  void close() {
    _socket?.sink.close();
  }

  void dispose() {
    close();
  }
}
