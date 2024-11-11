import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:app_rider/config/constants.dart' as constants;

class SocketService {
  late WebSocketChannel socket;

  SocketService() {
    socket = WebSocketChannel.connect(
      Uri.parse(constants.urlWebSocketEndpoint),
    );
  }
}
