class Address {
  final String address;
  final String country;
  final String street;
  String? name;
  final int? zipcode;

  Address(
      {required this.address,
      required this.country,
      required this.street,
      this.name,
      this.zipcode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        address: json['properties']['full_address'],
        country: 'US',
        street: '',
        name: json['properties']['name']);
  }

  Address.fromEmpty()
      : address = '',
        country = '',
        street = '',
        zipcode = 0;
}
