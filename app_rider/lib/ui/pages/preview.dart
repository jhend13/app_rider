import 'package:app_rider/ui/widgets/route_map.dart';
import 'package:flutter/material.dart';
import 'package:app_rider/models/address.dart';
import 'package:app_rider/services/navigation.dart';

class PreviewPage extends StatefulWidget {
  final Address origin;
  final Address destination;

  const PreviewPage(
      {super.key, required this.origin, required this.destination});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              NavigationService.navigatorKey.currentState!.pop();
            },
            icon: const Icon(Icons.close)),
      ),
      body: Stack(
        children: [
          RouteMap(
            origin: widget.origin,
            destination: widget.destination,
          ),
          Column(
            children: [Text('Previewing route')],
          )
        ],
      ),
    );
  }
}
