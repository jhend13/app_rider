import 'package:app_rider/ui/pages/preview.dart';
import 'package:flutter/material.dart';
import 'package:app_rider/services/navigation.dart';
import 'package:app_rider/ui/widgets/address_searchbox.dart';
import 'package:app_rider/ui/widgets/address_result.dart';
import 'package:app_rider/models/address.dart';

class RoutePage extends StatelessWidget {
  RoutePage({super.key});

  final AddressSearchbox addressSearch = AddressSearchbox();
  bool asyncRequestActive = false;

  void _onClickAddressResult(Address address) async {
    if (asyncRequestActive) return;
    asyncRequestActive = true;
    Address currentAddress = await Address.fromCurrentLocation();
    asyncRequestActive = false;

    // address was selected
    NavigationService.navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (context) =>
            PreviewPage(origin: currentAddress, destination: address)));
  }

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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: 300,
                  child: addressSearch,
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: addressSearch.addressesNotifier,
                  builder: (context, addresses, child) {
                    List<Padding> texts = addresses
                        .map((address) => Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: AddressResult(
                                address,
                                callback: (Address addr) =>
                                    _onClickAddressResult(addr),
                              ),
                            ))
                        .toList();
                    return SizedBox(
                      width: 300,
                      child: Column(
                        children: (addresses.isEmpty) ? [] : texts,
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}
