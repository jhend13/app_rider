import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_rider/models/user.dart';
import 'package:app_rider/services/navigation.dart';
import 'package:app_rider/ui/pages/test_page.dart';
import 'package:app_rider/ui/pages/home_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> navItems = [
      {'icon': Icons.person, 'label': 'My Profile', 'target': const HomePage()},
      {'icon': Icons.settings, 'label': 'Settings', 'target': const TestPage()}
    ];

    List<Widget> navItemWidgets = navItems
        .map((item) => buildNavItem(context,
            icon: item['icon'], label: item['label'], target: item['target']))
        .toList();

    return Drawer(
      child: Consumer<User>(builder: (_, user, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Text('${user.name}',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const Divider(),
            ...navItemWidgets,
            const Divider(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    foregroundColor: Theme.of(context).colorScheme.onTertiary),
                onPressed: () {},
                child: const Text('Sign out'))
          ],
        );
      }),
    );
  }

  Widget buildNavItem(BuildContext context,
      {required IconData icon, required String label, Widget? target}) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
        child: GestureDetector(
            onTap: () {
              if (target != null) {
                NavigationService.navigatorKey.currentState!.pushReplacement(
                    MaterialPageRoute(builder: (context) => target));
              }
            },
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 12,
                ),
                Text(label, style: const TextStyle(fontSize: 16))
              ],
            )));
  }
}
