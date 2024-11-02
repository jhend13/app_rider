import 'package:flutter/material.dart';
import 'package:app_rider/ui/widgets/full_map.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:provider/provider.dart';
import 'package:app_rider/models/user.dart';

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
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<User>(builder: (_, user, __) {
              String? email = user.email;
              String? name = user.name;
              return Column(
                children: [Text('Welcome $name'), Text('$email')],
              );
              ;
            }),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    foregroundColor: Theme.of(context).colorScheme.onTertiary),
                onPressed: () {
                  fb.FirebaseAuth.instance.signOut();
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
