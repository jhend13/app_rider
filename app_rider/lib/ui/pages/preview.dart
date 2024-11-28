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
                      onPressed: () {},
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
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () {
                  NavigationService.navigatorKey.currentState!.pop();
                },
                icon: const Icon(Icons.close)),
          ),
        ],
      ),
    );
  }
}
