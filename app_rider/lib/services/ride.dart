import 'dart:async';

import 'package:app_rider/models/user.dart';
import 'package:app_rider/services/web_socket.dart';

// predefine the types of messages that can we want
// to possibly send thru the WebsocketService
// must match server types
enum WebsocketActionTypes {
  authenticate,
  serviceState,
  routeConfirm,
  rideConfirm,
  rideStart,
  rideEnd
}

class Ride {
  User user;
  final WebSocketService _webSocketService;
  StreamSubscription? _listener;

  // data from the server
  int? driverPool;

  Ride(this.user, this._webSocketService) {
    // todo: verify
    // if _reconnect is called in websocket service will this listener point to the new stream????
    // i dont think so. but we don't want reconnect logic to be outside of web_socket ...
    _listener = _webSocketService.stream.listen((data) {
      _handleResponse(data);
    });

    // get current state of the ride service (drivers available, etc ...)
    _webSocketService.send(WebsocketActionTypes.serviceState);
  }

  void _handleResponse(dynamic data) {
    print('payload received');
    print(data);
  }

  void confirm() {
    _webSocketService
        .send(WebsocketActionTypes.rideStart, {'user_id': user.id});
  }

  void dispose() {
    _listener?.cancel();
  }
}
