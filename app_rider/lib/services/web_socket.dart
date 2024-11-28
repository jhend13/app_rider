import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:app_rider/config/constants.dart' as constants;

class WebSocketService {
  final WebSocketChannel _socket = WebSocketChannel.connect(
    Uri.parse(constants.urlWebSocketEndpoint),
  );

  WebSocketService();

  Stream<dynamic> get stream => _socket.stream;

  void send(Map<String, dynamic> data) {
    String json = jsonEncode(data);
    _socket.sink.add(json);
  }

  void close() {
    _socket.sink.close();
  }
}
