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
  rideCancel,
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
    // convert enum string val from server to local enum object
    WebsocketActionTypes action = WebsocketActionTypes.values.firstWhere(
        (ev) => ev.name == data['action'],
        orElse: () =>
            throw Exception('Invalid WebsocketActionType: ${data['action']}'));

    switch (action) {
      case WebsocketActionTypes.routeConfirm:
        print('Server said we\'re good ... do something');
      default:
    }
  }

  void confirm() {
    _webSocketService
        .send(WebsocketActionTypes.routeConfirm, {'user_id': user.id});
  }

  void cancel() {
    print('canceling');
    _webSocketService
        .send(WebsocketActionTypes.rideCancel, {'user_id': user.id});
  }

  void dispose() {
    _listener?.cancel();
  }
}
