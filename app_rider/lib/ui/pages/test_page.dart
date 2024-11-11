import 'package:flutter/material.dart';
import 'package:app_rider/ui/widgets/main_drawer.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          ...List.generate(10, (index) => Text('example stuff ${index}'))
        ],
      ),
    );
  }
}
