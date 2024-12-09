import 'package:app_rider/services/web_socket.dart';

// predefine the types of messages that can we want
// to possibly send thru the WebsocketService
enum WebsocketActionTypes { routeConfirm, rideConfirm, rideStart, rideEnd }

class Ride {
  final WebSocketService _webSocketService;

  Ride(this._webSocketService);

  void confirm() {
    print('Ride confirmed.');
    _webSocketService.send(WebsocketActionTypes.rideStart, {'user_id': 1});
  }
}
