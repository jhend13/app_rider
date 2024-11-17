import 'package:app_rider/services/navigation.dart';
import 'package:app_rider/ui/widgets/address_searchbox.dart';
import 'package:app_rider/ui/widgets/location_listing.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  AddressPage({super.key});

  final AddressSearchbox addressSearch = AddressSearchbox();

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
        children: [
          SizedBox(
            width: 300,
            child: addressSearch,
          ),
          ValueListenableBuilder(
              valueListenable: addressSearch.addressesNotifier,
              builder: (context, addresses, child) {
                print(addresses);
                List<Padding> texts = addresses
                    .map((address) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: LocationListing(address),
                        ))
                    .toList();
                return SizedBox(
                  width: 300,
                  child: Column(
                    children: (addresses.isEmpty) ? [] : [...texts, Divider()],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
