import '../../types/enums/user_type.dart';
import 'address.dart';

class User {
  final String id;
  final String cpf;
  final String name;
  final String email;
  final UserType type;
  final Address address;
  final String phoneNumber;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.cpf,
    required this.type,
    required this.address,
    required this.phoneNumber,
  });

  factory User.fromJson(Map json) {
    return User(
      id: json['id'],
      cpf: json['cpf'],
      name: json['name'],
      email: json['email'],
      address: Address.fromJson(json),
      phoneNumber: json['phoneNumber'],
      type: (json['type'] as String).fromJson,
    );
  }

  factory User.fromPackage(Map json) {
    final userInfo = json['userInfo'];
    final addressInfo = (json['address'] as List);

    return User(
      id: userInfo['id'],
      type: UserType.user,
      cpf: userInfo['cpf'],
      name: userInfo['name'],
      email: userInfo['email'],
      phoneNumber: userInfo['phoneNumber'],
      address: Address.fromJson(addressInfo.first),
    );
  }

  factory User.fromInternalData(Map json) {
    return User(
      id: json['id'],
      cpf: json['cpf'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      type: (json['type'] as String).fromJson,
      address: Address.fromJson(json['address']),
    );
  }

  Map toMap() {
    return {
      'id': id,
      'cpf': cpf,
      'name': name,
      'email': email,
      'type': type.value,
      'phoneNumber': phoneNumber,
      'address': address.toMap(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.email == email &&
        other.cpf == cpf &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ cpf.hashCode ^ phoneNumber.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, cpf: $cpf, type: $type, address: $address, phoneNumber: $phoneNumber)';
  }
}
