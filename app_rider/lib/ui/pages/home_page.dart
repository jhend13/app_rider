import 'package:flutter/material.dart';
import 'package:app_rider/config/constants.dart' as constants;
import 'package:app_rider/ui/widgets/full_map.dart';

import 'package:firebase_auth/firebase_auth.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(constants.appName),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text('Sign out'))
          ],
        ),
      ),
      body: Column(
        children: [FullMap()],
      ),
    );
  }
}
