import 'package:flutter/material.dart';
import 'package:app_rider/models/address.dart';

class AddressResult extends StatelessWidget {
  final Address address;
  final Function(Address)? callback;

  const AddressResult(this.address, {super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback!(address);
        }
      },
      child: Row(
        children: [
          Icon(Icons.pin_drop_sharp,
              color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text('${address.street}, ${address.place}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary)),
            ],
          )
        ],
      ),
    );
  }
}
