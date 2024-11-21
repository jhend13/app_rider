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

    Widget buildInputBox(TextEditingController controller,
        {Color? color, Color? bgColor, bool? enabled, String? hint}) {
      Color finalColor = color ?? theme.colorScheme.onPrimaryContainer;
      Color finalBgColor = bgColor ?? theme.colorScheme.primaryContainer;

      return IntrinsicHeight(
          child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: finalBgColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: SizedBox(
                height: double.infinity,
                child: Icon(Icons.place, color: finalColor)),
          ),
          Expanded(
            child: TextFormField(
                enabled: enabled ?? true,
                keyboardType: TextInputType.text,
                controller: controller,
                style: TextStyle(color: color),
                cursorColor: color,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: bgColor,
                    labelText: hint ?? '',
                    hintStyle:
                        theme.textTheme.labelLarge!.copyWith(color: color),
                    labelStyle: theme.textTheme.labelMedium!
                        .copyWith(fontSize: 15, color: color),
                    contentPadding: const EdgeInsets.all(5),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12))))),
          ),
        ],
      ));
    }

    return Column(
      children: [
        buildInputBox(TextEditingController(),
            enabled: false,
            color: theme.colorScheme.onTertiary,
            bgColor: theme.colorScheme.tertiary,
            hint: 'Current Location'), // normally disposed of
        const SizedBox(height: 10),
        buildInputBox(_textController,
            color: theme.colorScheme.onPrimary,
            bgColor: theme.colorScheme.primary,
            hint: 'Destination')
      ],
    );
  }
}
