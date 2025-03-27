typedef AddressList = List<Address>;

class Address {
  final String city;
  final String state;
  final String street;
  final String number;
  final String country;
  final String zipcode;
  final String neighborhood;
  final String? complement;

  const Address({
    required this.city,
    required this.state,
    required this.street,
    required this.number,
    required this.country,
    required this.zipcode,
    required this.complement,
    required this.neighborhood,
  });

  factory Address.fromJson(Map json) {
    return Address(
      city: json['city'],
      zipcode: json['cep'],
      state: json['state'],
      street: json['street'],
      number: json['number'],
      country: json['country'],
      neighborhood: json['neighborhood'],
      complement: json['additionalAddress'],
    );
  }

  Map toMap() {
    return {
      'city': city,
      'cep': zipcode,
      'state': state,
      'street': street,
      'number': number,
      'country': country,
      'neighborhood': neighborhood,
      'additionalAddress': complement,
    };
  }

  @override
  String toString() {
    return 'Address(city: $city, state: $state, street: $street, number: $number, country: $country, zipcode: $zipcode, neighborhood: $neighborhood, complement: $complement)';
  }
}
