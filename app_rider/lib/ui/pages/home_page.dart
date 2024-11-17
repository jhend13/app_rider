import 'package:app_rider/models/address.dart';
import 'package:flutter/material.dart';
import 'package:app_rider/ui/widgets/main_drawer.dart';
import 'package:app_rider/ui/widgets/full_map.dart';
import 'package:app_rider/ui/widgets/address_searchbox.dart';
import 'package:app_rider/services/api/mapbox_api.dart';
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
    return Scaffold(
      appBar: AppBar(),
      drawer: const MainDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //children: [FullMap()],
        children: [
          const SizedBox(width: double.infinity),
          const Text('Sup! Take a ride.'),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: null,
            width: 300,
            child: addressSearch,
          ),
          const SizedBox(
            height: 20,
          ),
          ValueListenableBuilder(
              valueListenable: addressSearch.addressesNotifier,
              builder: (context, addresses, child) {
                MapboxApiService api = Provider.of<MapboxApiService>(context);
                List<Text> texts =
                    addresses.map((e) => Text(e.address)).toList();
                return Column(
                  children: texts,
                );
              })
        ],
      ),
    );
  }
}
