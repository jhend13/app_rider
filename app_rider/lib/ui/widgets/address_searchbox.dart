import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_rider/services/api/mapbox_api.dart';
import 'package:app_rider/models/address.dart';

class AddressSearchbox extends StatelessWidget {
  AddressSearchbox({super.key});

  final TextEditingController _textController = TextEditingController();

  // results are reported back to anyone listneing to this notifier
  final ValueNotifier<List<Address>> addressesNotifier =
      ValueNotifier<List<Address>>([]);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mapboxApi = Provider.of<MapboxApiService>(context);

    DateTime lastApiRequest = DateTime.timestamp();
    bool loading = false;

    _textController.addListener(() async {
      if (loading) return;

      String input = _textController.text;
      DateTime now = DateTime.timestamp();

      // requirements to meet inbetween each api request:
      // min of 2 seconds & min of two characters
      if (input.length < 2) {
        addressesNotifier.value = [];
        return;
      }

      if (now.difference(lastApiRequest).inMilliseconds > 2000) {
        lastApiRequest = DateTime.timestamp();
        loading = true;
        List<Address> addresses = await mapboxApi.forwardLookup(input);
        loading = false;

        addressesNotifier.value = addresses;
      }
    });

    return TextFormField(
        keyboardType: TextInputType.text,
        controller: _textController,
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
            )));
  }
}
