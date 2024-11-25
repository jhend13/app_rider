import 'package:app_rider/models/address.dart';
import 'package:app_rider/config/addreses.dart';
import 'package:app_rider/models/user.dart';
import 'package:app_rider/services/navigation.dart';
import 'package:app_rider/ui/pages/preview.dart';
import 'package:app_rider/ui/pages/route.dart';
import 'package:app_rider/ui/widgets/loading_indicator_wrapper.dart';
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
  bool asyncRequestActive = false;

  @override
  void initState() {
    super.initState();
  }

  void _onClickAddressShortcutResult(Address address) async {
    if (asyncRequestActive) return;

    setState(() {
      asyncRequestActive = true;
    });

    Address currentAddress = await Address.fromCurrentLocation();

    setState(() {
      asyncRequestActive = false;
    });

    // address was selected
    NavigationService.navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (context) =>
            PreviewPage(origin: currentAddress, destination: address)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    User user = Provider.of<User>(context, listen: false);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          drawer: const MainDrawer(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  .copyWith(
                                      color: theme.colorScheme.secondary)),
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
                      GestureDetector(
                          onTap: () =>
                              _onClickAddressShortcutResult(address_fafb),
                          child: Column(
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
                                      .copyWith(
                                          color: theme.colorScheme.secondary)),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (asyncRequestActive) ...[
          const Opacity(
              opacity: .3,
              child: ModalBarrier(
                color: Colors.black,
              )),
          Center(
            child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: theme.colorScheme.secondaryContainer),
              padding: const EdgeInsets.all(15),
              child: const Expanded(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ]
      ],
    );
  }
}
