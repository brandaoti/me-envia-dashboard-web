class Mail {
  final String name;
  final String email;
  final String phone;
  final String message;

  const Mail({
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });

  Map toMap() {
    return {
      'user_name': name,
      'user_email': email,
      'user_phone': phone,
      'user_message': message,
    };
  }

  @override
  String toString() {
    return 'Mail(name: $name, email: $email, phone: $phone, message: $message)';
  }
}
