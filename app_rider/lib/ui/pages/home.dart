import 'package:app_rider/models/address.dart';
import 'package:app_rider/models/user.dart';
import 'package:app_rider/services/navigation.dart';
import 'package:app_rider/ui/pages/route.dart';
import 'package:flutter/material.dart';
import 'package:app_rider/ui/widgets/main_drawer.dart';
import 'package:app_rider/ui/widgets/address_searchbox.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AddressSearchbox addressSearch = AddressSearchbox();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    User user = Provider.of<User>(context, listen: false);

    return Scaffold(
        appBar: AppBar(),
        drawer: const MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //children: [FullMap()],
            children: [
              const SizedBox(width: double.infinity),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Text('Get home safe,',
                        style: theme.textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(' ${user.name}',
                        style: theme.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.secondary)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: null,
                width: 300,
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                      filled: true,
                      label: const Text('Where\'s home?'),
                      labelStyle: theme.textTheme.labelMedium,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.colorScheme.surface,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      )),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    NavigationService.navigatorKey.currentState!.push(
                        MaterialPageRoute(builder: (context) => RoutePage()));
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                  valueListenable: addressSearch.addressesNotifier,
                  builder: (context, addresses, child) {
                    List<Padding> texts = addresses
                        .map((e) => Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Text(e.address),
                            ))
                        .toList();
                    return SizedBox(
                      width: 300,
                      child: Column(
                        children:
                            (addresses.isEmpty) ? [] : [...texts, Divider()],
                      ),
                    );
                  }),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Icon(Icons.pin_drop_sharp,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Previous Dropoff',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text('1029 W 1st Ave, Spokane',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: theme.colorScheme.secondary)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Icon(Icons.pin_drop_sharp,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fairchild AFB',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text('Fairchild AFB, WA',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: theme.colorScheme.secondary)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
