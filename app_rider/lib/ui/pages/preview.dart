import 'package:app_rider/ui/widgets/full_map.dart';
import 'package:flutter/material.dart';
import 'package:app_rider/models/address.dart';
import 'package:app_rider/services/navigation.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class PreviewPage extends StatefulWidget {
  final Address locStart;
  final Address locEnd;

  const PreviewPage({super.key, required this.locStart, required this.locEnd});

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
      body: Column(
        children: [FullMap()],
      ),
    );
  }
}
