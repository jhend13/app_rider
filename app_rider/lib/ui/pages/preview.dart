import 'dart:io';
import 'package:app_rider/services/ride.dart';
import 'package:app_rider/services/web_socket.dart';
import 'package:app_rider/ui/widgets/route_map.dart';
import 'package:flutter/material.dart';
import 'package:app_rider/models/address.dart';
import 'package:app_rider/services/navigation.dart';
import 'package:provider/provider.dart';
import 'package:app_rider/config/constants.dart' show WebsocketActionTypes;

class PreviewPage extends StatefulWidget {
  final Address origin;
  final Address destination;

  const PreviewPage(
      {super.key, required this.origin, required this.destination});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late final WebSocketService webSocketService;
  Ride? ride;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // lets go ahead and get the WebSocketService from Provider
    webSocketService = Provider.of<WebSocketService>(context, listen: false);
  }

  void _confirm() {
    ride = Ride(webSocketService)..confirm();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          RouteMap(
            origin: widget.origin,
            destination: widget.destination,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 90,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: theme.colorScheme.tertiaryContainer,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        print('confirm');
                        _confirm();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              theme.colorScheme.onTertiaryContainer,
                          foregroundColor: theme.colorScheme.onTertiary),
                      child: Text(
                        'Confirm',
                        style: theme.textTheme.labelMedium!
                            .copyWith(color: theme.colorScheme.onTertiary),
                      ))
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    NavigationService.navigatorKey.currentState!.pop();
                  },
                  icon: const Icon(Icons.close)),
            ),
          )
        ],
      ),
    );
  }
}
