class Address {
  final String address;
  final String country;
  final String place;
  final String street;
  final String name;
  final int? zipcode;

  Address(
      {required this.address,
      required this.country,
      required this.place,
      required this.street,
      required this.name,
      this.zipcode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        address: json['properties']['full_address'],
        country: json['properties']['context']['country']['name'],
        street: json['properties']['context']['street']['name'],
        place: json['properties']['context']['place']['name'],
        name: json['properties']['name']);
  }

  Address.fromEmpty()
      : address = '',
        country = '',
        place = '',
        street = '',
        name = '',
        zipcode = 0;
}
