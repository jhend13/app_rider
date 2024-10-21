import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app_rider/ui/widgets/full_map.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      setState(() => counter++);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [FullMap()],
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.abc_sharp), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.abc_sharp), label: 'yo')
      ]),
    );
  }
}
