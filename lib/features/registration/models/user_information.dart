class UserInformation {
  String? name;
  String? email;
  String? password;
  String? securityCode;

  UserInformation({
    this.name,
    this.email,
    this.password,
    this.securityCode,
  });

  UserInformation copyWith({
    String? name,
    String? email,
    String? password,
    String? securityCode,
  }) {
    return UserInformation(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      securityCode: securityCode ?? this.securityCode,
    );
  }

  @override
  String toString() {
    return 'UserInformation(name: $name, email: $email, password: $password, securityCode: $securityCode)';
  }
}
