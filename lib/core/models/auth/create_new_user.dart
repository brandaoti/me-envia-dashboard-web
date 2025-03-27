import '../../../features/registration/models/models.dart';

class CreateNewUser {
  final String email;
  final String fullName;
  final String password;
  final String adminSecurityCode;

  const CreateNewUser({
    required this.email,
    required this.fullName,
    required this.password,
    required this.adminSecurityCode,
  });

  factory CreateNewUser.fromApi(
    UserInformation userInformation,
  ) {
    return CreateNewUser(
      fullName: userInformation.name ?? '',
      email: userInformation.email?.trim() ?? '',
      password: userInformation.password ?? '',
      adminSecurityCode: userInformation.securityCode ?? '',
    );
  }

  Map toMap() {
    return {
      'email': email,
      'name': fullName,
      'password': password,
      'adminSecurityCode': adminSecurityCode,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateNewUser &&
        other.fullName == fullName &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^ email.hashCode ^ password.hashCode;
  }

  @override
  String toString() {
    return 'CreateNewUser(email: $email, fullName: $fullName, password: $password, adminSecurityCode: $adminSecurityCode)';
  }
}
