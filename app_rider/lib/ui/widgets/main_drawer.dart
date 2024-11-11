import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_rider/models/user.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> navItems = [
      {'icon': Icons.person, 'label': 'My Profile'},
      {'icon': Icons.settings, 'label': 'Settings'}
    ];

    List<Widget> navItemWidgets = navItems
        .map((item) => buildNavItem(icon: item['icon'], label: item['label']))
        .toList();

    return Drawer(
      child: Consumer<User>(builder: (_, user, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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

  Widget buildNavItem({required IconData icon, required String label}) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 12,
            ),
            Text(label)
          ],
        ));
  }
}
